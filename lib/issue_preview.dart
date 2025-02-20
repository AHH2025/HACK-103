import 'package:complaint_manager/models/user_details_model.dart';
import 'package:flutter/material.dart';

class IssuePreviewPage extends StatelessWidget {
  final Issue issue;

  const IssuePreviewPage({Key? key, required this.issue}) : super(key: key);

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
    return Scaffold(
      appBar: AppBar(
        title: Text("Issue Details"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          elevation: 5,
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  issue.category,
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 4),
                Text(
                  "Subcategory: ${issue.subcategory}",
                  style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                ),
                SizedBox(height: 10),
                Divider(),
                SizedBox(height: 10),
                Text(
                  "Affected Area: ${issue.affectedArea}",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
                SizedBox(height: 10),
                Text(
                  issue.details,
                  style: TextStyle(fontSize: 15, color: Colors.black87),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Chip(
                      label: Text("Priority: ${issue.priority}"),
                      backgroundColor: getPriorityColor(issue.priority),
                      labelStyle: TextStyle(color: Colors.white),
                    ),
                    Chip(
                      label: Text("Status: ${issue.status}"),
                      backgroundColor: getStatusColor(issue.status),
                      labelStyle: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
