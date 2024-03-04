// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import '../../animation/ScaleRoute.dart';
import '../screens/login.dart';
import 'accounts/accountdata.dart';
import 'budgets/budgetdata.dart';
import 'checkouts/checkoutdata.dart';
import 'deposits/depositdata.dart';
import 'login/logindata.dart';
import 'users/userdata.dart';

class adminNavDrawer extends StatelessWidget {
  const adminNavDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.teal[50],
      child: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        children: <Widget>[
          const SizedBox(height: 100),
          ListTile(
            leading: const Icon(Icons.backspace),
            title: const Text('login info'),
            onTap: () =>
                {Navigator.push(context, ScaleRoute(page: const adminlogin()))},
          ),
          ListTile(
            leading: const Icon(Icons.border_color),
            title: const Text('user info'),
            onTap: () =>
                {Navigator.push(context, ScaleRoute(page: const adminusers()))},
          ),
          ListTile(
            leading: const Icon(Icons.receipt),
            title: const Text('Accounts info'),
            onTap: () => {
              Navigator.push(
                  context,
                  ScaleRoute(
                    page: const adminaccounts(),
                  ))
            },
          ),
          ListTile(
            leading: const Icon(Icons.inbox),
            title: const Text('Budgets info'),
            onTap: () =>
                {Navigator.push(context, ScaleRoute(page: const adminbudgets()))},
          ),
          ListTile(
            leading: const Icon(Icons.inbox),
            title: const Text('Deposit info'),
            onTap: () => {
              Navigator.push(context, ScaleRoute(page: const admindeposits()))
            },
          ),
          ListTile(
            leading: const Icon(Icons.send_outlined),
            title: const Text('Checkout info'),
            onTap: () => {
              Navigator.push(context, ScaleRoute(page: const admincheckouts()))
            },
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('logout'),
            onTap: () =>
                {Navigator.push(context, ScaleRoute(page: const Login()))},
          ),
        ],
      ),
    );
  }
}
