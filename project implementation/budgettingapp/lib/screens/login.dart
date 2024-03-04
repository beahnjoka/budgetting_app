// ignore_for_file: use_build_context_synchronously, library_private_types_in_public_api, camel_case_types

import 'dart:convert';

import 'package:flutter/material.dart';
import '../../animation/ScaleRoute.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../adminpages/login/logindata.dart';
import 'dashboard.dart';
import 'forgot.dart';
import 'signup.dart';

const _apiEndpoint = 'http://localhost/login/login.php';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  runApp(MaterialApp(
    title: 'Login Page',
    home: prefs.getBool('isLoggedIn') == true ? const isLoggedIn() : const Login(),
  ));
}

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscureText = true;

  Future<void> _login(BuildContext context) async {
    if (_nameController.text.isEmpty || _passwordController.text.isEmpty) {
      Fluttertoast.showToast(
        msg: 'The username and password cannot be empty',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
      );
    } else {
      try {
        final response = await http.post(Uri.parse(_apiEndpoint), body: {
          'login_username': _nameController.text,
          'login_password': _passwordController.text,
        });
        final data = json.decode(response.body);
        if (data == 'success') {
          final prefs = await SharedPreferences.getInstance();
          await prefs.setBool('isLoggedIn', true);
          await prefs.setString('username', _nameController.text);
          final username = _nameController.text;
          if (username == 'admin') {
            Navigator.push(context, ScaleRoute(page: const adminlogin()));
          } else {
            Navigator.push(context, ScaleRoute(page: const Dashboard()));
          }
        } else {
          Fluttertoast.showToast(
            msg: 'The username and password combination is incorrect',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
          );
        }
      } catch (e) {
        Fluttertoast.showToast(
          msg: 'An error occurred',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
        );
      }
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
            Text(
              'Login',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.teal[900],
              ),
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
                        controller: _nameController,
                        keyboardType: TextInputType.name,
                        decoration: const InputDecoration(
                          labelText: 'Username',
                          hintText: 'Enter Username',
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
                        controller: _passwordController,
                        obscureText: _obscureText,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          hintText: 'Enter Password',
                          border: const OutlineInputBorder(),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscureText
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                            onPressed: () {
                              setState(() {
                                _obscureText = !_obscureText;
                              });
                            },
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 150.0, right: 150.0),
                      child: MaterialButton(
                        onPressed: () {
                          _login(context);
                        },
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        color: Colors.teal[800],
                        child: const Text(
                          'login',
                          style: TextStyle(
                            fontSize: 18.0,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: () =>
                  {Navigator.push(context, ScaleRoute(page: const Forgot()))},
              child: Text(
                "Forgot password",
                style: TextStyle(
                  fontStyle: FontStyle.normal,
                  color: Colors.teal[900],
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Text(
              "Don't have an account? ",
              style: TextStyle(
                fontStyle: FontStyle.normal,
                color: Colors.teal[800],
              ),
            ),
            InkWell(
              onTap: () =>
                  {Navigator.push(context, ScaleRoute(page: const SignUp()))},
              child: const Text(
                "Create Account",
                style: TextStyle(
                  fontStyle: FontStyle.normal,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class isLoggedIn extends StatelessWidget {
  const isLoggedIn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Login Page',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Logged In'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text('You are already logged in!'),
              ElevatedButton(
                onPressed: () async {
                  final prefs = await SharedPreferences.getInstance();
                  await prefs.setBool('isLoggedIn', false);
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => const Login()),
                      (route) => false);
                },
                child: const Text('Logout'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
