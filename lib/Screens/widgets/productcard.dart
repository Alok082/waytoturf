import 'package:flutter/material.dart';
import 'package:waytoturf/main.dart';

class Productcard extends StatelessWidget {
  Productcard({super.key, required this.images});
  List<String> images;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // color: Colors.white,
      // height: mq.height * 0.28,
      // width: double.infinity,
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            childAspectRatio: 2.1 / 3, crossAxisCount: 2, crossAxisSpacing: 1),
        scrollDirection: Axis.vertical,
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: 4,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
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
                    Material(
                      elevation:
                          4.0, // Adjust the elevation value for desired shadow effect
                      borderRadius: BorderRadius.circular(
                          10), // Match with the Container's border radius
                      child: Stack(
                        children: [
                          Container(
                            // height: 120,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 255, 255, 255),
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(12),
                                  bottomRight: Radius.circular(
                                      12)), // Match the elevation with the Container's border radius
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                top: 10.0,
                                right: 10,
                                left: 10,
                              ), // Padding inside the container
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // First row with two text widgets
                                  Text(
                                    'Adult Aluminium Tennis', // Your main text here
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: const Color.fromARGB(255, 0, 0, 0),
                                    ),
                                  ),

                                  Text(
                                    'Racket - TR100', // Text below the first row
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.black,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  )
                                ],
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 0, // Align to the bottom of the container
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
