import 'package:flutter/material.dart';
import 'package:page_view_sample/page_view/pages.dart';
import 'package:page_view_sample/page_view_builder/page_view_builder_screen.dart';

class PageViewScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("PageView"),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.play_arrow),
        onPressed: () => _moveToPageViewBuilderScreen(context),
      ),
      body: PageView(
        controller: PageController(
          initialPage: 0,
        ),
        children: <Widget>[
          Page1(),
          Page2(),
          Page3(),
        ],
      ),
    );
  }

  _moveToPageViewBuilderScreen(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (_) => PageViewBuilderScreen()));
  }
}
