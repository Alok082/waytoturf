import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class TitleRow extends StatelessWidget {
  TitleRow(
      {super.key,
      required this.buttontext,
      required this.ontapbutton,
      required this.title,
      this.titlecolor});
  String title;
  String buttontext;
  Color? titlecolor = const Color.fromARGB(255, 255, 255, 255);
  VoidCallback ontapbutton;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Row(
        children: [
          Text(
            title,
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
          const Spacer(),
          Text(
            buttontext,
            style: const TextStyle(
              fontSize: 17,
              color: Color.fromARGB(255, 0, 129, 84),
            ),
          )
        ],
      ),
    );
  }
}
