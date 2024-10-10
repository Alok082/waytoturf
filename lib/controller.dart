import 'package:country_picker/country_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:waytoturf/Screens/otpscreen.dart';
import 'package:waytoturf/consttants.dart';
import 'package:waytoturf/helper.dart';
import 'package:waytoturf/locationservices.dart';

class AllController extends GetxController {
  bool isloading = false;
  TextEditingController mobileNumberController = TextEditingController();

  var countryCode = '+91';

  var countryName = '';

  var countryFlag = '';
  void assigncountrypicker(Country country) {
    print(country.phoneCode);
    countryName = country.name;
    countryCode = "+${country.phoneCode}";
    countryFlag = country.flagEmoji;
    update();
  }

  Position? position;

  //
  //
  Future<bool> getlocation() async {
    isloading = true;
    update();

    try {
      // Check if location services are enabled
      // bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      // if (!serviceEnabled) {
      //   await Geolocator.requestPermission();
      //   // If location services are not enabled, request the user to enable them
      //   // return Future.error('Location services are disabled.');
      // }

      // Check for location permission and request if not already granted
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied ||
            permission == LocationPermission.deniedForever) {
          return false; // Permission denied and cannot continue
        }
      }

      // If permission is granted
      if (permission == LocationPermission.whileInUse ||
          permission == LocationPermission.always) {
        // Get the current location
        position = await LocationService.getCurrentLocation();
        if (position != null) {
          // Retrieve address if position is available
          await getCurrentAddress();
          return true;
        } else {
          return false; // Failed to get the position
        }
      } else {
        return false; // Permission not granted
      }
    } catch (e) {
      // Handle any errors that occur
      return false;
    } finally {
      isloading = false;
      update(); // Update UI state
    }
  }

  String currentAddress = "";
  String currentcity = "Indore";

  Future<void> getCurrentAddress() async {
    print(">>>>>>>>>> called ");
    int retryCount = 3; // Retry limit
    while (retryCount > 0) {
      try {
        List<Placemark> placeMarks = await placemarkFromCoordinates(
            position!.latitude, position!.longitude);

        // Update the address
        currentcity = (placeMarks.first.subAdministrativeArea?.isEmpty ?? true
            ? ''
            : "${placeMarks.first.subAdministrativeArea}, ");
        final address = getFormattedAddress(placeMarks.first);
        currentAddress = address;

        if (currentAddress.isNotEmpty) {
          update(); // Notify listeners
          print(currentAddress);
          return;
        }
      } catch (e) {
        print("Error retrieving address: $e");
      }
      retryCount--; // Decrease retry count
    }
    // If the retry limit is exhausted
    print("Failed to retrieve address after retries.");
    currentAddress = "";
  }

  String getFormattedAddress(Placemark placeMark) {
    return (placeMark.subAdministrativeArea?.isEmpty ?? true
            ? ''
            : "${placeMark.subAdministrativeArea}, ") +
        (placeMark.administrativeArea?.isEmpty ?? true
            ? ''
            : "${placeMark.administrativeArea}, ") +
        (placeMark.country?.isEmpty ?? true ? '' : "${placeMark.country}, ") +
        (placeMark.postalCode?.isEmpty ?? true
            ? ''
            : "${placeMark.postalCode}, ");
  }

  List<String> demoimages = [
    im1,
    im2,
    im3,
    im4,
    im5,
    im6,
    im7,
    im8,
    im9,
    im10,
    im11,
    im12,
  ];

  // firebase authentication
  Future<void> phoneauthentication(BuildContext context) async {
    isloading = true;
    update();
    var phonenumber = mobileNumberController.text;
    print(">>>>" + countryCode + phonenumber);

    try {
      await FirebaseAuth.instance.verifyPhoneNumber(
          phoneNumber: countryCode + phonenumber,
          verificationCompleted: (PhoneAuthCredential credential) {},
          verificationFailed: (FirebaseAuthException e) {
            DynamicHelperWidget.show(e.code.toString());
          },
          codeSent: (String verificationId, int? resendToken) {
            DynamicHelperWidget.show(verificationId.toString());
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => OtpScreen(
                        verificationiId: verificationId,
                      )),
            );
            // Get.toNamed(Approutes.otpscreen,
            //     arguments: {'verificationId': verificationId});
          },
          codeAutoRetrievalTimeout: (String verificationId) {});
    } on FirebaseAuthException catch (ex) {
      DynamicHelperWidget.show(">>>>" + ex.code.toString());
    } finally {
      isloading = false;
      update();
    }
  }
}
