import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:waytoturf/Screens/homescreen.dart';
import 'package:waytoturf/dependency_injection.dart';
import 'package:waytoturf/main.dart';
import 'package:waytoturf/reusablewidgets.dart';

class SelectSport extends StatefulWidget {
  @override
  _SelectSportState createState() => _SelectSportState();
}

class _SelectSportState extends State<SelectSport> {
  List<String> items = [
    'Cricket',
    'Football',
    'Basketball',
    'Tennis',
    'Badminton',
    'Golf',
    'Volleyball'
  ];
  Set<String> selectedItems = {}; // To hold the selected items

  // Map for icons relevant to each sport
  Map<String, IconData> sportIcons = {
    'Cricket': Icons.sports_cricket,
    'Football': Icons.sports_soccer,
    'Basketball': Icons.sports_basketball,
    'Tennis': Icons.sports_tennis,
    'Badminton': Icons.sports,
    'Golf': Icons.sports_golf,
    'Volleyball': Icons.sports_volleyball,
  };
  void saveSelectedItems() {
    storage.write('selectedGames', selectedItems.toList());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                    'assets/background.jpeg'), // Replace with your image path
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Page Content
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: mq.height * 0.05),
                const Icon(
                  CupertinoIcons.back,
                  size: 38,
                ),
                SizedBox(height: 10),
                Text(
                  "Select your favourite sport",
                  style: TextStyle(
                      fontSize: 28, height: 2, fontWeight: FontWeight.w500),
                ),
                SizedBox(height: 5),
                // List of items in a Wrap (Selectable)
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: items.map((item) {
                    bool isSelected = selectedItems.contains(item);
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          if (isSelected) {
                            selectedItems.remove(item); // Deselect item
                          } else {
                            selectedItems.add(item); // Select item
                          }
                        });
                      },
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? Color.fromARGB(255, 0, 129, 84)
                              : const Color.fromARGB(0, 255, 255, 255),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: isSelected
                                ? const Color.fromARGB(0, 77, 118, 151)
                                : const Color.fromARGB(0, 158, 158, 158),
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              sportIcons[item], // Add the relevant icon
                              color: isSelected ? Colors.white : Colors.black,
                            ),
                            SizedBox(width: 8),
                            Text(
                              item,
                              style: TextStyle(
                                fontWeight: FontWeight.bold, // Make text bold
                                color: isSelected ? Colors.white : Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),
                Spacer(),
                // Continue Button
                CustomButton(
                    button_name: "Continue",
                    buttonaction: () {
                      saveSelectedItems();
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) {
                          return HomePage();
                        },
                      ));
                    }),
                SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
