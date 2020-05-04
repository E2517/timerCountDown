import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      title: 'Time Count Down',
      home: TimePage(),
    );
  }
}

class TimePage extends StatefulWidget {
  @override
  _TimePageState createState() => _TimePageState();
}

class _TimePageState extends State<TimePage> with TickerProviderStateMixin {
  AnimationController controller;

  String get timerString {
    Duration duration = controller.duration * controller.value;
    return '${duration.inMinutes}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
  }

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 5 + 5),
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          _inTime(),
        ],
      ),
    );
  }

  Widget _inTime() {
    return AnimatedBuilder(
        animation: controller,
        builder: (context, child) {
          return Padding(
            padding: EdgeInsets.all(35.0),
            child: Center(
              child: Column(
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      SizedBox(height: 200),
                      Text(
                        timerString,
                        style: TextStyle(fontSize: 100.0, color: Colors.white),
                      ),
                    ],
                  ),
                  AnimatedBuilder(
                      animation: controller,
                      builder: (context, child) {
                        return FlatButton.icon(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0)),
                            color: Colors.white,
                            onPressed: () {
                              if (controller.isAnimating)
                                controller.stop();
                              else {
                                controller.reverse(
                                    from: controller.value == 0.0
                                        ? 1.0
                                        : controller.value);
                              }
                            },
                            icon: Icon(
                                controller.isAnimating
                                    ? Icons.pause
                                    : Icons.play_arrow,
                                color: Color.fromRGBO(87, 35, 100, 1)),
                            label: Text(
                              controller.isAnimating ? "Pause" : "Play",
                              style: TextStyle(
                                  color: Color.fromRGBO(87, 35, 100, 1)),
                            ));
                      }),
                ],
              ),
            ),
          );
        });
  }
}
