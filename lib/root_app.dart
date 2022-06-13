import 'package:flutter/material.dart';

import 'package:netflix/downloads.dart';
import 'package:netflix/screen_home.dart';
import 'package:netflix/search.dart';

import 'coming_soon.dart';

class RootApp extends StatefulWidget {
  @override
  _RootAppState createState() => _RootAppState();
}

class _RootAppState extends State<RootApp> {
  int activeTab = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      resizeToAvoidBottomInset: false,
      bottomNavigationBar: getFooter(),
      body: getBody(),
    );
  }

  Widget getBody() {
    return IndexedStack(
      index: activeTab,
      children: [
        const ScreenHome(),
        ComingSoon(),
        const Search(),
        const Downloads()
      ],
    );
  }

  Widget getFooter() {
    return Container(
      height: 80,
      decoration: const BoxDecoration(color: Colors.black),
      child: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(items.length, (index) {
            return GestureDetector(
              onTap: () {
                setState(() {
                  activeTab = index;
                });
              },
              child: Column(
                children: [
                  Icon(
                    items[index]['icon'],
                    color: activeTab == index
                        ? Colors.white
                        : Colors.white.withOpacity(0.5),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    items[index]['text'],
                    style: TextStyle(
                        fontSize: 10,
                        color: activeTab == index
                            ? Colors.white
                            : Colors.white.withOpacity(0.5)),
                  )
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}

List items = [
  {"icon": Icons.home, "text": "Home"},
  {"icon": Icons.play_circle, "text": "Coming Soon"},
  {"icon": Icons.search, "text": "Search"},
  {"icon": Icons.download, "text": "Downloads"},
];
// const List mylists = [
//   {"img": "assets/images/img_1.png"},
//   {"img": "assets/images/img_2.png"},
//   {"img": "assets/images/img_3.png"},
//   {"img": "assets/images/img_4.png"},
// ];
// List popularList = [
//   {"img": "assets/images/img_5.png"},
//   {"img": "assets/images/img_6.png"},
//   {"img": "assets/images/img_7.png"},
//   {"img": "assets/images/img_8.png"},
// ];
// List trendingList = [
//   {"img": "assets/images/img_9.png"},
//   {"img": "assets/images/img_10.png"},
//   {"img": "assets/images/img_11.png"},
//   {"img": "assets/images/img_12.png"},
// ];
List comingSoonJso = [
  {
    "img": "assets/images/banner.webp",
    "title_img": "assets/images/title_img.webp",
    "title": "Sentinelle",
    "description":
        "Considered a fool and unfit to lead, Nobunaga rises to power as the head of the Oda clan, spurring dissent among those in his family vying for control.",
    "type": "Gritty - Dark - Action Thriller - Action & Adventure - Drama",
    "date": "Coming Friday",
    "duration": true
  },
  {
    "img": "assets/images/banner_1.webp",
    "title_img": "assets/images/title_img_1.webp",
    "title": "Vincenzo",
    "description":
        "During a visit to his motherland, a Korean-Italian mafia lawyer gives an unrivaled conglomerate a taste of its own medicine with a side of justice.",
    "type": "Gritty - Dark - Action Thriller - Action & Adventure - Drama",
    "date": "New Episode Coming Saturday",
    "duration": false
  },
  {
    "img": "assets/images/banner_2.webp",
    "title_img": "assets/images/title_img_2.webp",
    "title": "Peaky Blinders",
    "description":
        "A notorious gang in 1919 Birmingham, England, is led by the fierce Tommy Shelby, a crime boss set on moving up in the world no matter the cost.",
    "type": "Violence, Sex, Nudity, Language, Substances",
    "date": "2021 June",
    "duration": false
  }
];
