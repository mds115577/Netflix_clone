import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'movie_api/movie_api.dart';

class ComingSoon extends StatelessWidget {
  const ComingSoon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: const Text(
            "Coming Soon",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          actions: [
            IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.collections_bookmark,
                  size: 28,
                )),
            IconButton(
                onPressed: () {},
                icon: Image.asset(
                  "assets/images/profile.jpeg",
                  width: 26,
                  height: 26,
                  fit: BoxFit.cover,
                ))
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 15, left: 20, right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.notifications_none_outlined,
                          size: 28,
                          color: Colors.white.withOpacity(0.9),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        Text(
                          "Notifications",
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.white.withOpacity(0.9)),
                        )
                      ],
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      size: 22,
                      color: Colors.white.withOpacity(0.9),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: List.generate(comingSoon.length, (index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 220,
                          child: Stack(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: NetworkImage(
                                            "https://image.tmdb.org/t/p/w500" +
                                                comingSoon[index]
                                                    .backdropPath!),
                                        fit: BoxFit.cover)),
                              ),
                              Container(
                                  decoration: BoxDecoration(
                                      color: Colors.black.withOpacity(0.2))),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 20, left: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: [
                                  SizedBox(
                                    width: 230,
                                    child: Text(
                                      comingSoon[index].originalTitle ??
                                          "Name Loading...",
                                      maxLines: 2,
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Column(
                                    children: const [
                                      Icon(
                                        Icons.notifications_none_outlined,
                                        color: Colors.white,
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        "Remind me",
                                        style: TextStyle(
                                            fontSize: 11, color: Colors.white),
                                      )
                                    ],
                                  ),
                                  const SizedBox(
                                    width: 30,
                                  ),
                                  Column(
                                    children: const [
                                      Icon(
                                        Icons.info_outline,
                                        color: Colors.white,
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        "Info",
                                        style: TextStyle(
                                            fontSize: 11, color: Colors.white),
                                      )
                                    ],
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: Text(
                            comingSoon[index].releaseDate ?? "Coming Soon",
                            style:
                                TextStyle(color: Colors.white.withOpacity(0.5)),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 10, right: 10, bottom: 20),
                          child: Text(
                            comingSoon[index].overview ?? "Coming Soon...",
                            style: TextStyle(
                                height: 1.4,
                                color: Colors.white.withOpacity(0.5)),
                          ),
                        ),
                      ],
                    ),
                  );
                }),
              )
            ],
          ),
        ));
  }
}

List<MovieApi> comingSoon = [];

Future<void> getComingSoon() async {
  final _response = await http.get(Uri.parse(
      'https://api.themoviedb.org/3/movie/popular?api_key=3a856d8fd35f044f4a800b2fd3a09b7a'));

  if (_response.statusCode == 200) {
    final result = jsonDecode(_response.body);
    Iterable list = result["results"];
    comingSoon = list.map((movie) => MovieApi.fromJson(movie)).toList();
  } else {
    throw Exception("Failed to load movie");
  }
}
