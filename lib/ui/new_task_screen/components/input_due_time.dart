import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class InputDueTime extends StatefulWidget {
  const InputDueTime({
    Key? key,
    required this.time,
    required this.press,
  }) : super(key: key);

  final TimeOfDay? time;
  final Function press;

  @override
  _InputDueTimeState createState() => _InputDueTimeState();
}

class _InputDueTimeState extends State<InputDueTime> {
  final f = new DateFormat('dd/MM/yyyy');
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // ignore: unused_local_variable
    DateTime? _currentDate = DateTime.now();
    return Container(
      width: size.width,
      height: 66,
      color: Color(0xFFF4F4F4),
      child: Row(
        children: [
          SizedBox(width: 25),
          Text(
            "Due Time",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(width: 8),
          InkWell(
            onTap: () {
              showTimePicker(
                context: context,
                initialTime: TimeOfDay.now(),
              ).then((time) {
                widget.press(time);
              });
            },
            child: Container(
              width: 100,
              height: 32,
              decoration: BoxDecoration(
                color: Color(0xFF6074F9),
                borderRadius: BorderRadius.circular(5),
              ),
              child: Center(
                child: Text(
                  widget.time == null
                      ? "Any Time"
                      : ((widget.time!.hour % 12).toString() +
                          ':' +
                          widget.time!.minute.toString() +
                          ':' +
                          (widget.time!.hour > 12 ? 'AM' : 'PM')),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
