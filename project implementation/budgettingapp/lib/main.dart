import 'package:flutter/material.dart';
import 'package:mpesa_flutter_plugin/mpesa_flutter_plugin.dart';

import 'screens/splash.dart';

void main() {
  MpesaFlutterPlugin.setConsumerKey('Vc9dyOkVw4ZOxaFlYBuJahepCpwQ2KbM');
  MpesaFlutterPlugin.setConsumerSecret('osOjEACKmMvszuy9');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: splash(),
    );
  }
}
