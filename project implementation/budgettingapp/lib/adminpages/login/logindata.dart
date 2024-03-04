import 'dart:convert';
import 'package:budgettingapp/adminpages/login/loginexport.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../animation/ScaleRoute.dart';
import '../adminwidgets.dart';
import 'loginadd.dart';
import 'loginupdate.dart';

class adminlogin extends StatefulWidget {
  const adminlogin({Key? key}) : super(key: key);

  @override
  _adminloginState createState() => _adminloginState();
}

class _adminloginState extends State<adminlogin> {
  List login = [];

  Future<void> getLogin() async {
    final response = await http.get(
      Uri.parse("http://localhost/admin/login.php"),
    );

    final data = jsonDecode(response.body);
    setState(() {
      login = data['login'];
    });
  }

  @override
  void initState() {
    super.initState();
    getLogin();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: adminNavDrawer(),
      appBar: AppBar(
        title: const Text('login user information'),
        backgroundColor: Colors.teal,
      ),
      body: ListView.builder(
          itemCount: login.length,
          itemBuilder: (BuildContext context, int index) {
            return Card(
              child: ListTile(
                //title: Text(login[index]['login_id']),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(login[index]['login_username']),
                    const SizedBox(height: 8),
                    Text(login[index]['login_rank']),
                    const SizedBox(height: 8),
                  ],
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () {
                        Navigator.push(
                            context, ScaleRoute(page: const loginupdate()));
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () async {},
                    ),
                  ],
                ),
              ),
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, ScaleRoute(page: const Sign()));
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
                getLogin();
              },
            ),
            IconButton(
              icon: const Icon(Icons.outbox_outlined),
              onPressed: () {
              },
            ),
          ],
        ),
      ),
    );
  }
}
