import 'package:fitness/screens/colors.dart';
import 'package:fitness/screens/home.dart';
import 'package:flutter/material.dart';
import 'signUpPage.dart';
import 'resetPasswordPage.dart';

class MyLogin extends StatefulWidget {
  const MyLogin({Key? key}) : super(key: key);

  @override
  State<MyLogin> createState() => _MyLoginState();
}

class _MyLoginState extends State<MyLogin> {
  late String _password;
  late String _username;
  final _formKey = GlobalKey<FormState>();

  Widget _buildUserNameField() {
    return TextFormField(
      style: const TextStyle(
        fontSize: 20.0,
        color: Color.fromARGB(255, 255, 255, 255),
      ),
      decoration: InputDecoration(
        filled: true,
        fillColor: darkBlue,
        hintText: 'Email address',
        hintStyle: const TextStyle(
          color: gray,
        ),
        contentPadding:
            const EdgeInsets.only(left: 25.0, bottom: 10.0, top: 11.0),
        border: OutlineInputBorder(
          // Add this line to set a non-changeable border
          borderSide: BorderSide(color: Colors.white),
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
      onSaved: (text) {
        _username = text!;
      },
    );
  }

  bool _isPasswordVisible = false;

  Widget _buildPassWordField() {
    return TextFormField(
      style: const TextStyle(
        fontSize: 20.0,
        color: Color.fromARGB(255, 255, 255, 255),
      ),
      decoration: InputDecoration(
        filled: true,
        fillColor: darkBlue,
        hintText: 'Password',
        hintStyle: const TextStyle(
          color: gray,
        ),
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
        suffixIcon: GestureDetector(
          onTap: () {
            setState(() {
              _isPasswordVisible = !_isPasswordVisible;
            });
          },
          child: Icon(
            _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
            color: Colors.white,
          ),
        ),
      ),
      obscureText: !_isPasswordVisible,
      maxLength: 8,
      onSaved: (text) {
        _password = text!;
      },
    );
  }

  Widget _buildTextButtonField() {
    return Row(
      mainAxisAlignment:
          MainAxisAlignment.end, // Align the content to the right
      children: [
        Spacer(), // Add a spacer to push the text to the right
        TextButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ResetPassword()),
            );
          },
          child: const Text(
            'Forgot Password?',
            style: TextStyle(
              fontSize: 17,
              color: Colors.yellowAccent,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildElevatedButtonField() {
    return SizedBox(
      width: MediaQuery.of(context).size.width / 1,
      child: ElevatedButton(
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            _formKey.currentState?.save();
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const HomeScreen()),
            );
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: yellow,
          padding: const EdgeInsets.only(
            top: 16,
            bottom: 16,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        child: const Text(
          'Login my account',
          style: TextStyle(
            color: black,
            fontSize: 25.0,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }

  Widget _buildSignUpField() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "Don't have an account?",
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
        TextButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SignUp()),
            );
          },
          child: const Text(
            "Sign Up",
            style: TextStyle(
              fontSize: 15,
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
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.only(
                left: 30,
                right: 30,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,

                // crossAxisAlignment: CrossAxisAlignment.center,
                // mainAxisSize: MainAxisSize.max,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  const Image(
                    image: AssetImage("images/logo2.png"),
                    width: 280.0,
                    alignment: Alignment.center,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    'Welcome!',
                    style: TextStyle(
                      color: white,
                      fontSize: 25.0,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const Text(
                    'Use your credentials below and loginto your account',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: gray,
                      fontSize: 19.0,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(
                    height: 60,
                  ),
                  _buildUserNameField(),
                  const SizedBox(
                    height: 20,
                  ),
                  _buildPassWordField(),
                  _buildTextButtonField(),
                  _buildElevatedButtonField(),
                  _buildSignUpField(),
                ],
              ),
            ),
          ),
        ));
  }
}
