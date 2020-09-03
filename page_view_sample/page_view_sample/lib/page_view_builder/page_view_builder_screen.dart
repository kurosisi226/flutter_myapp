import 'package:flutter/material.dart';

@immutable
class Page {
  final String title;
  final Color color;

  Page({this.title, this.color});
}

class PageViewBuilderScreen extends StatelessWidget {

  final _pages = [
    Page(title: "Page1", color: Colors.redAccent),
    Page(title: "Page2", color: Colors.blueAccent),
    Page(title: "Page3", color: Colors.yellowAccent),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("PageViewBuilder"),
      ),
      body: PageView.builder(
          controller: PageController(initialPage: 1),
          itemCount: _pages.length,
          itemBuilder: (_, int index) => Container(
                color: _pages[index].color,
                child: Center(
                  child: Text(_pages[index].title),
                ),
              )),
    );
  }

}
