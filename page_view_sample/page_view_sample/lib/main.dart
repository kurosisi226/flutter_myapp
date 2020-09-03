import 'package:flutter/material.dart';
import 'package:page_view_sample/page_view/page_view_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "PageViewとPageView.builderの違い",
      theme: ThemeData.dark(),
      home: PageViewScreen(),
    );
  }
}
