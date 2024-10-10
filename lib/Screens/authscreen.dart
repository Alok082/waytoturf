import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:waytoturf/Screens/otpscreen.dart';
import 'package:waytoturf/controller.dart';
import 'package:waytoturf/dependency_injection.dart';
import 'package:waytoturf/helper.dart';
import 'package:waytoturf/main.dart';
import 'package:waytoturf/reusablewidgets.dart';
import 'package:country_picker/country_picker.dart';

class PhoneNumberAuthScreen extends StatelessWidget {
  AllController controller = Get.put(AllController());
  final formKey = GlobalKey<FormState>();
  @override
  PhoneNumberAuthScreen({super.key});
  Widget build(BuildContext context) {
    Color colors = const Color.fromARGB(255, 0, 129, 84);
    return GetBuilder<AllController>(
        init: controller,
        builder: (_) {
          return Stack(
            children: [
              Scaffold(
                body: Form(
                  key: formKey,
                  child: Container(
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
                          SizedBox(
                            height: mq.height * 0.15,
                          ),
                          // Welcome text
                          RichText(
                            text: TextSpan(
                              children: [
                                const TextSpan(
                                  text: 'Welcome to ',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 32,
                                      fontWeight: FontWeight.w400),
                                ),
                                TextSpan(
                                  text: 'way to turf',
                                  style: TextStyle(
                                      color: colors,
                                      fontSize: 32,
                                      fontWeight: FontWeight.w400),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 20),
                          // Instruction text
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 40),
                            child: Text(
                              textAlign: TextAlign.center,
                              'Please enter a 10-digit valid mobile number to recieve OTP',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ),
                          const SizedBox(height: 20),
                          // TextField for mobile number
                          TextFormField(
                            onTapOutside: (event) {
                              FocusScope.of(context).unfocus();
                            },
                            readOnly: false,
                            validator: (val) {
                              // Validation logic
                              if (val == null || val.isEmpty) {
                                return 'Please enter a mobile number';
                              } else if (val.length != 10) {
                                return 'Mobile number must be 10 digits';
                              } else if (!RegExp(r'^[0-9]+$').hasMatch(val)) {
                                return 'Please enter a valid mobile number';
                              }
                              return null; // Return null if the input is valid
                            },
                            controller: controller.mobileNumberController,
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                            onChanged: (p0) {
                              // controller.changebutton();
                            },
                            decoration: InputDecoration(
                              label: Text("Enter mobile number"),
                              labelStyle: TextStyle(
                                  color: const Color.fromARGB(255, 0, 0, 0)),
                              // hintText: 'lbl_mobile_number'.tr,
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.never,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide:
                                      BorderSide(color: Colors.grey, width: 2)),
                              // suffixIcon:
                              //  SendOTPButton("Verify")

                              prefixIcon: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 8.0, top: 13.0, right: 5),
                                  child: GestureDetector(
                                      onTap: () {
                                        showCountryPicker(
                                          favorite: ['In', 'us'],
                                          context: context,
                                          showPhoneCode:
                                              false, // optional. Shows phone code before the country name.
                                          onSelect: (Country country) {
                                            controller
                                                .assigncountrypicker(country);
                                          },
                                        );
                                      },
                                      child: Text(
                                        '${controller.countryCode}',
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(fontSize: 15),
                                      ))),
                            ),
                          ),
                          const Spacer(),
                          const Text('By proceeding, you agree to the'),
                          // Terms and conditions text
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  // Handle terms and conditions tap
                                  // You can navigate to another page or show a dialog
                                },
                                child: Text('Terms and Conditions',
                                    style: TextStyle(color: colors, height: 0)),
                              ),
                              const Text(' and ', style: TextStyle(height: 0)),
                              GestureDetector(
                                onTap: () {
                                  // Handle privacy policy tap
                                  // You can navigate to another page or show a dialog
                                },
                                child: Text(
                                  'Privacy Policy',
                                  style: TextStyle(color: colors, height: 0),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          // Button
                          CustomButton(
                            buttonaction: () async {
                              if (formKey.currentState!.validate()) {
                                // controller.phoneauthentication(context);

                                try {
                                  await FirebaseAuth.instance.verifyPhoneNumber(
                                      phoneNumber: controller.countryCode +
                                          controller
                                              .mobileNumberController.text,
                                      verificationCompleted:
                                          (PhoneAuthCredential credential) {},
                                      verificationFailed:
                                          (FirebaseAuthException e) {
                                        DynamicHelperWidget.show(
                                            e.code.toString());
                                      },
                                      codeSent: (String verificationId,
                                          int? resendToken) {
                                        DynamicHelperWidget.show(
                                            verificationId.toString());
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => OtpScreen(
                                                    verificationiId:
                                                        verificationId,
                                                  )),
                                        );
                                        // Get.toNamed(Approutes.otpscreen,
                                        //     arguments: {'verificationId': verificationId});
                                      },
                                      codeAutoRetrievalTimeout:
                                          (String verificationId) {});
                                } on FirebaseAuthException catch (ex) {
                                  DynamicHelperWidget.show(
                                      ">>>>" + ex.code.toString());
                                }
                                // If the form is valid, proceed with the OTP process
                              }
                            },
                            button_name: 'Get OTP',
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          CustomButton(
                            buttonaction: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => OtpScreen(
                                          verificationiId: '',
                                        )),
                              );
                            },
                            button_name: 'Direct next billing issue',
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Visibility(
                visible: controller.isloading,
                child: Container(
                  height: mq.height * 1,
                  width: mq.width * 1,
                  decoration: const BoxDecoration(),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0),
                    child: Container(
                      color: const Color.fromARGB(255, 0, 0, 0)
                          .withOpacity(0.1), // Adjust the opacity as needed
                    ),
                  ),
                ),
              ),
              Visibility(
                  visible: controller.isloading,
                  child: const Center(
                      child: CupertinoActivityIndicator(
                    color: Color.fromARGB(255, 0, 0, 0),
                    radius: 15,
                  )))
            ],
          );
        });
  }
}
