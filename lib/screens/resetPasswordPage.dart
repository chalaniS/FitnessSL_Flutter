import 'package:flutter/material.dart';
import 'colors.dart';
import 'loginPage.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({Key? key}) : super(key: key);

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  Widget _buildEmailField() {
    return TextFormField(
      style: const TextStyle(fontSize: 20.0, color: Colors.white),
      decoration: InputDecoration(
        filled: true,
        fillColor: darkBlue,
        hintText: 'example@gmail.com',
        hintStyle: const TextStyle(color: Colors.grey),
        contentPadding:
            const EdgeInsets.only(left: 25.0, bottom: 10.0, top: 11.0),
        border: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(25.7),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(25.7),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(25.7),
        ),
      ),
    );
  }

  Widget _buildElevatedButtonField() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const MyLogin()),
            );
          },
          style: ElevatedButton.styleFrom(
            primary: yellow,
            padding: const EdgeInsets.only(
              right: 50,
              left: 50,
              top: 6,
              bottom: 6,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
          ),
          child: const Text(
            'Send',
            style: TextStyle(
              color: black,
              fontSize: 25.0,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkBlue,
      body: Padding(
        padding: const EdgeInsets.all(35),
        child: Column(
          children: [
            const Text(
              'Enter the email associated with your account. \n\n\n Email address',
              style: TextStyle(fontSize: 21, color: white),
            ),
            _buildEmailField(),
            _buildElevatedButtonField(),
          ],
        ),
      ),
    );
  }
}
