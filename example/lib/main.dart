import 'package:flutter/material.dart';
import 'package:onepicker/onepicker.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'One Picker',
      theme: ThemeData(
        primarySwatch: Colors.green,
        primaryColor: Colors.green,
      ),
      home: const MyHomePage(title: 'One Picker'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String dateSeleted = " - ";
  String dateFromSeleted = " - ";
  String dateToSeleted = " - ";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              'Selected Date: $dateSeleted',
              style: Theme.of(context).textTheme.titleLarge,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            GestureDetector(
              onTap: (){
                OnePicker().date(
                    context,
                    selectedColor: Colors.green,
                    bgColor: Colors.white,
                    onTap: (value){
                      dateSeleted = DateFormat('yyyy-MM-dd') .format(value).toString();
                      setState(() {});
                    }
                );
              },
              child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: Colors.green,
                          width: 4
                      ),
                      borderRadius: const BorderRadius.all(Radius.circular(50))
                  ),
                  child: const Text(
                    'Date Picker',
                    style: TextStyle(color: Colors.green, fontSize: 20, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  )
              ),
            ),

            const SizedBox(height: 20),

            Text(
              'Selected Date  Range: $dateFromSeleted to $dateToSeleted',
              style: Theme.of(context).textTheme.titleLarge,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            GestureDetector(
              onTap: (){
                OnePicker().dateRange(
                    context,
                    onTap: (from, to){
                      dateFromSeleted = DateFormat('yyyy-MM-dd') .format(from).toString();
                      dateToSeleted = DateFormat('yyyy-MM-dd') .format(to).toString();
                      setState(() {});
                    }
                );
              },
              child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: Colors.green,
                          width: 4
                      ),
                      borderRadius: const BorderRadius.all(Radius.circular(50))
                  ),
                  child: const Text(
                    'Date Range Picker',
                    style: TextStyle(color: Colors.green, fontSize: 20, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  )
              ),
            ),
          ],
        ),
      ),
    );
  }
}
