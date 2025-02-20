import 'dart:math';
import 'package:complaint_manager/models/user_details_model.dart';
import 'package:flutter/material.dart';

class RegisterComplaintForm extends StatefulWidget {
  const RegisterComplaintForm({super.key, required this.onPageChanged});
  final Function(int) onPageChanged;
  @override
  State<RegisterComplaintForm> createState() => _RegisterComplaintFormState();
}

class _RegisterComplaintFormState extends State<RegisterComplaintForm> {
  String? address;
  final _formKey = GlobalKey<FormState>();
  final bool _isSubmitting = false;
  bool _isLoading = true;

  // Controllers for form fields
  final TextEditingController _complaintDetailsController =
      TextEditingController();

  final TextEditingController addressController = TextEditingController();

  // Variables to store selected values
  String? _category;
  String? _complaintType;
  String? _priority = 'Low';

  //String _wardNumber = '';

  @override
  void initState() {
    super.initState();
    _loadInitialData();
  }

  @override
  void dispose() {
    _complaintDetailsController.dispose();
    addressController.dispose();
    super.dispose();
  }

  Future<void> _loadInitialData() async {
    // Perform any initial data loading here
    // For example, you might want to check if the user has already uploaded an ID

    // Simulate a delay for demonstration purposes
    await Future.delayed(Duration(seconds: 1));

    // When done, set _isLoading to false
    setState(() {
      _isLoading = false;
    });
  }

  //validations

