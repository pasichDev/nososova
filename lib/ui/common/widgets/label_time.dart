import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nososova/ui/common/widgets/label.dart';

class TimeLabel extends StatefulWidget {
  final int time;

  const TimeLabel({super.key, required this.time});

  @override
  State createState() => _TimeLabelState();
}

class _TimeLabelState extends State<TimeLabel> {
  int timePost = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Label(text: getNormalTime(widget.time));
  }

  String getNormalTime(int unixTime) {
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(unixTime * 1000);
    return DateFormat('HH:mm:ss').format(dateTime);
  }
}
