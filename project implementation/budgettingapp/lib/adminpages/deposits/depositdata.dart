import 'dart:convert';
import 'package:budgettingapp/adminpages/deposits/depositadd.dart';
import 'package:budgettingapp/adminpages/deposits/depositupdate.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../animation/ScaleRoute.dart';
import '../adminwidgets.dart';

class admindeposits extends StatefulWidget {
  const admindeposits({Key? key}) : super(key: key);

  @override
  _admindepositsState createState() => _admindepositsState();
}

class _admindepositsState extends State<admindeposits> {
  List deposits = [];

  Future<void> getdeposits() async {
    final response = await http.get(
      Uri.parse("http://localhost/admin/deposits.php"),
    );

    final data = jsonDecode(response.body);
    setState(() {
      deposits = data['deposits'];
    });
  }

  @override
  void initState() {
    super.initState();
    getdeposits();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: adminNavDrawer(),
      appBar: AppBar(
        title: const Text('deposits information'),
        backgroundColor: Colors.teal,
      ),
      body: ListView.builder(
          itemCount: deposits.length,
          itemBuilder: (BuildContext context, int index) {
            return Card(
              child: ListTile(
                //title: Text(deposits[index]['deposit_id']),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(deposits[index]['deposit_code']),
                    const SizedBox(
                        height: 8), // add some space between the rows
                    Text(deposits[index]['deposit_date']),
                    const SizedBox(height: 8),
                    Text(deposits[index]['deposit_amount']),
                    const SizedBox(height: 8),
                    Text(deposits[index]['deposit_account_id']),
                  ],
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () {
                        Navigator.push(
                            context, ScaleRoute(page: const updateDeposits()));
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        // TODO: Implement delete functionality
                      },
                    ),
                  ],
                ),
              ),
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, ScaleRoute(page: Deposits()));
        },
        tooltip: 'Add',
        child: Icon(Icons.add),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: Icon(Icons.refresh),
              onPressed: () {
                getdeposits();
              },
            ),
            IconButton(
              icon: const Icon(Icons.outbox_outlined),
              onPressed: () {
                // TODO: Implement export functionality
              },
            ),
          ],
        ),
      ),
    );
  }
}
