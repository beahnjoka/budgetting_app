// ignore_for_file: use_build_context_synchronously, library_private_types_in_public_api, camel_case_types

import 'dart:convert';
import 'package:flutter/material.dart';
import '../../animation/ScaleRoute.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';

import '../../screens/login.dart';
import '../../screens/registration.dart';
import 'logindata.dart';

void main() {
  runApp(const loginupdate());
}

class loginupdate extends StatefulWidget {
  const loginupdate({Key? key}) : super(key: key);

  @override
  _loginupdateState createState() => _loginupdateState();
}

class _loginupdateState extends State<loginupdate> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController name = TextEditingController();
  TextEditingController id = TextEditingController();

  String? _validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your name';
    }
    return null;
  }

  Future senddata(BuildContext cont) async {
    final response = await http
        .post(Uri.parse("http://localhost/admin/login_update.php"), body: {
      "login_username": name.text,
      "login_id": id.text,
    });
    var data = json.decode(response.body);
    if (data == 'success') {
      // Username updated successfully, navigate to admin login page
      Fluttertoast.showToast(
          msg: "Username updated successfully",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 2,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 16.0);
      Navigator.push(context, ScaleRoute(page: const adminlogin()));
    } else {
      Fluttertoast.showToast(
          msg: "Error updating username",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 2,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 16.0);
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
            const Text(
              'Update Account',
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
                        decoration: const InputDecoration(
                          labelText: 'login_id',
                          hintText: 'login_id',
                          prefixIcon: Icon(Icons.person_2_rounded),
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
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
                    SizedBox(
                      width: 200,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            senddata(context);
                          }
                        },
                        child: const Text(
                          'Update',
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(context, ScaleRoute(page: const Login()));
                      },
                      child: const Text(
                        'Back to Login',
                        style: TextStyle(color: Colors.black, fontSize: 18),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                            context, ScaleRoute(page: const Registration()));
                      },
                      child: const Text(
                        'Create an Account',
                        style: TextStyle(color: Colors.black, fontSize: 18),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
