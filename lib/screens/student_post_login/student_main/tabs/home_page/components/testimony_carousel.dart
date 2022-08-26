import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:nakshekadam/globals.dart';
import 'package:nakshekadam/screens/student_post_login/student_main/tabs/home_page/components/testimony_cards.dart';

class TestimonyCarouselSlider extends StatefulWidget {
  const TestimonyCarouselSlider({
    Key? key,
  }) : super(key: key);

  @override
  State<TestimonyCarouselSlider> createState() =>
      _TestimonyCarouselSliderState();
}

class _TestimonyCarouselSliderState extends State<TestimonyCarouselSlider> {
  final CarouselController _carouselController = CarouselController();
  int _currentIndex = 1;

  @override
  Widget build(BuildContext context) {
    final List<double> tempDimensions = [
      MediaQuery.of(context).size.width,
      MediaQuery.of(context).size.height
    ];
    final double screenHeight = tempDimensions[0] > tempDimensions[1]
        ? tempDimensions[0]
        : tempDimensions[1];
    final double screenWidth = tempDimensions[0] > tempDimensions[1]
        ? tempDimensions[1]
        : tempDimensions[0];

    List<Map<String, dynamic>> testimonyData = [
      {
        "name": "Vinita",
        "role": "Parents",
        "testimony":
            "When i downloaded Nakshe Kadam, i did not expect a single platform could encompass this wide range of features, but this app has surely been a sigh of relief when parents and children look for career choices the first time.",
      },
      {
        "name": "Bhavesh",
        "role": "Student",
        "testimony":
            "I found out about Nakshe Kadam while i was appearing for my class 10th boards, me along with my friends were saved from the dual and simultaneous struggle of getting through exams while also planning for the next stage of our education, with proper updates and great counsellors , Nakshe Kadam is a must have for any high school student.",
      },
      {
        "name": "John",
        "role": "tudent",
        "testimony":
            "I got to know about NaksheKADAM from one of my friends. I was struggling with finding right resources for information regarding scholarships in india. NaksheKADAM became a one stop solution for me to look through various scholarships in india and  scholarships that are particularly beneficial for me. NaksheKADAM made that tedious process of researching throught various websites for relevant career / education related content very easy for me and my friends.",
      },
    ];

    return Column(children: [
      CarouselSlider.builder(
        carouselController: _carouselController,
        itemCount: 3,
        itemBuilder: (context, index, realIndex) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(screenWidth / 30),
            child: TestimonyCard(
              name: testimonyData[index]["name"],
              role: testimonyData[index]["role"],
              testimony: testimonyData[index]["testimony"],
              index: index,
            ),
          );
        },
        options: CarouselOptions(
          viewportFraction: 1,
          autoPlay: true,
          aspectRatio: 0.8,
          enlargeCenterPage: true,
          enlargeStrategy: CenterPageEnlargeStrategy.height,
          onPageChanged: (index, reason) {
            _currentIndex = index;
            setState(() {});
          },
        ),
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [1, 2, 3].asMap().entries.map((entry) {
          return GestureDetector(
            onTap: () => _carouselController.animateToPage(entry.key),
            child: Container(
              width: 12.0,
              height: 12.0,
              margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: (Theme.of(context).brightness == Brightness.dark
                          ? Colors.white
                          : Colors.black)
                      .withOpacity(_currentIndex == entry.key ? 0.9 : 0.4)),
            ),
          );
        }).toList(),
      ),
    ]);
  }
}
