// ignore_for_file: sort_child_properties_last, library_private_types_in_public_api

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
//import 'editaccount.dart';
import '../../animation/ScaleRoute.dart';
import 'budget.dart';

class BudgetList extends StatefulWidget {
  const BudgetList({Key? key}) : super(key: key);

  @override
  _BudgetListState createState() => _BudgetListState();
}

class _BudgetListState extends State<BudgetList> {
  List budget = [];

  Future<void> getBudgets() async {
    final response = await http.get(
      Uri.parse("http://localhost/login/get_budgets.php"),
    );

    final data = jsonDecode(response.body);
    setState(() {
      budget = data['budget'];
    });
  }

  @override
  void initState() {
    super.initState();
    getBudgets();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Budget List'),
        backgroundColor: Colors.teal,
      ),
      body: ListView.builder(
        itemCount: budget.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            child: ListTile(
              title:
                  Text("Budget for account ${budget[index]['account_name']}"),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Description: ${budget[index]['budget_desc']}"),
                  const SizedBox(height: 8),
                  Text(
                      "Estimated Amount: ${budget[index]['budget_estimated_amount']}"),
                  const SizedBox(height: 8),
                  Text(
                      "Duration: ${budget[index]['budget_wef']} - ${budget[index]['budget_wet']}"),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, ScaleRoute(page: const Budgett()));
        },
        child: const Icon(Icons.add),
        backgroundColor: Colors.teal,
      ),
    );
  }
}
