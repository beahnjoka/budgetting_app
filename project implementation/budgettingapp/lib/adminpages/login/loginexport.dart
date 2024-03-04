import 'package:excel/excel.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const ExportDataScreen());
}

class ExportDataScreen extends StatelessWidget {
  const ExportDataScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  _exportToExcel() {
    final excel = Excel.createExcel();
    final sheet = excel.sheets[excel.getDefaultSheet() as String];
    sheet!.setColWidth(2, 50);
    sheet.setColAutoFit(3);

    sheet.cell(CellIndex.indexByColumnRow(columnIndex: 2, rowIndex: 3)).value =
        'Text string';

    sheet.cell(CellIndex.indexByColumnRow(columnIndex: 3, rowIndex: 4)).value =
        'Text string Text string Text string Text string Text string Text string Text string Text string';

    excel.save();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Export to Excel'),
      ),
      body: Center(
        child: ElevatedButton(
            onPressed: _exportToExcel, child: const Text('Export')),
      ),
    );
  }
}
