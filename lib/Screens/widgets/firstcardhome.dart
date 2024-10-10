import 'package:flutter/material.dart';
import 'package:waytoturf/main.dart';

class DataContainer extends StatelessWidget {
  DataContainer({super.key, required this.images});
  List<String> images;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // color: Colors.white,
      // height: mq.height * 0.28,
      // width: double.infinity,
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: 3,
        itemBuilder: (context, index) {
          return index == 2
              ? Container(
                  margin: EdgeInsets.symmetric(horizontal: 120),
                  width: 100,
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 0, 129, 84), // Background color
                    borderRadius: BorderRadius.circular(30), // Circular border
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "More Turf",
                        style: TextStyle(
                          color: Colors.white, // Text color
                          fontSize: 16, // Text size
                          fontWeight: FontWeight.bold, // Text weight
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Icon(
                        Icons.arrow_forward, // Right arrow icon
                        color: Colors.white, // Icon color
                      ),
                    ],
                  ),
                )
              : Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        children: [
                          Stack(
                            children: [
                              ClipRRect(
                                borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(8),
                                    topRight: Radius.circular(8)),
                                child: assetsimagesfit(
                                  images[index],
                                  0.2,
                                  0.9,
                                ),
                              ),
                              Positioned(
                                bottom:
                                    0, // Position the container at the bottom
                                left: 0,
                                right: 0,
                                child: Container(
                                  height: 50, // Adjust the height as needed
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        Colors.black.withOpacity(
                                            0.0), // Transparent at the top
                                        Colors.black.withOpacity(0.4),
                                        Colors.black // Dark black at the bottom
                                      ],
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                  top: 7,
                                  left: 4,
                                  child: Container(
                                    decoration: const BoxDecoration(
                                      color: Color.fromARGB(255, 0, 129, 84),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(5)),
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    child: const Text(
                                      "30% OFF",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 18),
                                    ),
                                  )),
                              Positioned(
                                  bottom: 3,
                                  right: 0,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 5),
                                    child: const Text(
                                      "4.2 [64]",
                                      style: TextStyle(
                                          color:
                                              Color.fromARGB(255, 255, 231, 12),
                                          fontWeight: FontWeight.w500,
                                          fontSize: 17),
                                    ),
                                  )),
                              Positioned(
                                  bottom: 3,
                                  left: 0,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    child: const Text(
                                      "Sprint and Smash turf",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 18),
                                    ),
                                  ))
                            ],
                          ),
                          Material(
                            elevation:
                                4.0, // Adjust the elevation value for desired shadow effect
                            borderRadius: BorderRadius.circular(
                                10), // Match with the Container's border radius
                            child: Stack(
                              children: [
                                Container(
                                  height: mq.height * 0.15,
                                  decoration: BoxDecoration(
                                    color: const Color.fromARGB(
                                        255, 255, 255, 255),
                                    borderRadius: BorderRadius.circular(
                                        10), // Match the elevation with the Container's border radius
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                      top: 10.0,
                                      right: 10,
                                      left: 10,
                                    ), // Padding inside the container
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        // First row with two text widgets
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              // Allow the text to wrap within the available space
                                              child: Text(
                                                'Near Medanta Hospital, Vijay Nagar', // Your main text here
                                                style: TextStyle(
                                                  fontSize: 18,
                                                  color: const Color.fromARGB(
                                                      255, 117, 117, 117),
                                                ),
                                              ),
                                            ),
                                            Text(
                                              '₹ 2999', // Your text on the right
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500,
                                                color: const Color.fromARGB(
                                                    255, 0, 0, 0),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                            height:
                                                2), // Space between the rows
                                        Text(
                                          '[2 KM]', // Text below the first row
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.black54,
                                          ),
                                        ),
                                        SizedBox(
                                            height:
                                                8), // Space between the text and icon
                                        // Row with game icon and name
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.sports_soccer,
                                              color: Color.fromARGB(
                                                  255, 0, 129, 84),
                                              size: 24, // Game icon size
                                            ),
                                            SizedBox(
                                                width:
                                                    8), // Space between icon and text
                                            Expanded(
                                              // Allow the text to wrap within the available space
                                              child: Text(
                                                'Cricket, Football, Badminton', // Replace with the actual game name
                                                style: TextStyle(
                                                  fontSize: 20,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Positioned(
                                  bottom:
                                      0, // Align to the bottom of the container
                                  left: 0,
                                  right: 0,
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: Color.fromARGB(255, 0, 129, 84),
                                        borderRadius: BorderRadius.only(
                                            bottomLeft: Radius.circular(8),
                                            bottomRight: Radius.circular(8))),
                                    height: 5, // Height of the bottom line
                                    // Bottom color line
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      // Container(
                      //   color: Colors.green,
                      //   // height: 100,
                      //   // width: 100,
                      //   height: mq.height * 0.2,
                      //   width: mq.height * 0.2,

                      //   child:
                      // ),
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
