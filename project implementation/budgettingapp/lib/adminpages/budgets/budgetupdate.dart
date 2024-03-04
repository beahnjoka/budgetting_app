// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously, sort_child_properties_last, camel_case_types

import 'dart:convert';
import 'package:flutter/material.dart';
import '../../animation/ScaleRoute.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';

import 'budgetdata.dart';

void main() {
  runApp(const updateBudget());
}

class updateBudget extends StatefulWidget {
  const updateBudget({Key? key}) : super(key: key);

  @override
  _updateBudgetState createState() => _updateBudgetState();
}

class _updateBudgetState extends State<updateBudget> {
  final _formKey = GlobalKey<FormState>();
  final id = TextEditingController();
  final budgetReference = TextEditingController();
  final description = TextEditingController();
  final effectiveFrom = TextEditingController();
  final effectiveTo = TextEditingController();
  final estimatedAmount = TextEditingController();
  final occurance = TextEditingController();
  final currentd = TextEditingController();

  late DateTime effectiveToDate;
  late DateTime effectiveFromDate;
  late DateTime currentdDate;

  Future<void> senddata(BuildContext context) async {
    final response = await http.post(
      Uri.parse("http://localhost/admin/budgets_update.php"),
      body: {
        'budget_date': currentd.text,
        'budget_ref': budgetReference.text,
        'budget_desc': description.text,
        'budget_occurrence': occurance.text,
        'budget_wef': effectiveFrom.text,
        'budget_wet': effectiveTo.text,
        'budget_estimated_amount': estimatedAmount.text,
        'budget_id': id.text,
      },
    );

    final data = jsonDecode(response.body);
    if (data == "yey") {
      Fluttertoast.showToast(
        msg: "Budget updated",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.teal,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      // Registration successful, pass account data to account list page and replace the current page
      Navigator.pushReplacement(
        context,
        ScaleRoute(
          page: const adminbudgets(),
        ),
      );
    } else {
      // Registration failed, show error message to user
      Fluttertoast.showToast(
        msg: "Budget update failed",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }

  @override
  void dispose() {
    id.dispose();
    budgetReference.dispose();
    description.dispose();
    effectiveFrom.dispose();
    effectiveTo.dispose();
    estimatedAmount.dispose();
    occurance.dispose();
    currentd.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
         debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: Scaffold(
        backgroundColor: Colors.teal[50],
        appBar: AppBar(
          title: const Text(""),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
          body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  'Update Budget',
                  style: TextStyle(
                      fontSize: 25,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: TextFormField(
                            controller: id,
                            decoration: const InputDecoration(
                                labelText: 'Budget id'),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter account name';
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: TextFormField(
                            controller: description,
                            decoration:
                                const InputDecoration(labelText: 'Description'),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter description';
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: TextFormField(
                            controller: occurance,
                            decoration:
                                const InputDecoration(labelText: 'Occurrence'),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter occurrence';
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: TextFormField(
                            controller: effectiveFrom,
                            decoration: const InputDecoration(
                                labelText: 'Effective From (yyyy-mm-dd)'),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter effective from date';
                              }
                              return null;
                            },
                            onTap: () async {
// Opens up a date picker dialog
                              final pickedDate = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(2010),
                                  lastDate: DateTime(2050));
                              if (pickedDate != null) {
                                setState(() {
                                  effectiveFromDate = pickedDate;
                                  effectiveFrom.text = effectiveFromDate
                                      .toString()
                                      .substring(0, 10);
                                });
                              }
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: TextFormField(
                            controller: effectiveTo,
                            decoration: const InputDecoration(
                                labelText: 'Effective To (yyyy-mm-dd)'),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter effective to date';
                              }
                              return null;
                            },
                            onTap: () async {
                              // Opens up a date picker dialog
                              final pickedDate = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(2010),
                                  lastDate: DateTime(2050));

                              if (pickedDate != null) {
                                setState(() {
                                  effectiveToDate = pickedDate;
                                  effectiveTo.text = effectiveToDate
                                      .toString()
                                      .substring(0, 10);
                                });
                              }
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: TextFormField(
                            controller: estimatedAmount,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                                labelText: 'Estimated Amt'),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter estimated amount';
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: TextFormField(
                            controller: currentd,
                            decoration: const InputDecoration(
                                labelText: 'Current Date (yyyy-mm-dd)'),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter current date';
                              }
                              return null;
                            },
                            onTap: () async {
// Opens up a date picker dialog
                              final pickedDate = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(2010),
                                  lastDate: DateTime(2050));

                              if (pickedDate != null) {
                                setState(() {
                                  currentdDate = pickedDate;
                                  currentd.text =
                                      currentdDate.toString().substring(0, 10);
                                });
                              }
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            // Validate returns true if the form is valid, or false otherwise.
                            if (_formKey.currentState!.validate()) {
                              // Send data to server
                              senddata(context);
                            }
                          },
                          child: const Text('Submit'),
                        ),
                      ],
                    ),
                  ),
                ),
              ]),
        ));
  }
}