  String? validateComplaintType(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please select a complaint type.';
    }
    return null;
  }

  String? validateMobileNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your mobile number';
    } else if (!RegExp(r'^(98|97)\d{8}$').hasMatch(value)) {
      return 'Please enter a valid Nepali mobile number';
    }
    return null;
  }

  void _showSuccessDialog(BuildContext context, String complaintId) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
          child: Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.green[50],
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 10.0,
                  offset: const Offset(0.0, 10.0),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Icon(
                  Icons.check_circle,
                  color: Colors.green[800],
                  size: 80,
                ),
                SizedBox(height: 20),
                Text(
                  'Success!',
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.green[800],
                    fontFamily: 'Roboto',
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  'Your complaint has been submitted successfully!',
                  style: TextStyle(
                    fontSize: 18,
                    fontFamily: 'Roboto',
                    height: 1.5,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20),
                Text(
                  'Complaint ID: $complaintId',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Roboto',
                    height: 1.5,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'Please keep this ID for future reference.',
                  style: TextStyle(
                    fontSize: 14,
                    fontFamily: 'Roboto',
                    height: 1.5,
                  ),
                ),
                SizedBox(height: 24),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  ),
                  child: Text(
                    'OK',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontFamily: 'Roboto',
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                    widget.onPageChanged(0);
                    // Optionally, navigate to a new screen or refresh the current one
                    // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen()));
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      viewModel.addissue(Issue(
          category: _category ?? "",
          subcategory: _complaintType ?? "",
          priority: _priority ?? "",
          affectedArea: addressController.text,
          details: _complaintDetailsController.text,
          status: "Pending"));
      _showSuccessDialog(context, (Random().nextInt(1000) + 1000).toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double formWidth = screenWidth > 600 ? 600 : screenWidth * 0.9;
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: formWidth),
                  child: _isLoading
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              const SizedBox(height: 4),
                              _buildProblemCategoryField(),
                              const SizedBox(height: 17),
                              _buildIssueTypeField(),
                              if (_category != 'Other' &&
                                  _complaintType == 'Other')
                                Padding(
                                  padding: const EdgeInsets.only(top: 17.0),
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                      labelText: 'Specify Other Sub Category',
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                    onChanged: (value) {
                                      setState(() {});
                                    },
                                  ),
                                ),
                              const SizedBox(height: 17),
                              DropdownButtonFormField<String>(
                                value: "Low",
                                decoration: InputDecoration(
                                  labelText: 'Priority',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                items: <String>[
                                  'High',
                                  'Medium',
                                  'Low',
                                ].map((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  setState(() {
                                    _priority = value;
                                  });
                                },
                              ),
                              const SizedBox(height: 17),
                              TextFormField(
                                controller: addressController,
                                decoration: InputDecoration(
                                  labelText: 'Affected Area',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter affected Area';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 17),
                              TextFormField(
                                validator: (value) =>
                                    (value == null || value.isEmpty)
                                        ? 'Please enter complaint details'
                                        : null,
                                controller: _complaintDetailsController,
                                decoration: InputDecoration(
                                  labelText: 'Complaint Details',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                maxLines: 3,
                              ),
                              const SizedBox(height: 20),
                              Center(
                                child: SizedBox(
                                  width: 120,
                                  height: 49,
                                  child: ElevatedButton(
                                    onPressed: _submitForm,
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: _isSubmitting
                                          ? Colors.greenAccent
                                          : Colors.blueAccent,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                    child: const Text(
                                      'Submit',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                ),
              ),
            ),
          ),
          if (_isSubmitting)
            Container(
              color: Colors.black54,
              child: const Center(
                child: CircularProgressIndicator(
                  color: Colors.deepPurple,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildProblemCategoryField() {
    return Column(
      children: [
        DropdownButtonFormField<String>(
          decoration: InputDecoration(
            labelText: 'Category',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          value: _category,
          validator: (value) => (value == null || value.isEmpty)
              ? 'Please select a category'
              : null,
          items: <String>{
            "Product Issues",
            "Service Issues",
            "Billing & Payments",
            "Technical Support",
            "Delivery & Logistics",
            "Legal & Compliance",
          }.map((String value) {
            // Ensure uniqueness with .toSet()
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          onChanged: (value) {
            setState(() {
              _category = value;
              _complaintType = null;
            });
          },
        ),
        if (_category == 'Other')
          Padding(
            padding: const EdgeInsets.only(top: 17.0),
            child: TextFormField(
              decoration: InputDecoration(
                labelText: 'Specify Other Category',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onChanged: (value) {
                setState(() {});
              },
            ),
          ),
      ],
    );
  }

  Widget _buildIssueTypeField() {
    if (_category == 'Other') {
      return TextFormField(
        decoration: InputDecoration(
          labelText: 'Specify Issue Type',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onChanged: (value) {
          setState(() {});
        },
      );
    }

    List<String> issueTypes = _getIssueTypesForCategory(_category)
        .toSet()
        .toList(); // Ensure uniqueness

    return Column(
      children: [
        DropdownButtonFormField<String>(
          validator: (value) => (value == null || value.isEmpty)
              ? 'Please select a subcategory'
              : null,
          decoration: InputDecoration(
            labelText: 'Sub Category',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          value: _complaintType,
          items: issueTypes.map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value, overflow: TextOverflow.ellipsis),
            );
          }).toList(),
          onChanged: (value) {
            setState(() {
              _complaintType = value;
              if (value == 'Other') {}
            });
          },
        ),
        // if (_complaintType == 'Other')
        //   Padding(
        //     padding: const EdgeInsets.only(top: 17.0),
        //     child: TextFormField(
        //       decoration: InputDecoration(
        //         labelText: 'Specify Other Issue Type',
        //         border: OutlineInputBorder(
        //           borderRadius: BorderRadius.circular(10),
        //         ),
        //       ),
        //       onChanged: (value) {
        //         setState(() {
        //           _customIssueType = value;
        //         });
        //       },
        //     ),
        //   ),
      ],
    );
  }

  List<String> _getIssueTypesForCategory(String? category) {
    switch (category) {
      case 'Product Issues':
        return [
          "Defective Product",
          "Wrong Item Delivered",
          "Missing Parts/Accessories",
          "Product Not as Described",
          "Warranty Issues",
        ];
      case 'Service Issues':
        return [
          "Poor Customer Service",
          "Delayed Service",
          "Unresolved Issues",
          "Unprofessional Staff",
        ];
      case 'Billing & Payments':
        return [
          "Overcharging",
          "Incorrect Billing",
          "Unauthorized Transactions",
          "Refund Issues",
          "Payment Processing Error"
        ];
      case 'Technical Support':
        return [
          "Software Bugs/Errors",
          "Hardware Malfunction",
          "Connectivity Issues",
          "System Downtime"
        ];
      case 'Delivery & Logistics':
        return [
          "Late Delivery",
          "Lost Shipment",
          "Damaged Package",
          "Incorrect Address Issues"
        ];
      case 'Legal & Compliance':
        return [
          "Privacy Violation",
          "Fraud/Scams",
          "Terms of Service Violation",
          "Misleading Advertisement"
        ];

      case 'Other':
        return ['Please specify'];
      default:
        return ['Other'];
    }
  }
}

class OopsScreen extends StatelessWidget {
  final String message;

  OopsScreen({required this.message});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset('assets/oops.png'),
              SizedBox(height: 20),
              Text(
                'Oops!',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Text(
                message,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  'TRY AGAIN',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
