// ignore_for_file: library_private_types_in_public_api

import 'dart:convert';
import 'package:budgettingapp/dashboardpages/deposits.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../animation/ScaleRoute.dart';

class depositList extends StatefulWidget {
  const depositList({Key? key}) : super(key: key);

  @override
  _depositListState createState() => _depositListState();
}

class _depositListState extends State<depositList> {
  List deposit = [];

  Future<void> getDeposit() async {
    final response = await http.get(
      Uri.parse("http://localhost/login/get_deposits.php"),
    );

    final data = jsonDecode(response.body);
    setState(() {
      deposit = data['deposits'];
    });
  }

  @override
  void initState() {
    super.initState();
    getDeposit();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          PreferredSize(
            preferredSize: const Size.fromHeight(60.0),
            child: AppBar(
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              title: const Text('Deposits List'),
              backgroundColor: Colors.teal,
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.zero, // Set zero padding here
              child: ListView.builder(
                itemCount: deposit.length,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    child: ListTile(
                      //title:
                      // Text("Budget for account ${deposit[index]['account_name']}"),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                              "Deposit amount: ${deposit[index]['deposit_amount']}"),
                          const SizedBox(height: 8),
                          Text(
                              "Deposit date: ${deposit[index]['deposit_date']}"),
                          const SizedBox(height: 8),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, ScaleRoute(page: MyApp()));
        },
        backgroundColor: Colors.teal,
        child: const Icon(Icons.add),
      ),
    );
  }
}
