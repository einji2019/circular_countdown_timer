library circular_countdown_timer;

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'custom_timer_painter.dart';

/// Create a Cicular Countdown Timer
class CircularCountDownTimer extends StatefulWidget {
  /// Filling Color for Countdown Timer
  final Color fillColor;

  /// Default Color for Countdown Timer
  final Color color;

  /// Function which will execute when the Countdown Ends
  final Function onCountDownComplete;

  /// Countdown Duration in Seconds
  final int duration;

  /// Width of the Countdown Widget
  final double width;

  /// Height of the Countdown Widget
  final double height;

  /// Border Thickness of the Countdown Circle
  final double strokeWidth;

  /// Text Style for Countdown Text
  final TextStyle countdownTextStyle;

  /// true for reverse countdown (max to 0), false for forward countdown (0 to max)
  final bool reverseOrder;

  CircularCountDownTimer(
      {@required this.width,
      @required this.height,
      @required this.duration,
      @required this.fillColor,
      @required this.color,
      this.reverseOrder,
      this.onCountDownComplete,
      this.strokeWidth,
      this.countdownTextStyle})
      : assert(width != null),
        assert(height != null),
        assert(duration != null),
        assert(fillColor != null),
        assert(color != null);

  @override
  _CircularCountDownTimerState createState() => _CircularCountDownTimerState();
}

class _CircularCountDownTimerState extends State<CircularCountDownTimer>
    with TickerProviderStateMixin {
  AnimationController controller;

  bool flag = true;

  String get timerString {
    Duration duration = controller.duration * controller.value;
    String time;

    if (duration.inSeconds > 3599) {
      time =
          '${duration.inHours}:${(duration.inMinutes % 60).toString().padLeft(2, '0')}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
    } else {
      time =
          '${duration.inMinutes % 60}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
    }

    if (widget.reverseOrder == null || !widget.reverseOrder) {
      // For Forward Order
      Duration forwardDuration = Duration(seconds: widget.duration);
      if (forwardDuration.inSeconds == duration.inSeconds && flag) {
        flag = false;
        if (widget.onCountDownComplete != null) {
          SchedulerBinding.instance
              .addPostFrameCallback((_) => widget.onCountDownComplete());
        }
        return time;
      }
      return time;
    } else {
      // For Reverse Order
      if (controller.isDismissed && flag) {
        flag = false;
        if (widget.onCountDownComplete != null) {
          SchedulerBinding.instance
              .addPostFrameCallback((_) => widget.onCountDownComplete());
        }
        return '0:00';
      }
      return time;
    }
  }

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: widget.duration),
    );

    if (widget.reverseOrder == null || !widget.reverseOrder) {
      controller.forward(from: controller.value);
    } else {
      controller.reverse(
          from: controller.value == 0.0 ? 1.0 : controller.value);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      child: AnimatedBuilder(
          animation: controller,
          builder: (context, child) {
            return Stack(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Expanded(
                        child: Align(
                          alignment: FractionalOffset.center,
                          child: AspectRatio(
                            aspectRatio: 1.0,
                            child: Stack(
                              children: <Widget>[
                                Positioned.fill(
                                  child: CustomPaint(
                                      painter: CustomTimerPainter(
                                          animation: controller,
                                          fillColor: widget.fillColor,
                                          color: widget.color,
                                          strokeWidth: widget.strokeWidth)),
                                ),
                                Align(
                                  alignment: FractionalOffset.center,
                                  child: Text(
                                    timerString,
                                    style: widget.countdownTextStyle ??
                                        TextStyle(
                                            fontSize: 16.0,
                                            color: Colors.black),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          }),
    );
  }

  @override
  void dispose() {
    controller.stop();
    controller.dispose();
    super.dispose();
  }
}
