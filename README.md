# Circular Countdown Timer

Make an animated countdown timer using Circular Countdown Timer.

# Getting Started

To use this plugin, add `circular_countdown_timer` as a [dependency in your pubspec.yaml file.](https://flutter.dev/docs/development/packages-and-plugins/using-packages)

# Example

```dart
import 'package:flutter/material.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Circular Countdown Timer Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Circular Countdown Timer'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Center(
            child: CircularCountDownTimer(
          // Countdown duration in Seconds
          duration: 10,

          // Width of the Countdown Widget
          width: MediaQuery.of(context).size.width / 2,

          // Height of the Countdown Widget
          height: MediaQuery.of(context).size.height / 2,

          // Default Color for Countdown Timer
          color: Colors.white,

          // Filling Color for Countdown Timer
          fillColor: Colors.red,

          // Border Thickness of the Countdown Circle
          strokeWidth: 5.0,

          // Text Style for Countdown Text
          countdownTextStyle: TextStyle(
              fontSize: 22.0,
              color: Colors.black87,
              fontWeight: FontWeight.bold),

          // true for reverse countdown (max to 0), false for forward countdown (0 to max)
          reverseOrder: false,

          // Function which will execute when the Countdown Ends
          onCountDownComplete: () {
            // Here, do whatever you want
            print('Countdown Ended');
          },
        )));
  }
}
```

# Forward Countdown

![Forward](https://user-images.githubusercontent.com/30389103/84040768-79c32780-a9bc-11ea-87ff-4be9b9df945e.gif)


# Reverse Countdown

![Reverse](https://user-images.githubusercontent.com/30389103/84041105-e2aa9f80-a9bc-11ea-9227-eecce39ae8ea.gif)
