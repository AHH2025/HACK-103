import 'package:flutter/material.dart';

UserDetailsModelVM viewModel = UserDetailsModelVM();

class UserDetailsModelVM with ChangeNotifier {
  UserDetailsModel _model = UserDetailsModel(users: [
    User(
      name: "John Doe",
      email: "admin@admin.com",
      password: "password123",
      phone: "+1234567890",
      userType: "Admin",
      isLoggedIn: false,
      issues: [
        Issue(
          category: "Product Issues",
          subcategory: "Defective Product",
          priority: "High",
          affectedArea: "Electronics",
          details: "Received a smartphone with a cracked screen.",
          status: "Pending",
        ),
        Issue(
          category: "Billing & Payments",
          subcategory: "Incorrect Billing",
          priority: "Medium",
          affectedArea: "Online Store",
          details: "Charged twice for the same order.",
          status: "Resolved",
        ),
      ],
    ),
    User(
      name: "Jane Smith",
      email: "janesmith@example.com",
      password: "securepass456",
      phone: "+9876543210",
      userType: "Customer",
      isLoggedIn: false,
      issues: [
        Issue(
          category: "Technical Support",
          subcategory: "Software Bugs/Errors",
          priority: "High",
          affectedArea: "Mobile App",
          details: "App crashes when submitting a complaint.",
          status: "In Progress",
        ),
      ],
    ),
    User(
      name: "Michael Brown",
      email: "michaelbrown@example.com",
      password: "pass7890",
      phone: "+1122334455",
      userType: "Employee",
      isLoggedIn: false,
      issues: [
        Issue(
          category: "Workplace Complaints",
          subcategory: "Harassment & Discrimination",
          priority: "Critical",
          affectedArea: "HR Department",
          details: "Filed a report regarding workplace harassment.",
          status: "Under Investigation",
        ),
      ],
    ),
  ]);
  User? get currentUser {
    for (var e in _model.users.indexed) {
      if (e.$2.isLoggedIn) {
        print(e.$2.email);
        return _model.users[e.$1];
      }
    }
    return null;
  }

  addUser(User user) {
    _model.users.add(user);
    notifyListeners();
  }

  addissue(Issue issue) {
    for (var e in _model.users.indexed) {
      if (e.$2.isLoggedIn) {
        _model.users[e.$1].issues.add(issue);
      }
    }
    notifyListeners();
  }

  bool validate(String email, String password) {
    for (var e in _model.users.indexed) {
      if (e.$2.email == email && e.$2.password == password) {
        print(e.$2.email);
        _model.users[e.$1].isLoggedIn = true;
      }
    }

    notifyListeners();
    return currentUser != null;
  }

  bool logOut() {
    for (var e in _model.users.indexed) {
      if (e.$2.isLoggedIn) {
        print(e.$2.email);
        _model.users[e.$1].isLoggedIn = false;
      }
    }

    notifyListeners();
    return currentUser != null;
  }

  UserDetailsModel get model => _model;
  updatemodel(UserDetailsModel model) {
    _model = model;
    notifyListeners();
  }
}

class UserDetailsModel {
  final List<User> users;

  UserDetailsModel({
    required this.users,
  });

  factory UserDetailsModel.fromJson(Map<String, dynamic> json) =>
      UserDetailsModel(
        users: List<User>.from(json["users"].map((x) => User.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "users": List<dynamic>.from(users.map((x) => x.toJson())),
      };
}

class User {
  final String name;
  final String email;
  final String password;
  final String phone;
  final String userType;
  bool isLoggedIn;
  final List<Issue> issues;

  User({
    required this.name,
    required this.email,
    required this.password,
    required this.phone,
    required this.userType,
    required this.isLoggedIn,
    required this.issues,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        name: json["name"],
        email: json["email"],
        password: json["password"],
        phone: json["phone"],
        userType: json["userType"],
        isLoggedIn: json["isLoggedIn"],
        issues: List<Issue>.from(json["issues"].map((x) => Issue.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "email": email,
        "password": password,
        "phone": phone,
        "userType": userType,
        "isLoggedIn": isLoggedIn,
        "issues": List<dynamic>.from(issues.map((x) => x.toJson())),
      };
}

class Issue {
  final String category;
  final String subcategory;
  final String priority;
  final String affectedArea;
  final String details;
  final String status;

  Issue({
    required this.category,
    required this.subcategory,
    required this.priority,
    required this.affectedArea,
    required this.details,
    required this.status,
  });

  factory Issue.fromJson(Map<String, dynamic> json) => Issue(
        category: json["category"],
        subcategory: json["subcategory"],
        priority: json["priority"],
        affectedArea: json["affectedArea"],
        details: json["details"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "category": category,
        "subcategory": subcategory,
        "priority": priority,
        "affectedArea": affectedArea,
        "details": details,
        "status": status,
      };
}
