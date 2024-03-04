// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'dart:async';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:mpesa_flutter_plugin/mpesa_flutter_plugin.dart';


void main() {
  //MpesaFlutterPlugin.setConsumerKey('Vc9dyOkVw4ZOxaFlYBuJahepCpwQ2KbM');
  //MpesaFlutterPlugin.setConsumerSecret('osOjEACKmMvszuy9');

  runApp(Deposits());
}

class Deposits extends StatefulWidget {
  @override
  _DepositsState createState() => _DepositsState();
}

class _DepositsState extends State<Deposits> {
  final _formKey = GlobalKey<FormState>();
  final _phoneController = TextEditingController();
  final _amountController = TextEditingController();
  final _nameController = TextEditingController();

  Future<void> startCheckout(
      BuildContext context, String userPhone, double amount) async {
    dynamic transactionInitialisation;

    try {
      transactionInitialisation =
          await MpesaFlutterPlugin.initializeMpesaSTKPush(
        businessShortCode: "174379",
        transactionType: TransactionType.CustomerPayBillOnline,
        amount: amount,
        partyA: userPhone,
        partyB: "174379",
        callBackURL: Uri(
          scheme: "https",
          host: "kariukijames.com",
          path: "/pesa/callback.php",
        ),
        accountReference: "budgetting app",
        phoneNumber: userPhone,
        baseUri: Uri(
          scheme: "https",
          host: "sandbox.safaricom.co.ke",
        ),
        transactionDesc: "deposit",
        passKey:
            "bfb279f9aa9bdbcf158e97dd71a467cd2e0c893059b10f78e6b72ada1ed2c919",
      );

      print("TRANSACTION RESULT: " + transactionInitialisation.toString());

      final response = await http
          .post(Uri.parse("http://localhost/login/deposits.php"), body: {
        "account_name": _nameController.text,
        "deposit_amount": amount.toString(),
      });

      print("PHP RESPONSE: " + response.body);

      return transactionInitialisation;
    } catch (e) {
      print("CAUGHT EXCEPTION: " + e.toString());
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
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        body: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    labelText: "Account Name",
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter your name";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _phoneController,
                  decoration: const InputDecoration(
                    labelText: "Phone Number",
                    hintText: 'e.g. 254712345678',
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter your phone number";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _amountController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: "Amount",
                    hintText: 'e.g. 100',
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter amount";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 32),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      final userPhone = _phoneController.text;
                      final amount = double.parse(_amountController.text);

                      startCheckout(context, userPhone, amount);
                    }
                  },
                  child: const Text("Pay with M-Pesa"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


