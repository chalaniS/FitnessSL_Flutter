import 'package:flutter/material.dart';

class MyInputField extends StatefulWidget {
  final String title;
  final String hint;
  final TextEditingController? controller;
  final Widget? widget;
  final void Function(String)? onChanged;
  final String? Function(dynamic)? validator;

  const MyInputField({
    Key? key,
    required this.title,
    required this.hint,
    this.controller,
    this.widget,
    required this.onChanged,
    required this.validator,
  }) : super(key: key);

  @override
  State<MyInputField> createState() => _MyInputFieldState();
}

class _MyInputFieldState extends State<MyInputField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.title,
            style: TextStyle(fontSize: 16),
          ),
          Container(
            height: 52,
            margin: EdgeInsets.only(top: 8.0, bottom: 8.0),
            padding: EdgeInsets.only(left: 14),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey, width: 1.0),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: widget.controller,
                    decoration: InputDecoration(
                      hintText: widget.hint,
                      hintStyle: TextStyle(color: Colors.grey),
                    ),
                    onChanged: widget.onChanged,
                    validator: widget.validator,
                  ),
                ),
                widget.widget ?? Container(),
              ],
            ),
          )
        ],
      ),
    );
  }
}
