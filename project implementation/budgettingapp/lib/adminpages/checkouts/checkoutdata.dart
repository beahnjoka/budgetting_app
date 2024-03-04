import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../adminwidgets.dart';

class admincheckouts extends StatefulWidget {
  const admincheckouts({Key? key}) : super(key: key);

  @override
  _admincheckoutsState createState() => _admincheckoutsState();
}

class _admincheckoutsState extends State<admincheckouts> {
  List checkouts = [];

  Future<void> getcheckouts() async {
    final response = await http.get(
      Uri.parse("http://localhost/admin/checkouts.php"),
    );

    final data = jsonDecode(response.body);
    setState(() {
      checkouts = data['checkouts'];
    });
  }

  @override
  void initState() {
    super.initState();
    getcheckouts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: adminNavDrawer(),
      appBar: AppBar(
        title: const Text('Checkouts information'),
        backgroundColor: Colors.teal,
      ),
      body: ListView.builder(
          itemCount: checkouts.length,
          itemBuilder: (BuildContext context, int index) {
            return Card(
              child: ListTile(
                title: Text(checkouts[index]['checkout_id']),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(checkouts[index]['checkout_date']),
                    const SizedBox(
                        height: 8), // add some space between the rows
                    Text(checkouts[index]['checkout_amount']),
                    const SizedBox(height: 8),
                    Text(checkouts[index]['checkout_budget_id']),
                  ],
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () {
                        // TODO: Implement edit functionality
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
          // TODO: Implement add functionality
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
                getcheckouts();
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
