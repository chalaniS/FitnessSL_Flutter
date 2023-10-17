import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitness/screens/home/home_screen.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';
import 'resetPasswordPage.dart';
import 'signUpPage.dart';

class MyLogin extends StatefulWidget {
  const MyLogin({Key? key}) : super(key: key);

  @override
  _MyLoginState createState() => _MyLoginState();
}

class _MyLoginState extends State<MyLogin> {
  late String _password;
  late String _username;
  final _formKey = GlobalKey<FormState>();
  bool _isPasswordVisible = false;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Widget _buildTextField({
    required String hintText,
    required bool obscureText,
    required IconData suffixIcon,
    required VoidCallback onSuffixIconTap,
    TextInputType? keyboardType,
    TextInputAction? textInputAction,
    String? Function(String?)? validator,
    void Function(String?)? onSaved,
  }) {
    return TextFormField(
      style: const TextStyle(fontSize: 20.0, color: Colors.black),
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        hintText: hintText,
        hintStyle: const TextStyle(color: Colors.grey),
        contentPadding:
            const EdgeInsets.only(left: 25.0, bottom: 10.0, top: 11.0),
        border: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(25.7),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.black),
          borderRadius: BorderRadius.circular(25.7),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.black),
          borderRadius: BorderRadius.circular(25.7),
        ),
        suffixIcon: GestureDetector(
          onTap: onSuffixIconTap,
          child: Icon(
            suffixIcon,
            color: Colors.black,
          ),
        ),
      ),
      obscureText: obscureText,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      validator: validator,
      onSaved: onSaved,
    );
  }

  Future<void> _login() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState?.save();

      try {
        final UserCredential userCredential =
            await _auth.signInWithEmailAndPassword(
          email: _username,
          password: _password,
        );

        // Authentication successful, you can perform actions here
        print('User logged in: ${userCredential.user?.email}');

        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );
      } catch (e) {
        // Handle login errors (e.g., invalid credentials)
        String errorMessage = 'Login Error';
        if (e is FirebaseAuthException) {
          if (e.code == 'user-not-found') {
            errorMessage = 'User not found. Please sign up.';
          } else if (e.code == 'wrong-password') {
            errorMessage = 'Invalid password. Please try again.';
          } else if (e.code == 'invalid-email') {
            errorMessage = 'Invalid email address.';
          } else {
            errorMessage = 'An error occurred while logging in.';
          }
        }

        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Login Error'),
              content: Text(errorMessage),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );

        print('Login Error: $errorMessage');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkBlue,
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 20),
                const Image(
                  image: AssetImage("images/logo2.png"),
                  width: 280.0,
                  alignment: Alignment.center,
                ),
                const SizedBox(height: 20),
                const Text(
                  'Welcome!',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const Text(
                  'Use your credentials below and log into your account',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 19.0,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 60),
                _buildTextField(
                  hintText: 'Email address',
                  obscureText: false,
                  suffixIcon: Icons.visibility,
                  onSuffixIconTap: () {
                    setState(() {
                      _isPasswordVisible = !_isPasswordVisible;
                    });
                  },
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Email is required';
                    }
                    return null;
                  },
                  onSaved: (text) {
                    _username = text!;
                  },
                ),
                const SizedBox(height: 20),
                _buildTextField(
                  hintText: 'Password',
                  obscureText: !_isPasswordVisible,
                  suffixIcon: _isPasswordVisible
                      ? Icons.visibility
                      : Icons.visibility_off,
                  onSuffixIconTap: () {
                    setState(() {
                      _isPasswordVisible = !_isPasswordVisible;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Password is required';
                    }
                    return null;
                  },
                  onSaved: (text) {
                    _password = text!;
                  },
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ResetPassword()),
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
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 1,
                  child: ElevatedButton(
                    onPressed: _login,
                    style: ElevatedButton.styleFrom(
                      primary: yellow,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    child: const Text(
                      'Login my account',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 25.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
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
                          MaterialPageRoute(
                              builder: (context) => const SignUp()),
                        );
                      },
                      child: const Text(
                        "Sign Up",
                        style: TextStyle(
                          fontSize: 15,
                          color: yellow,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
