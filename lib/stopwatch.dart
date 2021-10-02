import 'dart:async';

import 'package:flutter/material.dart';

class StopWatch extends StatefulWidget {
  const StopWatch({Key? key}) : super(key: key);

  @override
  _StopWatchState createState() => _StopWatchState();
}

class _StopWatchState extends State<StopWatch> {
  int seconds = 0;
  late Timer timer;
  bool isTicking = false;

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  void _onTick(Timer time) {
    setState(() {
      ++seconds;
    });
  }

  void _startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), _onTick);
    setState(() {
      seconds = 0;
      isTicking = true;
    });
  }

  void _stopTimer() {
    timer.cancel();
    setState(() {
      isTicking = false;
    });
  }

  String get _secondText => seconds == 1 ? 'second' : 'seconds';
  Widget get _spacer => const SizedBox(height: 20, width: 20);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Stopwatch')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '$seconds $_secondText',
            style: Theme.of(context).textTheme.headline5,
          ),
          _spacer,
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: isTicking ? null : _startTimer,
                child: const Text('Start'),
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.green),
                  foregroundColor:
                      MaterialStateProperty.all<Color>(Colors.white),
                ),
              ),
              _spacer,
              ElevatedButton(
                onPressed: isTicking ? _stopTimer : null,
                child: const Text('Stop'),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
                  foregroundColor:
                      MaterialStateProperty.all<Color>(Colors.white),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
