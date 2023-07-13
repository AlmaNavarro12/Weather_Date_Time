import 'dart:async';
import 'package:flutter/material.dart';

class AmbientModePage extends StatefulWidget {
  const AmbientModePage({super.key});

  @override
  State<AmbientModePage> createState() => _AmbientModePageState();
}

class _AmbientModePageState extends State<AmbientModePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      return Container(
        child: Row(
          children: [
            Expanded(
              child: Container(
                  height:
                      constraints.maxHeight, // Ocupa toda la altura disponible
                  child: const TimerPage()),
            ),
          ],
        ),
      );
    }));
  }
}

class TimerPage extends StatefulWidget {
  const TimerPage({super.key});

  @override
  State<TimerPage> createState() => _TimerPageState();
}

class _TimerPageState extends State<TimerPage> {
  final Stopwatch _stopwatch = Stopwatch();
  Timer? _timer;
  String _elapsedTime = '00:00:00';

  void _startTimer() {
    _stopwatch.start();
    _timer = Timer.periodic(const Duration(milliseconds: 10), (timer) {
      setState(() {
        _elapsedTime = _formatTime(_stopwatch.elapsedMilliseconds);
      });
    });
  }

  void _stopTimer() {
    _stopwatch.stop();
    if (_timer != null) {
      _timer!.cancel();
      _timer = null;
    }
  }

  void _resetTimer() {
    _stopwatch.reset();
    setState(() {
      _elapsedTime = '00:00:00';
    });
  }

  String _formatTime(int milliseconds) {
    int hundreds = (milliseconds / 10).truncate();
    int seconds = (hundreds / 100).truncate();
    int minutes = (seconds / 60).truncate();
    int hours = (minutes / 60).truncate();

    String hoursStr = (hours % 60).toString().padLeft(2, '0');
    String minutesStr = (minutes % 60).toString().padLeft(2, '0');
    String secondsStr = (seconds % 60).toString().padLeft(2, '0');

    return '$hoursStr:$minutesStr:$secondsStr';
  }

  @override
  void dispose() {
    _stopwatch.stop();
    if (_timer != null) {
      _timer!.cancel();
      _timer = null;
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              _elapsedTime,
              style: const TextStyle(fontSize: 28),
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: _startTimer,
                  style: ElevatedButton.styleFrom(
                      backgroundColor:
                          const Color.fromARGB(255, 255, 255, 255)),
                  child: const Icon(Icons.play_arrow,
                      size: 14, color: Color.fromARGB(255, 27, 75, 73)),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: _stopTimer,
                  style: ElevatedButton.styleFrom(
                      backgroundColor:
                          const Color.fromARGB(255, 255, 255, 255)),
                  child: const Icon(Icons.stop,
                      size: 14, color: Color.fromARGB(255, 27, 75, 73)),
                ),
                const SizedBox(width: 5),
                 ElevatedButton(
                  onPressed: _resetTimer,
                  style: ElevatedButton.styleFrom(
                      backgroundColor:
                          const Color.fromARGB(255, 255, 255, 255)),
                  child: const Icon(Icons.refresh_sharp,
                      size: 14, color: Color.fromARGB(255, 27, 75, 73)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}