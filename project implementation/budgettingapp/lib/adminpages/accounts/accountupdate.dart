// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously, sort_child_properties_last, unused_element, camel_case_types

import 'dart:convert';
import 'package:flutter/material.dart';
import '../../animation/ScaleRoute.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';

import 'accountdata.dart';

void main() {
  runApp(const updateAccounts());
}

class updateAccounts extends StatefulWidget {
  const updateAccounts({Key? key}) : super(key: key);

  @override
  _updateAccountsState createState() => _updateAccountsState();
}

class _updateAccountsState extends State<updateAccounts> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController id = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController desc = TextEditingController();

  String? _validateMobile(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your mobile';
    }
    return null;
  }

  String? _validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your account name';
    }
    return null;
  }

  String? _validateDesc(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a description';
    }

    return null;
  }

  Future<void> senddata(BuildContext context) async {
    final response = await http.post(
      Uri.parse("http://localhost/admin/accounts_update.php"),
      body: {
        "account_id": id.text,
        "account_name": name.text,
        "account_desc": desc.text,
      },
    );

    final data = jsonDecode(response.body);
    if (data == "yey") {
      Fluttertoast.showToast(
        msg: "Account updation success",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      // Registration successful, pass account data to account list page and replace the current page
      Navigator.pushReplacement(
        context,
        ScaleRoute(
          page: const adminaccounts(),
        ),
      );
    } else {
      // Registration failed, show error message to user
      Fluttertoast.showToast(
        msg: "Account updation failed check phone number",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
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
            // ignore: prefer_const_constructors
            Text(
              'Update account',
              // ignore: prefer_const_constructors
              style: TextStyle(
                  fontSize: 25,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 30),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: TextFormField(
                        controller: id,
                        keyboardType: TextInputType.name,
                        // ignore: prefer_const_constructors
                        decoration: InputDecoration(
                          labelText: 'id',
                          hintText: 'Enter id',
                          prefixIcon: const Icon(Icons.person_2_rounded),
                          border: const OutlineInputBorder(),
                        ),
                      ),
                    ),
                    // ignore: prefer_const_constructors
                    SizedBox(
                      height: 30,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: TextFormField(
                        controller: name,
                        keyboardType: TextInputType.name,
                        // ignore: prefer_const_constructors
                        decoration: InputDecoration(
                          labelText: 'Account Name',
                          hintText: 'Enter Account Name',
                          prefixIcon: const Icon(Icons.person_2_rounded),
                          border: const OutlineInputBorder(),
                        ),
                      ),
                    ),
                    // ignore: prefer_const_constructors
                    SizedBox(
                      height: 30,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: TextFormField(
                        controller: desc,
                        decoration: const InputDecoration(
                          labelText: 'Description',
                          hintText: 'Enter Account description',
                          prefixIcon: Icon(Icons.lock),
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 150.0, right: 150.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          MaterialButton(
                            onPressed: () async {
                              senddata(context);
                            },
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            child: const Text('Save'),
                            color: Colors.teal,
                            textColor: Colors.black,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }
}
