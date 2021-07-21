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
  bool cleared = false;
  bool saved = false;

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
            makeClearBoardButton('Clear Board', 80),
            makeSaveButton('Save Time', 20, sec, hundredth),
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

  Widget makeSaveButton(
      String buttonText, double height, int? sec, String? hundredth) {
    return Positioned(
      right: 0,
      bottom: height,
      child: GestureDetector(
        onTapDown: (TapDownDetails details) {
          setState(() {
            saved = true;
          });
        },
        onTapUp: (TapUpDetails details) {
          setState(() {
            saved = false;
          });
        },
        onTap: () {
          setState(() {
            _saveTime('$sec.$hundredth');
          });
        },
        child: Container(
          padding: const EdgeInsets.all(10.0),
          width: 200,
          height: 50,
          child: Center(
            child: Text(
              buttonText,
              style: TextStyle(
                  fontSize: 20, color: saved ? Colors.black : Colors.white),
            ),
          ),
          decoration: saved ? _greyBoxDecoration() : _blueBoxDecoration(),
        ),
      ),
    );
  }

  Widget makeClearBoardButton(String buttonText, double height) {
    return Positioned(
      right: 0,
      bottom: height,
      child: GestureDetector(
        onTapDown: (TapDownDetails details) {
          setState(() {
            cleared = true;
          });
        },
        onTapUp: (TapUpDetails details) {
          setState(() {
            cleared = false;
          });
        },
        onTap: () {
          setState(() {
            _reset();
          });
        },
        child: Container(
          padding: const EdgeInsets.all(10.0),
          width: 200,
          height: 50,
          child: Center(
            child: Text(
              buttonText,
              style: TextStyle(
                  fontSize: 20, color: cleared ? Colors.black : Colors.white),
            ),
          ),
          decoration: cleared ? _greyBoxDecoration() : _blueBoxDecoration(),
        ),
      ),
    );
  }

  BoxDecoration _blueBoxDecoration() {
    return BoxDecoration(
      gradient: LinearGradient(
        colors: [
          Color(0xFF0D47A1),
          Color(0xFF1976D2),
          Color(0xFF42A5F5),
        ],
      ),
    );
  }

  BoxDecoration _greyBoxDecoration() {
    return BoxDecoration(
      gradient: LinearGradient(
        colors: [
          Colors.grey,
          Colors.white,
        ],
      ),
    );
  }
}
