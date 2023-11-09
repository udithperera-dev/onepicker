import 'package:flutter/material.dart';
import 'package:onepicker/onepicker.dart';

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
  int _counter = 0;
  String dateSeleted = " - ";

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Selected Date: ${dateSeleted}',
              style: Theme.of(context).textTheme.headline6,
            ),
            SizedBox(height: 10,),
            GestureDetector(
              onTap: (){
                OnePicker().date(
                    context,
                    selectedColor: Colors.green,
                    bgColor: Colors.white,
                    onTap: (value){
                      dateSeleted = value.toString();
                      setState(() {});
                    }
                );
              },
              child: Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: Colors.green,
                          width: 4
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(50))
                  ),
                  child: Text(
                    'Click Here to Pick a Date',
                    style: TextStyle(color: Colors.green, fontSize: 20, fontWeight: FontWeight.bold),
                  )
              ),
            )
          ],
        ),
      ),
    );
  }
}
