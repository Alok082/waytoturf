import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:latlong2/latlong.dart';
import 'package:waytoturf/Screens/authscreen.dart';
import 'package:waytoturf/controller.dart';
import 'package:waytoturf/dependency_injection.dart';
import 'package:waytoturf/locationservices.dart';
import 'package:waytoturf/main.dart';
import 'package:waytoturf/reusablewidgets.dart';

class MapScreen extends StatelessWidget {
  AllController controller = Get.put(AllController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AllController>(
        init: AllController(),
        builder: (_) {
          return Stack(
            children: [
              Scaffold(
                appBar: AppBar(
                  backgroundColor: Colors.white,
                  centerTitle: true,
                  title: Image.asset(
                    'assets/splash.png',
                    width: mq.width * 0.6,
                  ),
                ),
                body: Stack(
                  children: [
                    // Background map
                    const FlutterMaps(),
                    // Rounded container at the bottom
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 10,
                              offset: Offset(0, -5),
                            ),
                          ],
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const SizedBox(
                              height: 12,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  color: Colors.grey.shade400,
                                  borderRadius: BorderRadius.circular(25)),
                              height: 6,
                              width: 80,
                            ),
                            const SizedBox(
                              height: 40,
                            ),
                            const Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                "Set Your Location",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w500),
                              ),
                            ),
                            const SizedBox(
                              height: 6,
                            ),

                            // TextField
                            TextField(
                              onTapOutside: (event) {
                                FocusScope.of(context).unfocus();
                              },
                              decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.all(1),
                                  isDense: true,
                                  prefixIcon: const Icon(
                                    Icons.search,
                                    color: Colors.grey,
                                  ),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      borderSide: const BorderSide(
                                          color: Colors.grey, width: 5)),
                                  hintText: 'Search for location',
                                  hintStyle:
                                      const TextStyle(color: Colors.grey)),
                            ),
                            const SizedBox(height: 10),
                            // Divider
                            const Row(
                              children: [
                                Expanded(
                                    child: Divider(
                                  thickness: 2,
                                )),
                                Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                    "Or",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15),
                                  ),
                                ),
                                Expanded(
                                    child: Divider(
                                  thickness: 2,
                                )),
                              ],
                            ),
                            const SizedBox(height: 10),
                            ElevatedButton(
                              onPressed: () async {
                                await controller.getlocation().then((value) {
                                  if (value) {
                                    print(value);
                                    Navigator.pushReplacement(context,
                                        MaterialPageRoute(
                                      builder: (context) {
                                        return PhoneNumberAuthScreen();
                                      },
                                    ));
                                  } else {
                                    print("somthing went wrong");
                                  }
                                });
                              },
                              style: ElevatedButton.styleFrom(
                                alignment: Alignment.center,
                                backgroundColor:
                                    const Color.fromARGB(255, 0, 129, 84),
                                // elevation: 12,
                                elevation: 0.0,
                                // padding: EdgeInsets.symmetric(horizontal: 10.0),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child: Container(
                                width: double.infinity,
                                padding:
                                    const EdgeInsets.symmetric(vertical: 12.0),
                                child: const Center(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.my_location_rounded,
                                        color: Colors.white,
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        "USE CURRENT LOCATION",
                                        style: TextStyle(
                                          color: Color.fromARGB(
                                              255, 255, 255, 255),
                                          fontSize: 15.0,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            // CustomButton(button_name: '', buttonaction: () {})
                            // Button for current location

                            const SizedBox(
                              height: 35,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
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

class FlutterMaps extends StatefulWidget {
  const FlutterMaps({super.key});

  @override
  State<FlutterMaps> createState() => _FlutterMapsState();
}

class _FlutterMapsState extends State<FlutterMaps> {
  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      options: const MapOptions(
        initialCenter: LatLng(51.509364, 25.128928),
        initialZoom: 9.2,
      ),
      children: [
        TileLayer(
          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          userAgentPackageName: 'com.example.app',
        ),
        RichAttributionWidget(
          attributions: [
            TextSourceAttribution(
              'OpenStreetMap contributors',
              onTap: () =>
                  launchUrl(Uri.parse('https://openstreetmap.org/copyright')),
            ),
          ],
        ),
      ],
    );
  }
}
