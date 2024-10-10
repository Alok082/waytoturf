import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:waytoturf/Screens/selectsport.dart';
import 'package:waytoturf/dependency_injection.dart';
import 'package:waytoturf/helper.dart';
import 'package:waytoturf/main.dart';
import 'package:waytoturf/reusablewidgets.dart'; // Assuming this contains your ReusableTextFormField

class UserProfilePage extends StatefulWidget {
  @override
  _UserProfilePageState createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  final _key = GlobalKey<FormState>();
  String iswork = 'work';
  String? _imagePath;
  final ImagePicker _picker = ImagePicker();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  DateTime? _dob;
  String? _gender;

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imagePath = pickedFile.path;
      });
    }
  }

  void saveUserDetails() {
    print("Save data");
    // Write each value to storage with a unique key
    storage.write('firstName', _firstNameController.text);
    storage.write('lastName', _lastNameController.text);
    storage.write('email', _emailController.text);
    storage.write('address', _addressController.text);

    if (_dob != null) {
      storage.write('dob', _dob.toString()); // Storing DateTime as a string
    } else {
      storage.write('dob', null);
    }

    storage.write('gender', _gender);
    storage.write('imagePath', _imagePath);
    print("Save data ${storage.read('imagePath')}");
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _key,
      child: Scaffold(
        body: Container(
          height: mq.height,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                  'assets/background.jpeg'), // Replace with your image path
              fit: BoxFit.cover,
            ),
          ),
          padding: const EdgeInsets.all(15.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: mq.height * 0.05),
                const Icon(
                  CupertinoIcons.back,
                  size: 38,
                ),
                Center(
                  child: Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      Container(
                        width:
                            110, // Adjust width to fit the CircleAvatar and border
                        height:
                            110, // Adjust height to fit the CircleAvatar and border
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                              color: const Color.fromARGB(255, 0, 129, 84),
                              width: 5), // Green border
                        ),
                        child: CircleAvatar(
                          radius: 50,
                          backgroundImage: _imagePath != null
                              ? FileImage(File(_imagePath!))
                              : null,
                          child: _imagePath == null
                              ? const Icon(Icons.person, size: 50)
                              : null,
                        ),
                      ),
                      CircleAvatar(
                        radius: 18,
                        backgroundColor: Colors.white,
                        child: FittedBox(
                          child: IconButton(
                            icon: const Icon(Icons.edit),
                            onPressed: _pickImage,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                ReusableTextFormField(
                  prefixicon: Icons.person,
                  hinttext: 'First name',
                  ispasswordtype: false,
                  controller: _firstNameController,
                  validater: (value) {
                    if (value.isEmpty) {
                      return 'First name is required';
                    }
                    if (value.length < 2) {
                      return 'First name must be at least 2 characters long';
                    }
                    return null; // Return null if validation passes
                  },
                ),
                const SizedBox(height: 16),
                ReusableTextFormField(
                  prefixicon: Icons.person,
                  hinttext: 'Last name',
                  ispasswordtype: false,
                  controller: _lastNameController,
                  validater: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Last name is required';
                    }
                    if (value.length < 2) {
                      return 'Last name must be at least 2 characters long';
                    }
                    return null; // Return null if validation passes
                  },
                ),
                const SizedBox(height: 16),
                ReusableTextFormField(
                  prefixicon: Icons.email,
                  hinttext: 'Email ID',
                  ispasswordtype: false,
                  controller: _emailController,
                  validater: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Email is required';
                    }
                    // Basic email pattern validation
                    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                      return 'Enter a valid email address';
                    }
                    return null; // Return null if validation passes
                  },
                  // keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (_dob == null) {
                      return 'Please select your Date of Birth';
                    }
                    // You can add additional validations if needed, such as age restrictions
                    return null;
                  },
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                        onPressed: () async {
                          FocusScope.of(context).requestFocus(FocusNode());
                          _dob = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(1900),
                            lastDate: DateTime.now(),
                          );
                          setState(() {});
                        },
                        icon: const Icon(Icons.calendar_month_rounded)),
                    hintText: 'Select your DOB',
                    prefixIcon: const Icon(Icons.edit_calendar_rounded),
                    prefixIconColor: const Color.fromARGB(255, 0, 129, 84),
                    // Added this
                    // contentPadding: EdgeInsets.all(10),

                    enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          width: 2,
                          color: Color.fromARGB(255, 157, 157, 157),
                        ),
                        borderRadius: BorderRadius.circular(12)),
                    hintStyle: const TextStyle(
                        color: Color.fromARGB(255, 105, 105, 105)),
                    border: OutlineInputBorder(
                      gapPadding: Checkbox.width * 0.1,
                      borderRadius: BorderRadius.circular(15),
                      // borderSide: BorderSide(
                      //   color: const Color.fromARGB(255, 222, 222, 222),
                      // ),
                    ),
                  ),
                  readOnly: true,
                  controller: TextEditingController(
                    text:
                        _dob != null ? "${_dob!.toLocal()}".split(' ')[0] : '',
                  ),
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                 
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select your Gender';
                    }
                    return null;
                  },
                  icon: const Icon(
                    CupertinoIcons.chevron_down,
                    size: 15,
                    color: Colors.black,
                  ),
                  decoration: InputDecoration(
                    hintText: 'Select your Gender',
                    prefixIcon: const Icon(Icons.people_outline_sharp),
                    prefixIconColor: const Color.fromARGB(255, 0, 129, 84),
                    // Added this
                    // contentPadding: EdgeInsets.all(10),

                    enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          width: 2,
                          color: Color.fromARGB(255, 157, 157, 157),
                        ),
                        borderRadius: BorderRadius.circular(12)),
                    hintStyle: const TextStyle(
                        color: Color.fromARGB(255, 105, 105, 105)),
                    border: OutlineInputBorder(
                      gapPadding: Checkbox.width * 0.1,
                      borderRadius: BorderRadius.circular(15),
                      // borderSide: BorderSide(
                      //   color: const Color.fromARGB(255, 222, 222, 222),
                      // ),
                    ),
                  ),
                  value: _gender,
                  items: [
                    const DropdownMenuItem(value: 'male', child: Text('Male')),
                    const DropdownMenuItem(
                        value: 'female', child: Text('Female')),
                    const DropdownMenuItem(
                        value: 'other', child: Text('Other')),
                  ],
                  onChanged: (value) {
                    setState(() {
                      _gender = value;
                    });
                  },
                ),
                const SizedBox(height: 16),
                ReusableTextFormField(
                  prefixicon: Icons.location_on,
                  hinttext: 'Address',
                  ispasswordtype: false,
                  controller: _addressController,
                  validater: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your address';
                    }
                    // You can add further validation here, such as checking for a minimum length
                    return null;
                  },
                ),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: () {
                        setState(() {
                          iswork = 'home';
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                          color: iswork == 'work'
                              ? const Color.fromARGB(0, 0, 0, 0)
                              : Color.fromARGB(255, 0, 129, 84),
                          border: Border.all(
                              color: Color.fromARGB(255, 111, 111, 111),
                              width: 2), // Green border
                          borderRadius: BorderRadius.circular(
                              8), // Optional: Rounded corners
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.home,
                              color: iswork == 'work'
                                  ? Color.fromARGB(255, 0, 129, 84)
                                  : Colors.white,
                            ),
                            SizedBox(width: 8),
                            Text(
                              'Home',
                              style: TextStyle(
                                  color: iswork == 'work'
                                      ? Color.fromARGB(255, 0, 0, 0)
                                      : Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 20), // Space between containers
                    InkWell(
                      onTap: () {
                        setState(() {
                          iswork = 'work';
                        });
                      },
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                          color: iswork == 'work'
                              ? Color.fromARGB(255, 0, 129, 84)
                              : const Color.fromARGB(0, 0, 0, 0),
                          border: Border.all(
                              color: Color.fromARGB(255, 111, 111, 111),
                              width: 2), // Green border
                          borderRadius: BorderRadius.circular(
                              8), // Optional: Rounded corners
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.work,
                                color: iswork == 'work'
                                    ? Colors.white
                                    : Color.fromARGB(255, 0, 129,
                                        84)), // Replace with desired icon
                            SizedBox(width: 8), // Space between icon and text
                            Text(
                              'Work',
                              style: TextStyle(
                                  color: iswork == 'work'
                                      ? Colors.white
                                      : Color.fromARGB(255, 0, 0, 0)),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: mq.height * 0.1,
                ),
                CustomButton(
                    button_name: "Continue",
                    buttonaction: () {
                      if (_key.currentState!.validate()) {
                        if (_imagePath == null) {
                          return DynamicHelperWidget.show(
                              "Please choose profile image");
                        }
                        saveUserDetails();

                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return SelectSport();
                          },
                        ));
                      }
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
