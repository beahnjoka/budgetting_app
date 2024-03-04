// ignore_for_file: library_private_types_in_public_api, unnecessary_new, prefer_const_constructors, sort_child_properties_last, duplicate_ignore

import 'package:flutter/material.dart';

void main() {
  runApp(const Forgot());
}

class Forgot extends StatefulWidget {
  const Forgot({Key? key}) : super(key: key);

  @override
  _ForgotState createState() => _ForgotState();
}

class _ForgotState extends State<Forgot> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // ignore: prefer_const_constructors
            Text(
              'Forgot Password',
              // ignore: prefer_const_constructors
              style: TextStyle(
                  fontSize: 25,
                  color: Colors.blue,
                  fontWeight: FontWeight.normal),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 30),
              child: Form(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: TextFormField(
                          keyboardType: TextInputType.name,
                          // ignore: prefer_const_constructors
                          decoration: InputDecoration(
                            labelText: 'Email address',
                            hintText: 'Enter email address',
                            prefixIcon: const Icon(Icons.email_rounded),
                            border: const OutlineInputBorder(),
                          ),
                          onChanged: (String value) {},
                          validator: (value) {
                            return value!.isEmpty
                                ? 'please enter your email'
                                : null;
                          }),
                    ),
                    // ignore: prefer_const_constructors
                    SizedBox(
                      height: 30,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 150.0, right: 150.0),
                      child: MaterialButton(
                        onPressed: () {},
                        shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(30.0),
                        ),
                        child: Text('submit'),
                        color: Colors.blue,
                        textColor: Colors.black,
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
