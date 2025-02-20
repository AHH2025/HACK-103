import 'package:complaint_manager/models/user_details_model.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: viewModel,
      builder: (context, child) => Scaffold(
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Column(
            children: <Widget>[
              const SizedBox(height: 2),
              const ProfilePic(),
              const SizedBox(height: 2),
              ...[
                const SizedBox(height: 20),
                ListView(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  children: [
                    ProfileMenu(
                      text: "Personal Information",
                      icon: const Icon(Icons.person_outline,
                          color: Colors.deepPurple),
                      press: () {
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //       builder: (context) =>
                        //           PersonalInformationPage()),
                        // );
                      },
                    ),
                    ProfileMenu(
                      text: "Settings",
                      icon: const Icon(Icons.settings_outlined,
                          color: Colors.deepPurple),
                      press: () {
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //       builder: (context) => UserSettingsPage()),
                        // );
                      },
                    ),
                    ProfileMenu(
                      text: "Invite a Friend",
                      icon: const Icon(Icons.person_add_alt_1_outlined,
                          color: Colors.deepPurple),
                      press: () {
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //       builder: (context) => InvitePage()),
                        // );
                      },
                    ),
                    ProfileMenu(
                      text: "Feedback",
                      icon: const Icon(Icons.feedback_outlined,
                          color: Colors.deepPurple),
                      press: () {
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //       builder: (context) => FeedbackPage()),
                        // );
                      },
                    ),
                    ProfileMenu(
                      text: "Log Out",
                      icon: const Icon(Icons.logout, color: Colors.deepPurple),
                      press: () {
                        viewModel.logOut();
                      },
                    ),
                  ],
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class ProfilePic extends StatefulWidget {
  const ProfilePic({Key? key}) : super(key: key);

  @override
  _ProfilePicState createState() => _ProfilePicState();
}

class _ProfilePicState extends State<ProfilePic> {
  @override
  void initState() {
    super.initState();
  }

  Widget _buildTextFields() {
    return Column(
      children: [
        Text(
          viewModel.currentUser!.name,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        Text(
          viewModel.currentUser!.email,
          style: const TextStyle(
            fontSize: 14,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 30.0),
          child: SizedBox(
            height: 85,
            width: 85,
            child: CircleAvatar(
              backgroundImage:
                  const AssetImage("assets/profile.png") as ImageProvider,
            ),
          ),
        ),
        const SizedBox(height: 8),
        _buildTextFields(),
      ],
    );
  }
}

class ProfileMenu extends StatelessWidget {
  const ProfileMenu({
    Key? key,
    required this.text,
    required this.icon,
    this.press,
  }) : super(key: key);

  final String text;
  final Icon icon;
  final VoidCallback? press;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double horizontalPadding = screenWidth * 0.04; // 4% of screen width
    double iconTextSpacing = screenWidth * 0.05; // 5% of screen width

    return GestureDetector(
      onTap: press,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Container(
          margin: EdgeInsets.symmetric(
              horizontal: horizontalPadding), // Responsive margin
          decoration: BoxDecoration(
            color: const Color(0xFFF5F6F9),
            borderRadius: BorderRadius.circular(30),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  icon,
                  SizedBox(width: iconTextSpacing), // Responsive spacing
                  ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: screenWidth * 0.5),
                    child: Text(
                      text,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.black87,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
              const Icon(
                Icons.arrow_forward_ios,
                color: Colors.grey,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
