import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

// ignore: must_be_immutable
class CustomButton extends StatelessWidget {
  String button_name;
  Function() buttonaction;

  CustomButton({
    super.key,
    required this.button_name,
    required this.buttonaction,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.sizeOf(context).width * 1,
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 0, 129, 84),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Material(
        color: Colors.transparent,
        child: ElevatedButton(
          onPressed: () {
            buttonaction();
          },
          style: ElevatedButton.styleFrom(
            alignment: Alignment.center,
            backgroundColor: Colors.transparent,
            // elevation: 12,
            elevation: 0.0,
            // padding: EdgeInsets.symmetric(horizontal: 10.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 5.0),
            child: Center(
              child: Text(
                button_name,
                style: TextStyle(
                  color: Color.fromARGB(255, 255, 255, 255),
                  fontSize: 20.0,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ReusableTextFormField extends StatelessWidget {
  ReusableTextFormField(
      {super.key,
      required this.controller,
      required this.hinttext,
      required this.prefixicon,
      required this.ispasswordtype,
      required this.validater});

  bool ispasswordtype;
  String hinttext;
  IconData prefixicon;
  TextEditingController controller;
  Function(String value) validater;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        onTapOutside: (event) {
                            FocusScope.of(context).unfocus();
                          },
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: (value) => validater(value!),
        controller: controller,
        textAlign: TextAlign.start,
        style: TextStyle(fontSize: 15),
        cursorHeight: 25,
        obscureText: ispasswordtype,
        enableSuggestions: !ispasswordtype,
        autocorrect: !ispasswordtype,
        decoration: InputDecoration(
          hintText: hinttext,
          prefixIcon: Icon(prefixicon),
          prefixIconColor: const Color.fromARGB(255, 0, 129, 84),
          // Added this
          // contentPadding: EdgeInsets.all(10),

          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                width: 2,
                color: Color.fromARGB(255, 157, 157, 157),
              ),
              borderRadius: BorderRadius.circular(12)),
          hintStyle: TextStyle(color: Color.fromARGB(255, 105, 105, 105)),
          border: OutlineInputBorder(
            gapPadding: Checkbox.width * 0.1,
            borderRadius: BorderRadius.circular(15),
            // borderSide: BorderSide(
            //   color: const Color.fromARGB(255, 222, 222, 222),
            // ),
          ),
        ),
        keyboardType: ispasswordtype
            ? TextInputType.visiblePassword
            : TextInputType.emailAddress);
  }
}
