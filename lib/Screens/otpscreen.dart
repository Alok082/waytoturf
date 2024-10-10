import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:waytoturf/Screens/userdetail.dart';
import 'package:waytoturf/helper.dart';
import 'package:waytoturf/reusablewidgets.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';

class OtpScreen extends StatefulWidget {
  OtpScreen({super.key, required this.verificationiId});

  String verificationiId;
  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final _pinPutController = TextEditingController();
  int time = 30;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (time == 0) {
        timer.cancel();
      } else {
        setState(() {
          time--;
        });
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel(); // Cancel the timer when the widget is disposed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
                'assets/background.jpeg'), // Replace with your image path
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: EdgeInsets.only(top: 40),
                  child: Icon(
                    CupertinoIcons.back,
                    size: 38,
                  ),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.15),
              // Welcome text
              const Text(
                'Mobile Number',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 32,
                    fontWeight: FontWeight.w400),
              ),
              const SizedBox(height: 15),
              // Instruction text
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 35),
                child: Text(
                  textAlign: TextAlign.center,
                  'OTP has been sent to you on your mobile number, please enter it below',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
              ),
              const SizedBox(height: 20),
              // TextField for OTP
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: OtpTextField(
                  numberOfFields: 4,
                  borderWidth: 4,
                  fieldHeight: 55,
                  fieldWidth: 55,
                  focusedBorderColor: Colors.black,
                  disabledBorderColor: Colors.black,

                  enabledBorderColor: Color.fromARGB(255, 165, 161, 161),
                  borderColor: Colors.black,

                  borderRadius: BorderRadius.circular(12),
                  margin: EdgeInsets.all(12),
                  //set to true to show as box or false to show as dash
                  showFieldAsBox: true,

                  //runs when a code is typed in
                  onCodeChanged: (String code) {
                    _pinPutController.text = code;

                    //handle validation or checks here
                  },
                  //runs when every textfield is filled
                  onSubmit: (String verificationCode) {
                    // showDialog(
                    //     context: context,
                    //     builder: (context) {
                    //       return AlertDialog(
                    //         title: Text("Verification Code"),
                    //         content: Text('Code entered is $verificationCode'),
                    //       );
                    //     });
                  }, // end onSubmit
                ),
              ),
              const Spacer(),
              const Text("Don't receive OTP?", style: TextStyle(fontSize: 17)),
              // Countdown text
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Resend in ',
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 17)),
                  Text(
                    '${time}s',
                    style: TextStyle(
                      fontSize: 17,
                      color: const Color.fromARGB(255, 0, 129, 84),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              // Button
              CustomButton(
                buttonaction: () async {
                  try {
                    PhoneAuthCredential credential =
                        await PhoneAuthProvider.credential(
                            smsCode: _pinPutController.text.toString(),
                            verificationId: widget.verificationiId);
                    FirebaseAuth.instance.signInWithCredential(credential).then(
                      (value) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => UserProfilePage(),
                            ));
                      },
                    );
                  } catch (e) {
                    DynamicHelperWidget.show("Please enter correct code");
                  }

                  // if (_pinPutController.text != widget.verificationiId) {
                  //   DynamicHelperWidget.show("Please enter correct code");
                  // } else {
                  //   Navigator.push(
                  //       context,
                  //       MaterialPageRoute(
                  //         builder: (context) => UserProfilePage(),
                  //       ));
                  // }

                  // Handle getting OTP again
                  // if (time == 0) {
                  //   setState(() {
                  //     time = 30; // Reset timer
                  //   });
                  //   _startTimer(); // Start the timer again
                  // }
                },
                button_name: 'Verify',
              ),
              SizedBox(
                height: 5,
              ),
              CustomButton(
                buttonaction: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => UserProfilePage()),
                  );
                },
                button_name: 'Direct next billing issue',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
