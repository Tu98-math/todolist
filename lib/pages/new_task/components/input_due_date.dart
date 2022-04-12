import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class InputDueDate extends StatefulWidget {
  const InputDueDate({
    Key? key,
    required this.date,
    required this.press,
  }) : super(key: key);

  final DateTime? date;
  final Function press;

  @override
  _InputDueDateState createState() => _InputDueDateState();
}

class _InputDueDateState extends State<InputDueDate> {
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
            "Due Date",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(width: 8),
          InkWell(
            onTap: () {
              // showTimePicker(
              //   context: context,
              //   initialTime: TimeOfDay.now(),
              // );
              showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(2000),
                lastDate: DateTime(2025),
              ).then((date) {
                widget.press(date);
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
                  widget.date == null ? "Any Time" : f.format(widget.date!),
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
