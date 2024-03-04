// ignore_for_file: camel_case_types, library_private_types_in_public_api

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../animation/ScaleRoute.dart';
import '../adminwidgets.dart';
import 'accountadd.dart';
import 'accountupdate.dart';

class adminaccounts extends StatefulWidget {
  const adminaccounts({Key? key}) : super(key: key);

  @override
  _adminaccountsState createState() => _adminaccountsState();
}

class _adminaccountsState extends State<adminaccounts> {
  List accounts = [];

  Future<void> getAccounts() async {
    final response = await http.get(
      Uri.parse("http://localhost/admin/accounts.php"),
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
      drawer: const adminNavDrawer(),
      appBar: AppBar(
        title: const Text('Admin panel'),
        backgroundColor: Colors.teal,
      ),
      body: ListView.builder(
          itemCount: accounts.length,
          itemBuilder: (BuildContext context, int index) {
            return Card(
              child: ListTile(
                //title: Text(accounts[index]['account_user_id']),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(accounts[index]['account_name']),
                    const SizedBox(
                        height: 8), // add some space between the rows
                    Text(accounts[index]['account_desc']),
                  ],
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () {
                        Navigator.push(
                            context, ScaleRoute(page: const updateAccounts()));
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, ScaleRoute(page: const addAccounts()));
        },
        tooltip: 'Add',
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: const Icon(Icons.refresh),
              onPressed: () {
                getAccounts();
              },
            ),
            IconButton(
              icon: const Icon(Icons.outbox_outlined),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
