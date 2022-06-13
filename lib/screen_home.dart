import 'package:flutter/material.dart';
import 'package:netflix/description.dart';
import 'package:tmdb_api/tmdb_api.dart';

class ScreenHome extends StatefulWidget {
  const ScreenHome({Key? key}) : super(key: key);

  @override
  State<ScreenHome> createState() => _ScreenHomeState();
}

class _ScreenHomeState extends State<ScreenHome> {
  List trendingMovies = [];
  List popular = [];
  List common = [];
  final String apiKey = '3a856d8fd35f044f4a800b2fd3a09b7a';
  final readAccessToken =
      'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIzYTg1NmQ4ZmQzNWYwNDRmNGE4MDBiMmZkM2EwOWI3YSIsInN1YiI6IjYyYTQxYjJkODUwMDVkMDA2NzZhYjllOCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.lFgsIPqxLhe5cZ-3XFku9rFvhiMXSHdTFZkbspbkk5U';
  @override
  void initState() {
    loadMovies();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.black,
        body: getBody());
  }

  loadMovies() async {
    TMDB tmdbwithCustomLogs = TMDB(ApiKeys(apiKey, readAccessToken),
        logConfig: const ConfigLogger(showLogs: true, showErrorLogs: true));
    Map trendingresult = await tmdbwithCustomLogs.v3.trending.getTrending();
    Map popularResult = await tmdbwithCustomLogs.v3.tv.getTopRated();
    Map commonMovies = await tmdbwithCustomLogs.v3.movies.getTopRated();
    setState(() {
      trendingMovies = trendingresult['results'];
      popular = popularResult['results'];
      common = commonMovies['results'];
    });
  }

  getBody() {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: SingleChildScrollView(
        child: Stack(
          children: [
            // ignore: sized_box_for_whitespace
            Container(
              width: size.height - 80,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      Container(
                        height: 500,
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(
                                  'assets/images/banner.webp',
                                ),
                                fit: BoxFit.cover)),
                      ),
                      Container(
                        height: 500,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                              colors: [
                                Colors.black.withOpacity(0.85),
                                Colors.black.withOpacity(0),
                              ],
                              end: Alignment.topCenter,
                              begin: Alignment.bottomCenter),
                        ),
                      ),
                      // ignore: sized_box_for_whitespace
                      Container(
                        height: 500,
                        width: size.width,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Image.asset(
                              'assets/images/title_img.webp',
                              width: 300,
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            const Text(
                              'Exciting - Sci-Fi Drama - Sci-Fi Adventure',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 11),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: const [
                          Icon(
                            Icons.add,
                            color: Colors.white,
                            size: 25,
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            'My List',
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Colors.white),
                          )
                        ],
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(4)),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              right: 13.0, left: 8, top: 2, bottom: 2),
                          child: Row(
                            children: const [
                              Icon(
                                Icons.play_arrow,
                                color: Colors.black,
                                size: 30,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                'Play',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w600),
                              )
                            ],
                          ),
                        ),
                      ),
                      Column(
                        children: const [
                          Icon(
                            Icons.info_outline,
                            color: Colors.white,
                            size: 25,
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            'Info',
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Colors.white),
                          )
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 40),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(left: 8.0, right: 15),
                        child: Text(
                          'My List',
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: List.generate(common.length, (index) {
                            return InkWell(
                              onTap: () async {
                                await Navigator.of(context)
                                    .push(MaterialPageRoute(
                                        builder: (route) => Descritpion(
                                              name: common[index]['title'],
                                              bannerurl:
                                                  'https://image.tmdb.org/t/p/w500' +
                                                      common[index]
                                                          ['backdrop_path'],
                                              posterurl:
                                                  'https://image.tmdb.org/t/p/w500' +
                                                      common[index]
                                                          ['poster_path'],
                                              description: common[index]
                                                  ['overview'],
                                              vote: common[index]
                                                      ['vote_average']
                                                  .toString(),
                                              launched_on: common[index]
                                                  ['release_date'],
                                            )));
                              },
                              child: Container(
                                margin: const EdgeInsets.only(right: 8),
                                width: 110,
                                height: 160,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(6),
                                    image: DecorationImage(
                                        image: NetworkImage(
                                            'https://image.tmdb.org/t/p/w500' +
                                                common[index]['poster_path']),
                                        fit: BoxFit.cover)),
                              ),
                            );
                          }),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(left: 8.0, right: 15),
                        child: Text(
                          'Popular on Netflix',
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: List.generate(popular.length, (index) {
                            return InkWell(
                              onTap: () async {
                                await Navigator.of(context)
                                    .push(MaterialPageRoute(
                                        builder: (route) => Descritpion(
                                              name: popular[index]
                                                  ['original_name'],
                                              bannerurl:
                                                  'https://image.tmdb.org/t/p/w500' +
                                                      popular[index]
                                                          ['backdrop_path'],
                                              posterurl:
                                                  'https://image.tmdb.org/t/p/w500' +
                                                      popular[index]
                                                          ['poster_path'],
                                              description: popular[index]
                                                  ['overview'],
                                              vote: popular[index]
                                                      ['vote_average']
                                                  .toString(),
                                              launched_on: popular[index]
                                                  ['first_air_date'],
                                            )));
                              },
                              child: Container(
                                margin: const EdgeInsets.only(right: 8),
                                width: 110,
                                height: 160,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(6),
                                    image: DecorationImage(
                                        image: NetworkImage(
                                            'https://image.tmdb.org/t/p/w500' +
                                                popular[index]['poster_path']),
                                        fit: BoxFit.cover)),
                              ),
                            );
                          }),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(left: 8.0, right: 15),
                        child: Text(
                          'Trending Now',
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children:
                              List.generate(trendingMovies.length, (index) {
                            return InkWell(
                              onTap: () async {
                                await Navigator.of(context)
                                    .push(MaterialPageRoute(
                                        builder: (route) => Descritpion(
                                              name: trendingMovies[index]
                                                  ['original_name'],
                                              bannerurl:
                                                  'https://image.tmdb.org/t/p/w500' +
                                                      trendingMovies[index]
                                                          ['backdrop_path'],
                                              posterurl:
                                                  'https://image.tmdb.org/t/p/w500' +
                                                      trendingMovies[index]
                                                          ['poster_path'],
                                              description: trendingMovies[index]
                                                  ['overview'],
                                              vote: trendingMovies[index]
                                                      ['vote_average']
                                                  .toString(),
                                              launched_on: trendingMovies[index]
                                                  ['first_air_date'],
                                            )));
                              },
                              child: Container(
                                margin: const EdgeInsets.only(right: 8),
                                width: 110,
                                height: 160,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(6),
                                    image: DecorationImage(
                                        image: NetworkImage(
                                            'https://image.tmdb.org/t/p/w500' +
                                                trendingMovies[index]
                                                    ['poster_path']),
                                        fit: BoxFit.cover)),
                              ),
                            );
                          }),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
            Container(
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 10.0),
                            child: Image.asset(
                              'assets/images/logo.ico',
                              width: 35,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Row(
                            children: [
                              IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.collections_bookmark,
                                  color: Colors.white,
                                  size: 28,
                                ),
                              ),
                              IconButton(
                                  onPressed: () {},
                                  icon: Image.asset(
                                    'assets/images/profile.jpeg',
                                    width: 26,
                                    height: 26,
                                    fit: BoxFit.cover,
                                  ))
                            ],
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const Text(
                            'TV Shows',
                            style: TextStyle(
                                fontSize: 15,
                                color: Colors.white,
                                fontWeight: FontWeight.w500),
                          ),
                          const Text(
                            'Movies',
                            style: TextStyle(
                                fontSize: 15,
                                color: Colors.white,
                                fontWeight: FontWeight.w500),
                          ),
                          Row(
                            children: const [
                              Text(
                                'Categories',
                                style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500),
                              ),
                              SizedBox(
                                width: 3,
                              ),
                              Icon(
                                Icons.keyboard_arrow_down,
                                color: Colors.white,
                              )
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
