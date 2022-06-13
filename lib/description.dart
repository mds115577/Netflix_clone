import 'package:flutter/material.dart';

class Descritpion extends StatelessWidget {
  final String? name, description, bannerurl, posterurl, vote, launched_on;

  const Descritpion(
      {Key? key,
      this.name,
      this.description,
      this.bannerurl,
      this.posterurl,
      this.vote,
      this.launched_on})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        child: ListView(children: [
          SizedBox(
            height: 250,
            child: Stack(
              children: [
                Positioned(
                    child: SizedBox(
                  height: 250,
                  width: MediaQuery.of(context).size.width,
                  child: Image.network(
                    bannerurl!,
                    fit: BoxFit.cover,
                  ),
                )),
                Positioned(
                  bottom: 10,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(
                      '⭐ Average Rating-' + vote!,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Container(
            child: Text(
              name ?? 'Not Loaded',
              style: const TextStyle(fontSize: 24, color: Colors.white),
            ),
          ),
          Container(
            padding: const EdgeInsets.only(left: 10),
            child: Text(
              'Releasing On ' + launched_on!,
              style: const TextStyle(fontSize: 14, color: Colors.white),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              SizedBox(
                height: 200,
                width: 100,
                child: Image.network(posterurl!),
              ),
              Flexible(
                  child: Container(
                child: Text(
                  description!,
                  style: const TextStyle(fontSize: 18, color: Colors.white),
                ),
              ))
            ],
          )
        ]),
      ),
    );
  }
}
