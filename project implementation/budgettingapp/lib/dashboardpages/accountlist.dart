// ignore_for_file: library_private_types_in_public_api

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../animation/ScaleRoute.dart';
import 'accounts.dart';
import 'budgetlist.dart';

class AccountList extends StatefulWidget {
  const AccountList({Key? key}) : super(key: key);

  @override
  _AccountListState createState() => _AccountListState();
}

class _AccountListState extends State<AccountList> {
  List accounts = [];

  Future<void> getAccounts() async {
    final response = await http.get(
      Uri.parse("http://localhost/login/get_accounts.php"),
    );

    final data = jsonDecode(response.body);
    setState(() {
      accounts = data['accounts'];
    });
  }

  @override
  void initState() {
    super.initState();
    getAccounts();
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
              title: const Text('Account List'),
              backgroundColor: Colors.teal,
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.zero, // Set zero padding here
              child: ListView.builder(
                itemCount: accounts.length,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    child: ListTile(
                      title: Text(accounts[index]['account_name']),
                      subtitle: Text(accounts[index]['account_desc']),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const BudgetList(),
                          ),
                        );
                      },
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
          Navigator.push(context, ScaleRoute(page: const Accounts()));
        },
        backgroundColor: Colors.teal,
        child: const Icon(Icons.add),
      ),
    );
  }
}
