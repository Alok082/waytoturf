import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:waytoturf/Screens/widgets/eventcart.dart';
import 'package:waytoturf/Screens/widgets/firstcardhome.dart';
import 'package:waytoturf/Screens/widgets/productcard.dart';
import 'package:waytoturf/Screens/widgets/turnament.dart';
import 'package:waytoturf/controller.dart';
import 'package:waytoturf/dependency_injection.dart';
import 'package:waytoturf/title_row.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0; // Track selected index

  // List of items for the Bottom Navigation Bar
  final List<Map<String, dynamic>> _items = [
    {'icon': CupertinoIcons.home, 'label': 'Home'},
    {'icon': Icons.search, 'label': 'Search'},
    {'icon': Icons.notifications, 'label': 'Notify'},
    {'icon': Icons.favorite, 'label': 'Favorites'},
    {'icon': Icons.person, 'label': 'Profile'},
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index; // Update selected index
    });
  }

  TextEditingController _searchController = TextEditingController();

  // Initial selected date
  List<IconData> gameIcons = [
    Icons.sports_cricket, // Icon for Cricket
    Icons.sports_soccer, // Icon for Football
    Icons.sports_basketball, // Icon for Basketball
    Icons.sports_tennis, // Icon for Tennis
    Icons
        .sports_handball, // Icon for Badminton (handball icon as a placeholder)
  ];
  Set<IconData> _selectedGames = {};
  String _selectedDate = '22 May';

  @override
  Widget build(BuildContext context) {
    String path = storage.read('imagePath') ?? '';
    print(">>>" + path);
    AllController controller = Get.put(AllController());

    return GetBuilder<AllController>(
        init: controller,
        builder: (_) {
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: PreferredSize(
              preferredSize:
                  const Size.fromHeight(125.0), // Custom height for AppBar
              child: AppBar(
                surfaceTintColor: Colors.white,
                automaticallyImplyLeading: false,
                backgroundColor: Colors.white,
                elevation: 0,
                flexibleSpace: Padding(
                  padding: const EdgeInsets.only(
                    top: 40.0,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // First row with Location and Profile info
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          children: [
                            Icon(Icons.location_on,
                                color: Colors.black), // Location icon
                            SizedBox(width: 8),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Location',
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 14)),
                                Text(controller.currentcity,
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 12)),
                              ],
                            ),
                            Spacer(),
                            Icon(CupertinoIcons.bell,
                                color: Colors.black), // Notification icon
                            SizedBox(width: 16),

                            Container(
                              width:
                                  40, // Adjust width to fit the CircleAvatar and border
                              height:
                                  40, // Adjust height to fit the CircleAvatar and border
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                    color:
                                        const Color.fromARGB(255, 0, 129, 84),
                                    width: 3), // Green border
                              ),
                              child: CircleAvatar(
                                radius: 18,
                                backgroundImage: path != ''
                                    ? FileImage(File(path))
                                    : AssetImage(
                                        'assets/banner.jpg'), // Add your profile image here
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      // Search field inside AppBar
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: TextField(
                          onTapOutside: (event) {
                            FocusScope.of(context).unfocus();
                          },
                          controller: _searchController,
                          decoration: InputDecoration(
                            isDense: true,
                            hintText: 'Search For Ground',
                            hintStyle: TextStyle(
                                fontWeight: FontWeight.w400,
                                color:
                                    const Color.fromARGB(255, 179, 179, 179)),
                            prefixIcon: const Icon(CupertinoIcons.search),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25),
                              borderSide: const BorderSide(
                                  color: Color.fromARGB(255, 0, 0, 0),
                                  width: 6),
                            ),
                            filled: true,
                            fillColor: const Color.fromARGB(255, 255, 255, 255),
                          ),
                        ),
                      ),
                      const Spacer(),
                      Container(
                        height: 1,
                        color: const Color.fromARGB(255, 214, 214, 214),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.all(15),
                    height: 200,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      image: DecorationImage(
                        image: AssetImage(
                            'assets/banner.jpg'), // Replace with your image path
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      children: [
                        Text(
                          'Available Venues',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const Spacer(),
                        Icon(Icons.settings)
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        // Dropdown for date selection
                        Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 0, 129,
                                84), // Background color for the dropdown
                            borderRadius:
                                BorderRadius.circular(25), // Circular border
                          ),
                          child: DropdownButton<String>(
                            icon: Icon(
                              Icons.keyboard_arrow_down_sharp,
                              color: Colors.white,
                            ),
                            isDense: true,
                            value:
                                _selectedDate, // Directly use _selectedDate without null check
                            items: ['22 May', '23 May', '24 May', '25 May']
                                .map((date) => DropdownMenuItem<String>(
                                      value: date,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal:
                                                8.0), // Add padding for better appearance
                                        child: Text(
                                          date,
                                          style: TextStyle(
                                              color:
                                                  Colors.white), // Text color
                                        ),
                                      ),
                                    ))
                                .toList(),
                            onChanged: (value) {
                              setState(() {
                                _selectedDate = value!;
                              });
                            },
                            dropdownColor: Color.fromARGB(255, 0, 129,
                                84), // Background color of the dropdown menu
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors
                                    .white), // Text color of the dropdown button
                            underline: SizedBox(), // Remove underline
                          ),
                        ),

                        // Vertical divider
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 10),
                          height: 35,
                          color: const Color.fromARGB(255, 165, 164, 164),
                          width: 1,
                        ),
                        // Horizontal list of game icons
                        Expanded(
                          child: Container(
                            height: 50,
                            child: ListView(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              children: gameIcons.map((game) {
                                bool isSelected = _selectedGames.contains(game);
                                return GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      if (isSelected) {
                                        _selectedGames
                                            .remove(game); // Deselect the game
                                      } else {
                                        _selectedGames
                                            .add(game); // Select the game
                                      }
                                    });
                                  },
                                  child: Container(
                                    margin: EdgeInsets.symmetric(horizontal: 8),
                                    padding: EdgeInsets.all(12),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: isSelected
                                          ? Color.fromARGB(255, 0, 129, 84)
                                          : const Color.fromARGB(255, 247, 247,
                                              247), // Change background color based on selection
                                    ),
                                    child: Icon(
                                        game, // Use appropriate icon for each game
                                        color: isSelected
                                            ? const Color.fromARGB(
                                                255, 247, 247, 247)
                                            : Color.fromARGB(255, 0, 129, 84)),
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  DataContainer(
                    images: controller.demoimages,
                  ),
                  TitleRow(
                    buttontext: 'View all',
                    ontapbutton: () {},
                    title: 'Near you Event',
                  ),
                  Eventcart(
                    images: controller.demoimages,
                  ),
                  TitleRow(
                    buttontext: 'View all',
                    ontapbutton: () {},
                    title: 'Product',
                  ),
                  Productcard(
                    images: controller.demoimages,
                  ),
                  TitleRow(
                    buttontext: 'View all',
                    ontapbutton: () {},
                    title: 'Near Upcoming Tournaments',
                  ),
                  Turnament(
                    images: controller.demoimages,
                  ),
                  // another wodget
                ],
              ),
            ),
            bottomNavigationBar: BottomNavigationBar(
              items: _items.map((item) {
                int index = _items.indexOf(item);
                return BottomNavigationBarItem(
                  backgroundColor: const Color.fromARGB(255, 9, 98, 52),
                  icon: Container(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                        color: _selectedIndex == index
                            ? const Color.fromARGB(255, 255, 255, 255)
                            : const Color.fromARGB(0, 255, 255, 255),
                        borderRadius: BorderRadius.circular(25)),
                    // height: 15,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          item['icon'],
                          color: _selectedIndex == index
                              ? const Color.fromARGB(255, 13, 138, 30)
                              : Colors.white,
                        ),
                        SizedBox(height: 4), // Space between icon and label
                        _selectedIndex == index
                            ? Text(
                                item['label'],
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: const Color.fromARGB(255, 6, 72, 41),
                                ),
                              )
                            : SizedBox()
                      ],
                    ),
                  ),
                  label: '', // Leave label empty to manage it in the widget
                );
              }).toList(),
              currentIndex: _selectedIndex,
              selectedItemColor: const Color.fromARGB(255, 209, 87, 87),
              unselectedItemColor: Colors.white,
              showSelectedLabels: false, // Hide default labels
              showUnselectedLabels: false, // Hide default labels
              onTap: _onItemTapped,
            ),
          );
        });
  }
}
