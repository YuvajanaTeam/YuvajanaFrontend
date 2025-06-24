import 'package:flutter/material.dart';

import '../config/size_config.dart';
import '../providers/login.dart';
import '../widgets/rounded_input_field.dart';
import '../widgets/rounded_password_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RoundedInputField(
                controller: emailController,
                icon: Icons.email_outlined,
                hintText: "myemail@gmail.com",
                onChanged: (value) {}),
            SizedBox(height: SizeConfig.blockSizeVertical * 2.5),
            RoundedPasswordField(
                controller: passwordController,
                onChanged: (value) {}),
            TextButton(onPressed: () async {
              login(context, emailController.text, passwordController.text);
            }, child: const Text('Login')),
          ],
        ),
      ),
    );
  }
}
