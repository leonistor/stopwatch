import 'dart:async';

import 'package:flutter/material.dart';

class StopWatch extends StatefulWidget {
  final String name;
  final String email;
  const StopWatch({
    Key? key,
    required this.name,
    required this.email,
  }) : super(key: key);

  @override
  _StopWatchState createState() => _StopWatchState();
}

class _StopWatchState extends State<StopWatch> {
  int milliseconds = 0;
  late Timer timer;
  final laps = <int>[];
  final itemHeight = 60.0;
  final scollController = ScrollController();
  bool isTicking = false;

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  void _onTick(Timer time) {
    setState(() {
      milliseconds += 100;
    });
  }

  void _startTimer() {
    timer = Timer.periodic(const Duration(milliseconds: 100), _onTick);
    setState(() {
      milliseconds = 0;
      isTicking = true;
      laps.clear();
    });
  }

  void _stopTimer() {
    timer.cancel();
    setState(() {
      isTicking = false;
    });
  }

  void _lap() {
    scollController.animateTo(
      itemHeight * laps.length, // offset
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeIn,
    );
    setState(() {
      laps.add(milliseconds);
      milliseconds = 0;
    });
  }

  String _secondText(int mls) {
    final seconds = mls / 1000;
    return '$seconds seconds';
  }

  Widget get _spacer => const SizedBox(height: 20, width: 20);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.name)),
      body: Column(
        children: [
          Expanded(child: _buildCounter(context)),
          Expanded(child: _buildLapDisplay()),
        ],
      ),
    );
  }

  Widget _buildLapDisplay() {
    return Scrollbar(
      child: ListView.builder(
        controller: scollController,
        itemExtent: itemHeight,
        itemCount: laps.length,
        itemBuilder: (context, index) {
          final mls = laps[index];
          return ListTile(
            title: Text('Lap ${index + 1}'),
            trailing: Text(_secondText(mls)),
            contentPadding: const EdgeInsets.symmetric(horizontal: 50),
          );
        },
      ),
    );
  }

  Widget _buildCounter(BuildContext context) {
    return Container(
      color: Theme.of(context).primaryColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Lap ${laps.length + 1}',
            style: Theme.of(context)
                .textTheme
                .subtitle1!
                .copyWith(color: Colors.white),
          ),
          Text(
            _secondText(milliseconds),
            style: Theme.of(context)
                .textTheme
                .headline5!
                .copyWith(color: Colors.white),
          ),
          _spacer,
          _buildControls(),
        ],
      ),
    );
  }

  Widget _buildControls() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: isTicking ? null : _startTimer,
          child: const Text('Start'),
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
            foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
          ),
        ),
        _spacer,
        ElevatedButton(
          onPressed: isTicking ? _lap : null,
          child: const Text('Lap'),
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(Colors.yellow),
            foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
          ),
        ),
        _spacer,
        ElevatedButton(
          onPressed: isTicking ? _stopTimer : null,
          child: const Text('Stop'),
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
            foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
          ),
        )
      ],
    );
  }
}
