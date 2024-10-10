import 'package:flutter/material.dart';
import 'package:waytoturf/main.dart';

class Eventcart extends StatelessWidget {
  Eventcart({super.key, required this.images});
  List<String> images;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // color: Colors.white,
      // height: mq.height * 0.28,
      // width: double.infinity,
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: 3,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(8),
                      bottomLeft: Radius.circular(8)),
                  child: assetsimagesfit(
                    images[index],
                    0.16,
                    0.14,
                  ),
                ),
                Expanded(
                  child: Material(
                    elevation:
                        4.0, // Adjust the elevation value for desired shadow effect
                    borderRadius: BorderRadius.circular(
                        10), // Match with the Container's border radius
                    child: Stack(
                      children: [
                        Container(
                          height: mq.height * 0.16,
                          decoration: const BoxDecoration(
                              color: Color.fromARGB(255, 255, 255, 255),
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(10),
                                  bottomRight: Radius.circular(
                                      10)) // Match the elevation with the Container's border radius
                              ),
                          child: const Padding(
                            padding: EdgeInsets.only(
                              top: 10.0,
                              right: 10,
                              left: 10,
                            ), // Padding inside the container
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Sprint and Smash Turf', // Your main text here
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                    color: Color.fromARGB(255, 0, 0, 0),
                                  ),
                                ),
                                // First row with two text widgets
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      // Allow the text to wrap within the available space
                                      child: Text(
                                        'Cricket', // Your main text here
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Color.fromARGB(
                                              255, 117, 117, 117),
                                        ),
                                      ),
                                    ),
                                    Text(
                                      '2 km away', // Your text on the right
                                      style: TextStyle(
                                        fontSize: 16,
                                        color:
                                            Color.fromARGB(255, 117, 117, 117),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      // Allow the text to wrap within the available space
                                      child: Text(
                                        'June 15 - 16', // Your main text here
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Color.fromARGB(
                                              255, 117, 117, 117),
                                        ),
                                      ),
                                    ),
                                    Text(
                                      '₹ 550/-onwards', // Your text on the right
                                      style: TextStyle(
                                        fontSize: 16,
                                        color:
                                            Color.fromARGB(255, 117, 117, 117),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      // Allow the text to wrap within the available space
                                      child: Text(
                                        'Booking Closes On', // Your main text here
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Color.fromARGB(
                                              255, 117, 117, 117),
                                        ),
                                      ),
                                    ),
                                    Text(
                                      "13 june '24", // Your text on the right
                                      style: TextStyle(
                                        fontSize: 16,
                                        color:
                                            Color.fromARGB(255, 117, 117, 117),
                                      ),
                                    ),
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
                            width: 5, // Height of the bottom line
                            // Bottom color line
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
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
