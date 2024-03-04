// ignore_for_file: camel_case_types, library_private_types_in_public_api, use_build_context_synchronously

import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../animation/ScaleRoute.dart';
import '../adminwidgets.dart';
import 'budgetadd.dart';
import 'budgetupdate.dart';

class adminbudgets extends StatefulWidget {
  const adminbudgets({Key? key}) : super(key: key);

  @override
  _adminbudgetsState createState() => _adminbudgetsState();
}

class _adminbudgetsState extends State<adminbudgets> {
  List budgets = [];

  Future<void> getbudgets() async {
    final response = await http.get(
      Uri.parse("http://localhost/admin/budgets.php"),
    );

    final data = jsonDecode(response.body);
    setState(() {
      budgets = data['budget'];
    });
  }

  void exportBudgets(List budgets) async {
    // Create a new file
    final file = File('budgets.csv');

    // Write the headers to the file
    const header =
        'budget_id,budget_date,budget_ref,budget_desc,budget_occurrence,budget_wef,budget_wet,budget_estimated_amount,budget_accounts_id\n';
    await file.writeAsString(header);

    // Write the data to the file
    for (final budget in budgets) {
      final row =
          '${budget['budget_id']},${budget['budget_date']},${budget['budget_ref']},${budget['budget_desc']},${budget['budget_occurrence']},${budget['budget_wef']},${budget['budget_wet']},${budget['budget_estimated_amount']},${budget['budget_accounts_id']}\n';
      await file.writeAsString(row, mode: FileMode.append);
    }
// Show a dialog to notify the user that the file has been saved
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Export complete'),
          content: const Text('Budgets have been exported to budgets.csv'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    getbudgets();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const adminNavDrawer(),
      appBar: AppBar(
        title: const Text('Budget information'),
        backgroundColor: Colors.teal,
      ),
      body: ListView.builder(
          itemCount: budgets.length,
          itemBuilder: (BuildContext context, int index) {
            return Card(
              child: ListTile(
                //title: Text(budgets[index]['budget_id']),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(budgets[index]['budget_date']),
                    const SizedBox(
                        height: 8), // add some space between the rows
                    Text(budgets[index]['budget_ref']),
                    const SizedBox(height: 8),
                    Text(budgets[index]['budget_desc']),
                    const SizedBox(height: 8),
                    Text(budgets[index]['budget_occurrence']),
                    const SizedBox(height: 8),
                    Text(budgets[index]['budget_wef']),
                    const SizedBox(height: 8),
                    Text(budgets[index]['budget_wet']),
                    const SizedBox(height: 8),
                    Text(budgets[index]['budget_estimated_amount']),
                    const SizedBox(height: 8),
                    Text(budgets[index]['budget_accounts_id']),
                  ],
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () {
                        Navigator.push(
                            context, ScaleRoute(page: const updateBudget()));
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                      },
                    ),
                  ],
                ),
              ),
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, ScaleRoute(page: const Budget()));
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
                getbudgets();
              },
            ),
            IconButton(
              icon: const Icon(Icons.file_download),
              onPressed: () {
                exportBudgets(budgets);
              },
            ),
          ],
        ),
      ),
    );
  }
}
