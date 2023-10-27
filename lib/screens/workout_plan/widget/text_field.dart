import 'package:flutter/material.dart';

class TextFieldPage extends StatefulWidget {
  final double width;
  const TextFieldPage({Key? key, this.width = double.infinity})
      : super(key: key);

  @override
  State<TextFieldPage> createState() => _TextFieldPageState();
}

class _TextFieldPageState extends State<TextFieldPage> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 5,
      ),
      child: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Container(
            width: widget.width,
            child: TextField(
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                  borderSide:
                      BorderSide(color: Color.fromARGB(255, 176, 159, 159)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide:
                      BorderSide(color: Color.fromARGB(255, 176, 159, 159)),
                ),
                filled: true,
                //fillColor: Color.fromARGB(255, 176, 159, 159),
              ),
            ),
          ),
          // You can add more widgets here if needed.
        ],
      ),
    );
  }
}
