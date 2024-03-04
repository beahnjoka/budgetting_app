// ignore_for_file: deprecated_member_use, camel_case_types

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class contacts extends StatelessWidget {
  final String adminEmail = 'admin@budgettingapp.com';
  final String helpdeskPhone = '+254796168288';

  const contacts({super.key});

  Future<void> _sendEmail() async {
    String url = 'mailto:$adminEmail';
    if (await canLaunch(url)) {
      await launch(url);
    }
  }

  Future<void> _callHelpdesk() async {
    String url = 'tel:$helpdeskPhone';
    if (await canLaunch(url)) {
      await launch(url);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Help'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // ignore: prefer_const_constructors
            Text(
              'If you need help, please contact us:',
              style: const TextStyle(fontSize: 18.0),
            ),
            const SizedBox(height: 16.0),
            ListTile(
              leading: const Icon(Icons.email),
              title: const Text('Email the Admin'),
              subtitle: Text(adminEmail),
              onTap: _sendEmail,
            ),
            ListTile(
              leading: const Icon(Icons.phone),
              title: const Text('Call Helpdesk'),
              subtitle: Text(helpdeskPhone),
              onTap: _callHelpdesk,
            ),
          ],
        ),
      ),
    );
  }
}
