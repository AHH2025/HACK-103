import 'dart:ui';
import 'package:complaint_manager/issue_preview.dart';
import 'package:complaint_manager/models/user_details_model.dart';
import 'package:flutter/material.dart';

class UserHomePage extends StatefulWidget {
  final Function(int) onPageChanged;

  const UserHomePage({Key? key, required this.onPageChanged}) : super(key: key);

  @override
  State<UserHomePage> createState() => _UserHomePageState();
}

class _UserHomePageState extends State<UserHomePage> {
  String userName = 'Guest';
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
        listenable: viewModel,
        builder: (context, _) {
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              automaticallyImplyLeading: false,
              titleSpacing: 0,
              title: Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            children: [
                              Text(
                                'Welcome, ${viewModel.currentUser!.name}',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 19,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            viewModel.currentUser!.userType,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            body: SafeArea(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.all(constraints.maxWidth * 0.04),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  Colors.purple.withOpacity(0.7),
                                  Colors.blue.withOpacity(0.7)
                                ],
                              ),
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.2),
                                  spreadRadius: 5,
                                  blurRadius: 7,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: BackdropFilter(
                                filter:
                                    ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                                child: Container(
                                  padding: EdgeInsets.all(
                                      constraints.maxWidth * 0.04),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(
                                        color: Colors.white.withOpacity(0.8)),
                                  ),
                                  child: Row(
                                    children: [
                                      Container(
                                        height: constraints.maxWidth * 0.28,
                                        width: constraints.maxWidth * 0.25,
                                        decoration: BoxDecoration(
                                          color: Colors.white.withOpacity(0.7),
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.deepPurple
                                                  .withOpacity(0.3),
                                              spreadRadius: 2,
                                              blurRadius: 5,
                                              offset: const Offset(0, 3),
                                            ),
                                          ],
                                        ),
                                        // child: Lottie.asset(
                                        //   'assets/animation/AnimationE.json',
                                        //   width: constraints.maxWidth * 0.2,
                                        //   height: constraints.maxWidth * 0.2,
                                        //   fit: BoxFit.contain,
                                        // ),
                                      ),
                                      SizedBox(
                                          width: constraints.maxWidth * 0.04),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Do you have any problems",
                                              style: TextStyle(
                                                fontSize: constraints.maxWidth *
                                                    0.045,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black87,
                                              ),
                                            ),
                                            SizedBox(
                                                height: constraints.maxHeight *
                                                    0.01),
                                            Text(
                                              "Help improve your community by reporting problems.",
                                              style: TextStyle(
                                                fontSize: constraints.maxWidth *
                                                    0.035,
                                                color: Colors.black54,
                                              ),
                                            ),
                                            SizedBox(
                                                height: constraints.maxHeight *
                                                    0.02),
                                            SizedBox(
                                              width: double.infinity,
                                              child: ElevatedButton(
                                                onPressed: () {
                                                  widget.onPageChanged(1);
                                                },
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor: Colors
                                                      .deepPurple
                                                      .withOpacity(0.8),
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            30),
                                                  ),
                                                  padding: EdgeInsets.symmetric(
                                                      vertical: constraints
                                                              .maxHeight *
                                                          0.015),
                                                  elevation: 5,
                                                ),
                                                child: const Text(
                                                    "Report Issue",
                                                    style: TextStyle(
                                                        color: Colors.white)),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 8),
                          // RoadIssuesDashboard(
                          //   userID: FirebaseAuth.instance.currentUser?.uid ?? ''),
                          Column(
                            children: List.generate(
                              viewModel.currentUser!.issues.length,
                              (index) => IssueCard(
                                  issue: viewModel.currentUser!.issues[index]),
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          );
        });
  }
}

class IssueCard extends StatelessWidget {
  final Issue issue;

  const IssueCard({Key? key, required this.issue}) : super(key: key);

  Color getPriorityColor(String priority) {
    switch (priority) {
      case "High":
        return Colors.red;
      case "Medium":
        return Colors.orange;
      case "Low":
        return Colors.green;
      default:
        return Colors.blueGrey;
    }
  }

  Color getStatusColor(String status) {
    switch (status) {
      case "Pending":
        return Colors.redAccent;
      case "In Progress":
        return Colors.orange;
      case "Resolved":
        return Colors.green;
      default:
        return Colors.blueGrey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => IssuePreviewPage(issue: issue),
            ));
      },
      child: Card(
        margin: EdgeInsets.all(10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 3,
        child: Padding(
          padding: EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${issue.category} - ${issue.subcategory}",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 4),
              Text("Affected Area: ${issue.affectedArea}",
                  style: TextStyle(fontSize: 14, color: Colors.grey[700])),
              SizedBox(height: 8),
              Text(issue.details,
                  style: TextStyle(fontSize: 14, color: Colors.black87)),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Chip(
                    label: Text(issue.priority),
                    backgroundColor: getPriorityColor(issue.priority),
                    labelStyle: TextStyle(color: Colors.white),
                  ),
                  Chip(
                    label: Text(issue.status),
                    backgroundColor: getStatusColor(issue.status),
                    labelStyle: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
