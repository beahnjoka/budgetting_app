// ignore_for_file: non_constant_identifier_names, library_private_types_in_public_api, use_build_context_synchronously

import 'dart:convert';
import 'package:flutter/material.dart';
import '../../animation/ScaleRoute.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';

import 'login.dart';

void main() {
  runApp(const Registration());
}

class Registration extends StatefulWidget {
  const Registration({Key? key}) : super(key: key);

  @override
  _RegistrationState createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController name = TextEditingController();
  TextEditingController full_name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController mobile = TextEditingController();

  String? _validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your username';
    }
    return null;
  }

  String? _validatefullName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your full name';
    }
    return null;
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter an email';
    }

    return null;
  }

  String? _validateMobile(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your number start with 254';
    }

    return null;
  }

  Future<void> senddata(BuildContext context) async {
    final response = await http.post(
      Uri.parse("http://localhost/login/users.php"),
      body: {
        "login_username": name.text,
        "user_full_name": full_name.text,
        "user_email": email.text,
        "user_mobile": mobile.text,
      },
    );

    final data = jsonDecode(response.body);
    if (data == "success") {
      // Registration successful, navigate to Dashboard page
      Navigator.push(context, ScaleRoute(page: const Login()));
    } else {
      // Registration failed, show error message to user
      Fluttertoast.showToast(
        msg: "Registration failed check the email or phone number",
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
      home: Scaffold(
        backgroundColor: Colors.teal[50],
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'complete registration',
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
                        controller: name,
                        keyboardType: TextInputType.name,
                        decoration: const InputDecoration(
                          labelText: 'Username',
                          hintText: 'Enter Username',
                          prefixIcon: Icon(Icons.person_2_rounded),
                          border: OutlineInputBorder(),
                        ),
                        validator: _validateName,
                        autovalidateMode: AutovalidateMode.always,
                        onSaved: (value) => name.text = value!,
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: TextFormField(
                        controller: full_name,
                        keyboardType: TextInputType.name,
                        decoration: const InputDecoration(
                          labelText: 'Full Name',
                          hintText: 'Enter Full Name',
                          prefixIcon: Icon(Icons.person_2_rounded),
                          border: OutlineInputBorder(),
                        ),
                        validator: _validatefullName,
                        autovalidateMode: AutovalidateMode.always,
                        onSaved: (value) => full_name.text = value!,
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: TextFormField(
                        controller: email,
                        decoration: const InputDecoration(
                          labelText: 'Email',
                          hintText: 'Enter Email',
                          prefixIcon: Icon(Icons.lock),
                          border: OutlineInputBorder(),
                        ),
                        validator: _validateEmail,
                        autovalidateMode: AutovalidateMode.always,
                        onSaved: (value) => email.text = value!,
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: TextFormField(
                        controller: mobile,
                        decoration: const InputDecoration(
                          labelText: 'Mobile',
                          hintText: 'Enter Mobile',
                          prefixIcon: Icon(Icons.lock),
                          border: OutlineInputBorder(),
                        ),
                        validator: _validateMobile,
                        autovalidateMode: AutovalidateMode.always,
                        onSaved: (value) => mobile.text = value!,
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 150.0, right: 150.0),
                      child: MaterialButton(
                        onPressed: () async {
                          senddata(context);
                        },
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        color: Colors.teal,
                        textColor: Colors.black,
                        child: const Text('Submit'),
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
