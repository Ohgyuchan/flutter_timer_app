import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TimerScreen(title: 'Timer App'),
    );
  }
}

class TimerScreen extends StatefulWidget {
  TimerScreen({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _TimerScreenState createState() => _TimerScreenState();
}

class _TimerScreenState extends State<TimerScreen> {
  var _icon = Icons.play_arrow;
  var _color = Colors.amber;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Stop Watch'),
      ),
      body: _body(),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          height: 80,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => setState(() {
          _click();
        }),
        child: Icon(_icon),
        backgroundColor: _color,
      ),
    );
  }

  Widget _body() {
    return Container();
  }

  void _click() {
    if (_icon == Icons.play_arrow) {
      _icon = Icons.pause;
      _color = Colors.grey;
    } else {
      _icon = Icons.play_arrow;
      _color = Colors.amber;
    }
  }
}
