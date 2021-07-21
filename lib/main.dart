import 'dart:async';
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

  late Timer _timer;
  var _time = 0;
  var _isPlaying = false;
  List<String> _saveTimes = [];

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

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
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget _body() {
    var sec = _time ~/ 100;
    var hundredth = '${_time % 100}'.padLeft(2, '0');

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(40),
        child: Stack(
          children: [
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '$sec',
                      style: TextStyle(fontSize: 80),
                    ),
                    Text(
                      '.$hundredth',
                      style: TextStyle(fontSize: 30),
                    )
                  ],
                ),
                SizedBox(
                  height: 50,
                ),
                Container(
                  width: 200,
                  height: 300,
                  child: ListView(
                      children: _saveTimes
                          .map((time) =>
                              Text(time, style: TextStyle(fontSize: 20)))
                          .toList()),
                ),
              ],
            ),
            makeGradientButton('Clear Board', 80, null, null),
            makeGradientButton('Save Time', 20, sec, hundredth),
          ],
        ),
      ),
    );
  }

  void _click() {
    _isPlaying = !_isPlaying;
    if (_isPlaying) {
      _icon = Icons.pause;
      _color = Colors.grey;
      _start();
    } else {
      _icon = Icons.play_arrow;
      _color = Colors.amber;
      _pause();
    }
  }

  void _start() {
    _timer = Timer.periodic(Duration(milliseconds: 10), (timer) {
      setState(() {
        _time++;
      });
    });
  }

  void _pause() {
    _timer.cancel();
  }

  void _reset() {
    setState(() {
      if (_isPlaying) _click();
      _saveTimes.clear();
      _time = 0;
    });
  }

  _saveTime(String time) {
    _saveTimes.insert(0, '${_saveTimes.length + 1}등 : $time');
  }

  Widget makeGradientButton(
      String buttonText, double height, int? sec, String? hundredth) {
    var _textColor = Colors.white;
    return Positioned(
      right: 0,
      bottom: height,
      child: GestureDetector(
        onTap: () {
          setState(() {
            sec == null ? _reset() : _saveTime('$sec.$hundredth');
          });
        },
        child: Container(
          padding: const EdgeInsets.all(10.0),
          width: 200,
          height: 50,
          child: Center(
            child: Text(
              buttonText,
              style: TextStyle(fontSize: 20, color: _textColor),
            ),
          ),
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: <Color>[
                Color(0xFF0D47A1),
                Color(0xFF1976D2),
                Color(0xFF42A5F5),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
