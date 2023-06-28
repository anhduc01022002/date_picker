import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

void main() {
  initializeDateFormatting().then((_) => runApp(const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('vi', 'VN'),
      ],
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _dateController = TextEditingController();
  late DateTime _selectedDate;

  @override
  void initState() {
    super.initState();
    var now = DateTime.now();
    _selectedDate = DateTime(now.year - 18, now.month, now.day);
    _dateController.text = DateFormat('dd-MM-yyyy').format(_selectedDate);
  }

  void _selectDate(BuildContext context) async {
    await showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) {
        return CupertinoActionSheet(
          actions: <Widget>[
            SizedBox(
              height: 200,
              child: CupertinoDatePicker(
                mode: CupertinoDatePickerMode.date,
                initialDateTime: _selectedDate,
                minimumYear: DateTime.now().year - 60,
                maximumDate: DateTime.now(),
                onDateTimeChanged: (DateTime newDate) {
                  _selectedDate = newDate;
                },
                use24hFormat: true,
              ),
            ),
          ],
          cancelButton: Container(
            decoration: const BoxDecoration(
              color: Colors.blue,
            ),
            child: CupertinoActionSheetAction(
              child: const Text('Xong', style: TextStyle(color: Colors.white, fontSize: 20)),
              onPressed: () {
                Navigator.pop(context);
                setState(() {
                  _dateController.text = DateFormat('dd-MM-yyyy').format(_selectedDate);
                });
              },
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Demo'),
      ),
      body: Center(
        child: TextField(
          controller: _dateController,
          decoration: const InputDecoration(
            labelText: 'Ngày sinh',
          ),
          readOnly: true,
          onTap: () => _selectDate(context),
        ),
      ),
    );
  }
}
