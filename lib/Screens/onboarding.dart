import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:waytoturf/main.dart';
import 'package:waytoturf/reusablewidgets.dart';
import 'package:waytoturf/Screens/selectlocation.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final List<OnboardingPage> pages = [
    OnboardingPage(
      image: 'assets/2.png',
      title: 'Find Your Favourite Turf ground',
      description: 'Now you can book your ground whenever and wherever',
    ),
    OnboardingPage(
      image: 'assets/1.png',
      title: 'Choose your Turf',
      description:
          'Select and find your favourite turf playground in your city.',
    ),
    OnboardingPage(
      image: 'assets/3.png',
      title: 'Make a slot of booking',
      description: 'Book your favourite games to avoid missing out',
    ),
  ];

  int currentPage = 0;

  void nextPage() {
    if (currentPage < pages.length - 1) {
      setState(() {
        currentPage++;
      });
    } else {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => MapScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: mq.height * 0.05,
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => MapScreen()),
                      );
                    },
                    child: Text(
                      "Skip",
                      style: TextStyle(
                          fontSize: 18, color: Color.fromARGB(255, 0, 129, 84)),
                    ),
                  ),
                ),
                SizedBox(
                  height: mq.height * 0.18,
                ),
                Image.asset(
                  pages[currentPage].image,
                  width: double.infinity,
                  height: 300,
                  fit: BoxFit.fill,
                ),
                SizedBox(
                  height: mq.height * 0.08,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    pages[currentPage].title,
                    style: const TextStyle(
                        fontSize: 22,
                        color: Color.fromARGB(255, 0, 129, 84),
                        fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 7),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Text(
                    pages[currentPage].description,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                ),
                Spacer(),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    pages.length,
                    (index) => DotIndicator(isActive: index == currentPage),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: CustomButton(
                    buttonaction: () {
                      nextPage();
                    },
                    button_name:
                        currentPage < pages.length - 1 ? 'Next' : 'Get Started',
                  ),
                ),

                // SizedBox(height: 40),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class OnboardingPage {
  final String image;
  final String title;
  final String description;

  OnboardingPage({
    required this.image,
    required this.title,
    required this.description,
  });
}

class DotIndicator extends StatelessWidget {
  final bool isActive;

  const DotIndicator({Key? key, required this.isActive}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5),
      width: isActive ? 28 : 10,
      height: 10,
      decoration: BoxDecoration(
        border:
            Border.all(color: const Color.fromARGB(255, 0, 129, 84), width: 2),
        borderRadius: BorderRadius.circular(12),
        // shape: BoxShape.circle,
        color: isActive
            ? const Color.fromARGB(255, 0, 129, 84)
            : const Color.fromARGB(255, 255, 255, 255),
      ),
    );
  }
}
