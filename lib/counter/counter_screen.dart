import 'package:flutter/material.dart';

class CounterScreen extends StatefulWidget {
  const CounterScreen({super.key});

  @override
  CounterScreenState createState() => CounterScreenState();
}

class CounterScreenState extends State<CounterScreen> {
  int _counter = 0;
  bool _isIncrementButtonDisabled = false;
  bool _isDecrementButtonDisabled = true;

  void _incrementCounter() {
    setState(() {
      _counter++;
      _isDecrementButtonDisabled = false;
      if (_counter >= 10) {
        _isIncrementButtonDisabled = true;
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Cannot Increment More'),
            content: const Text('You have reached the maximum value of 10.'),
            actions: <Widget>[
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                child: const Text('OK'),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
          ),
        );
      }
    });
  }

  void _decrementCounter() {
    setState(() {
      _counter--;
      _isIncrementButtonDisabled = false;
      if (_counter <= 1) {
        _isDecrementButtonDisabled = true;
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Cannot Decrement More'),
            content: const Text('You have reached the minimum value of 1.'),
            actions: <Widget>[
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                child: const Text('OK'),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Text('Counter App'),
            centerTitle: true,
            backgroundColor: Colors.green),
        body: Column(
          children: [
            const SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Counter Value',
                  style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                ),
                const SizedBox(width: 16.0),
                Text('$_counter',
                    style: const TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.green)),
              ],
            ),
            const SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: _isDecrementButtonDisabled
                      ? null
                      : () {
                          _decrementCounter();
                        },
                  style: ElevatedButton.styleFrom(
                    shape: const CircleBorder(),
                    backgroundColor: Colors.red,
                    padding: const EdgeInsets.all(20.0),
                    minimumSize: const Size(60, 60),
                  ),
                  child: const Text(
                    '-',
                    style: TextStyle(fontSize: 24.0),
                  ),
                ),
                const SizedBox(width: 16.0),
                ElevatedButton(
                  onPressed: _isIncrementButtonDisabled
                      ? null
                      : () {
                          _incrementCounter();
                        },
                  style: ElevatedButton.styleFrom(
                    shape: const CircleBorder(),
                    backgroundColor: Colors.green,
                    padding: const EdgeInsets.all(20.0),
                    minimumSize: const Size(60, 60),
                  ),
                  child: const Text(
                    '+',
                    style: TextStyle(fontSize: 24.0),
                  ),
                ),
              ],
            ),
          ],
        ));
  }
}
