// ignore_for_file: camel_case_types, library_private_types_in_public_api, use_build_context_synchronously

import 'dart:convert';
import 'package:flutter/material.dart';
import '../../animation/ScaleRoute.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';

import '../../screens/registration.dart';
import 'userdata.dart';

void main() {
  runApp(const usersupdate());
}

class usersupdate extends StatefulWidget {
  const usersupdate({Key? key}) : super(key: key);

  @override
  _usersupdateState createState() => _usersupdateState();
}

class _usersupdateState extends State<usersupdate> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController name = TextEditingController();
  TextEditingController id = TextEditingController();
  TextEditingController mobile = TextEditingController();
  TextEditingController email = TextEditingController();

  String? _validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your name';
    }
    return null;
  }

  String? _validatemobile(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your name';
    }
    return null;
  }

  String? _validateemail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your name';
    }
    return null;
  }

  Future senddata(BuildContext cont) async {
    final response = await http
        .post(Uri.parse("http://localhost/admin/users_update.php"), body: {
      "user_full_name": name.text,
      "user_email": email.text,
      "user_mobile": mobile.text,
      "user_id": id.text,
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
      Navigator.push(context, ScaleRoute(page: const adminusers()));
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
      home: Scaffold(
        backgroundColor: Colors.teal[50],
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
                          labelText: 'user_id',
                          hintText: 'user_id',
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
                          labelText: 'User full name',
                          hintText: 'Enter User full name',
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
                        controller: mobile,
                        keyboardType: TextInputType.name,
                        decoration: const InputDecoration(
                          labelText: 'mobile',
                          hintText: 'Enter mobile',
                          prefixIcon: Icon(Icons.call_end_rounded),
                          border: OutlineInputBorder(),
                        ),
                        validator: _validatemobile,
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
                        controller: email,
                        keyboardType: TextInputType.name,
                        decoration: const InputDecoration(
                          labelText: 'email',
                          hintText: 'Enter email',
                          prefixIcon: Icon(Icons.attach_email_rounded),
                          border: OutlineInputBorder(),
                        ),
                        validator: _validateemail,
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
                        Navigator.push(context, ScaleRoute(page: const adminusers()));
                      },
                      child: const Text(
                        'Back to Users',
                        style: TextStyle(color: Colors.black, fontSize: 18),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                            context, ScaleRoute(page: const Registration()));
                      },
                      child: const Text(
                        'Update user Account',
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
