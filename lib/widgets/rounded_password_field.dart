import 'package:flutter/material.dart';
import 'package:yuvav1/widgets/text_field_container.dart';

import '../providers/constants.dart';

class RoundedPasswordField extends StatefulWidget {
  final ValueChanged<String> onChanged;
  final TextEditingController controller;

  const RoundedPasswordField({
    Key? key,
    required this.onChanged,
    required this.controller,
  }) : super(key: key);

  @override
  _RoundedPasswordFieldState createState() => _RoundedPasswordFieldState();
}

class _RoundedPasswordFieldState extends State<RoundedPasswordField> {
  bool isHiddenPassword = true;

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextField(
        controller: widget.controller,
        onChanged: widget.onChanged,
        obscureText: isHiddenPassword,
        decoration: InputDecoration(
          hintText: "Password",
          icon: Icon(Icons.lock_outline, color: kPrimaryColor),
          suffixIcon: InkWell(
            onTap: togglePasswordView,
            child: Icon(
              isHiddenPassword ? Icons.visibility : Icons.visibility_off,
            ),
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }

  void togglePasswordView() {
    setState(() {
      isHiddenPassword = !isHiddenPassword;
    });
  }
}
