import 'package:flutter/material.dart';
import '../constants.dart';
import 'loginPage.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();
  late String text;

  Widget _buildTextField({
    required String hintText,
    required bool obscureText,
    required TextInputType keyboardType,
    TextInputAction? textInputAction,
    String? Function(String?)? validator,
    void Function(String?)? onSaved,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3.0, horizontal: 1.0),
      child: TextFormField(
        style: const TextStyle(fontSize: 20.0, color: Colors.white),
        decoration: InputDecoration(
          filled: true,
          fillColor: darkBlue,
          hintText: hintText,
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
          suffixIcon: obscureText && hintText.contains('Password')
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      obscureText = !obscureText;
                    });
                  },
                  icon: Icon(
                    obscureText ? Icons.visibility : Icons.visibility_off,
                    color: Colors.white,
                  ),
                )
              : null,
        ),
        obscureText: obscureText,
        keyboardType: keyboardType,
        textInputAction: textInputAction,
        validator: validator,
        onSaved: onSaved,
      ),
    );
  }

  Widget _buildElevatedButtonField() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        ElevatedButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              _formKey.currentState?.save();
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const MyLogin()),
              );
            }
          },
          style: ElevatedButton.styleFrom(
            primary: yellow,
            padding: const EdgeInsets.only(
              right: 50,
              left: 50,
              top: 6,
              bottom: 8,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
          child: const Text(
            'Sign Up',
            style: TextStyle(
              color: black,
              fontSize: 25.0,
              fontWeight: FontWeight.w600,
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
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(13.0),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Image(
                image: AssetImage("images/logo2.png"),
                width: 250.0,
                alignment: Alignment.center,
              ),
              const SizedBox(height: 20),
              for (var label in [
                'First Name',
                'Last Name',
                'E-mail',
                'NIC',
                'Password',
                'Re-enter Password',
              ])
                _buildTextField(
                  hintText: label,
                  obscureText: label.contains('Password'),
                  keyboardType: TextInputType.text,
                ),
              const SizedBox(height: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'By clicking ‘sign up’ I agree that I have read and accepted the',
                    style: TextStyle(color: white),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: const Text(
                      'Terms of Use',
                      style: TextStyle(
                        color: acyellow,
                      ),
                    ),
                  ),
                ],
              ),
              _buildElevatedButtonField(),
            ],
          ),
        ),
      ),
    );
  }
}
