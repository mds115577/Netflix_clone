import 'package:flutter/material.dart';

class Search extends StatelessWidget {
  const Search({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: getAppbar(),
      body: SafeArea(child: getBody()),
    );
  }

  getAppbar() {
    return AppBar(
      backgroundColor: Colors.black,
      elevation: 0,
      title: Container(
        height: 35,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.grey.withOpacity(.25),
          borderRadius: BorderRadius.circular(5),
        ),
        child: TextField(
          decoration: InputDecoration(
              border: InputBorder.none,
              hintText: "Search",
              hintStyle: TextStyle(color: Colors.white.withOpacity(.5)),
              prefixIcon: Icon(
                Icons.search,
                color: Colors.white.withOpacity(.5),
              )),
        ),
      ),
    );
  }

  getBody() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(top: 10.0, left: 18, right: 18),
        child: Column(
          children: [
            const Text(
              'Top searches',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 12,
            ),
            Column(
              children: const [],
            )
          ],
        ),
      ),
    );
  }
}
