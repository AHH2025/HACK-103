from flask import Flask, render_template, request, redirect, url_for, flash
from flask_sqlalchemy import SQLAlchemy
from flask_login import LoginManager, UserMixin, login_user, login_required, logout_user, current_user
from werkzeug.security import generate_password_hash, check_password_hash

app = Flask(__name__)

# Database Configuration
app.config['SQLALCHEMY_DATABASE_URI'] = 'sqlite:///complaints.db'
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False
app.config['SECRET_KEY'] = 'your_secret_key'

db = SQLAlchemy(app)
login_manager = LoginManager(app)
login_manager.login_view = 'login'

# User Model
class User(UserMixin, db.Model):
    id = db.Column(db.Integer, primary_key=True)
    username = db.Column(db.String(100), unique=True, nullable=False)
    password_hash = db.Column(db.String(200), nullable=False)  # Changed to store hashed passwords

    def set_password(self, password):
        self.password_hash = generate_password_hash(password)

    def check_password(self, password):
        return check_password_hash(self.password_hash, password)

# Complaint Model
class Complaint(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    user_id = db.Column(db.Integer, db.ForeignKey('user.id'), nullable=False)
    category = db.Column(db.String(100), nullable=False)
    description = db.Column(db.Text, nullable=False)
    status = db.Column(db.String(20), default='Pending')
    priority = db.Column(db.String(20), default='Medium')

@login_manager.user_loader
def load_user(user_id):
    return User.query.get(int(user_id))

@app.route('/')
def home():
    if current_user.is_authenticated:
        return redirect(url_for('dashboard'))
    return redirect(url_for('login'))

@app.route('/register', methods=['GET', 'POST'])
def register():
    if request.method == 'POST':
        username = request.form['username']
        password = request.form['password']

        # Check if username already exists
        if User.query.filter_by(username=username).first():
            flash("Username already taken!", "danger")
            return redirect(url_for('register'))

        new_user = User(username=username)
        new_user.set_password(password)  # Hashing the password
        db.session.add(new_user)
        db.session.commit()

        flash("User registered successfully!", "success")
        return redirect(url_for('login'))

    return render_template('register.html')

@app.route('/login', methods=['GET', 'POST'])
def login():
    if request.method == 'POST':
        username = request.form['username']
        password = request.form['password']

        user = User.query.filter_by(username=username).first()

        if user and user.check_password(password):
            login_user(user)
            return redirect(url_for('dashboard'))

        flash("Invalid login credentials!", "danger")

    return render_template('login.html')

@app.route('/logout')
@login_required
def logout():
    logout_user()
    flash("Logged out successfully!", "info")
    return redirect(url_for('login'))

@app.route('/dashboard')
@login_required
def dashboard():
    complaints = Complaint.query.filter_by(user_id=current_user.id).all()
    return render_template('dashboard.html', complaints=complaints)

@app.route('/complaint', methods=['GET', 'POST'])
@login_required
def complaint():
    if request.method == 'POST':
        category = request.form['category']
        description = request.form['description']
        priority = request.form['priority']

        new_complaint = Complaint(user_id=current_user.id, category=category, description=description, priority=priority)
        db.session.add(new_complaint)
        db.session.commit()

        flash("Complaint submitted successfully!", "success")
        return redirect(url_for('dashboard'))

    return render_template('complaint.html')

@app.route('/update_status/<int:complaint_id>/<status>')
@login_required
def update_status(complaint_id, status):
    complaint = Complaint.query.get(complaint_id)
    if complaint and complaint.user_id == current_user.id:  # Ensure users can update only their complaints
        complaint.status = status
        db.session.commit()
        flash("Complaint status updated!", "success")
    else:
        flash("Unauthorized action!", "danger")

    return redirect(url_for('dashboard'))

# Ensure tables are created properly
with app.app_context():
    db.create_all()

if __name__ == '__main__':
    app.run(debug=True)
