// ignore_for_file: use_build_context_synchronously, camel_case_types, library_private_types_in_public_api

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../animation/ScaleRoute.dart';
import '../adminwidgets.dart';
import 'useradd.dart';
import 'userupdate.dart';

class adminusers extends StatefulWidget {
  const adminusers({Key? key}) : super(key: key);

  @override
  _adminusersState createState() => _adminusersState();
}

class _adminusersState extends State<adminusers> {
  List users = [];

  Future<void> getusers() async {
    final response = await http.get(
      Uri.parse("http://localhost/admin/users.php"),
    );

    final data = jsonDecode(response.body);
    setState(() {
      users = data['user'];
    });
  }

  @override
  void initState() {
    super.initState();
    getusers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const adminNavDrawer(),
      appBar: AppBar(
        title: const Text('user information'),
        backgroundColor: Colors.teal,
      ),
      body: ListView.builder(
          itemCount: users.length,
          itemBuilder: (BuildContext context, int index) {
            return Card(
              child: ListTile(
                title: Text(users[index]['user_id']),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(users[index]['user_full_name']),
                    const SizedBox(
                        height: 8), // add some space between the rows
                    Text(users[index]['user_mobile']),
                    const SizedBox(height: 8),
                    Text(users[index]['user_email']),
                  ],
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () {
                        Navigator.push(
                            context, ScaleRoute(page: const usersupdate()));
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () async {
                        final response = await http.post(
                          Uri.parse('http://localhost/admin/users_delete.php'),
                          body: {'user_id': users[index]['user_id']},
                        );
                        if (response.statusCode == 200) {
                          setState(() {
                            users.removeAt(index);
                          });
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('user deleted successfully')),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Failed to delete user')),
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, ScaleRoute(page: const Reg()));
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
                getusers();
              },
            ),
            IconButton(
              icon: const Icon(Icons.outbox_outlined),
              onPressed: () {
                // Implement export functionality
              },
            ),
          ],
        ),
      ),
    );
  }
}
