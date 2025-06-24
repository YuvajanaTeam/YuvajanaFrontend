import 'package:flutter/material.dart';
import 'package:yuvav1/widgets/text_field_container.dart';
import 'package:yuvav1/providers/constants.dart';
class RoundedInputField extends StatefulWidget {
  final TextEditingController controller;
  final ValueChanged<String>? onChanged;
  final IconData? icon;
  final String hintText;

  const RoundedInputField({Key? key, required this.hintText,
    this.icon,
    this.onChanged,
    required this.controller,}) : super(key: key);

  @override
  _RoundedInputFieldState createState() => _RoundedInputFieldState();
}

class _RoundedInputFieldState extends State<RoundedInputField> {
  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextField(
        controller: widget.controller,
        onChanged: widget.onChanged,
        decoration: InputDecoration(
            icon: Icon(widget.icon, color: kPrimaryColor),
            hintText: widget.hintText,
            border: InputBorder.none),
      ),
    );
  }
}

