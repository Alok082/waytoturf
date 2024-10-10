import 'package:flutter/material.dart';
import 'package:waytoturf/main.dart';

class Turnament extends StatelessWidget {
  Turnament({super.key, required this.images});
  List<String> images;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // color: Colors.white,
      height: mq.height * 0.3,
      // width: double.infinity,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        // physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: 4,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Container(
              width: 350,
              child: Material(
                elevation:
                    4.0, // Adjust the elevation value for desired shadow effect
                borderRadius: BorderRadius.circular(
                    10), // Match with the Container's border radius
                child: Stack(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                      height: mq.height * 0.8,
                      decoration: const BoxDecoration(
                          color: Color.fromARGB(255, 255, 255, 255),
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(10),
                              bottomRight: Radius.circular(
                                  10)) // Match the elevation with the Container's border radius
                          ),
                      child: Padding(
                        padding: EdgeInsets.only(
                          top: 10.0,
                          right: 10,
                          left: 10,
                        ), // Padding inside the container
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(8),
                                  ),
                                  child: assetsimagesfit(
                                    images[index],
                                    0.12,
                                    0.12,
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Pavilion Turf', // Your main text here
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500,
                                          color: Color.fromARGB(255, 0, 0, 0),
                                        ),
                                      ),
                                      Text(
                                        'Mangal Compound, MR- 11,Ring Rd, Dewas Naka.', // Your main text here
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Color.fromARGB(
                                              255, 141, 141, 141),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),

                            Text(
                              '₹ 2999 - onwards', // Your main text here
                              style: TextStyle(
                                fontSize: 18,
                                color: Color.fromARGB(255, 0, 0, 0),
                              ),
                            ),
                            // First row with two text widgets

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  // Allow the text to wrap within the available space
                                  child: Text(
                                    'Teams Joins - 4', // Your main text here
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Color.fromARGB(255, 0, 0, 0),
                                    ),
                                  ),
                                ),
                                Container(
                                  height: 35,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      // Add your onPressed functionality here
                                      print('Button Pressed');
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color.fromARGB(
                                          255,
                                          214,
                                          214,
                                          214), // Grey background color
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                            1), // Circular border
                                      ),
                                      // Padding inside the button
                                    ),
                                    child: Text(
                                      'Play Now',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        color: const Color.fromARGB(
                                            255, 0, 0, 0), // Text color
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ), // Space between the text and icon
                            // Row with game icon and name
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0, // Align to the bottom of the container
                      top: 0,
                      right: 0,
                      child: Container(
                        decoration: BoxDecoration(
                            color: Color.fromARGB(255, 0, 129, 84),
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(8),
                                bottomRight: Radius.circular(8))),
                        width: 8, // Height of the bottom line
                        // Bottom color line
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

Widget assetsimagesfit(
  String image,
  double mediaheight,
  double mediawidth,
) {
  return Container(
    // margin: EdgeInsets.only(top: 50),
    height: mq.height * mediaheight,
    width: mq.height * mediawidth,
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(25)),

    child: Image.asset(
      image,
      fit: BoxFit.cover,
    ),
  );
}
