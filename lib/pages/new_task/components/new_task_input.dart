import 'package:flutter/material.dart';

class NewTaskInput extends StatefulWidget {
  const NewTaskInput({
    Key? key,
    required this.label,
    required this.hint,
  }) : super(key: key);

  final String label, hint;

  @override
  _NewTaskInputState createState() => _NewTaskInputState();
}

class _NewTaskInputState extends State<NewTaskInput> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          widget.label,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(width: 8),
        Container(
          width: 90,
          height: 50,
          child: Center(
            child: Text('${widget.hint}'),
          ),
        ),
      ],
    );
  }

  DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
        value: item,
        child: Text('$item'),
      );
}
