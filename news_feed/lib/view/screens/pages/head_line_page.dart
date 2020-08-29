import 'package:flutter/material.dart';

class HeadLinePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          child: Center(
            child: Text("HeadLine"),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.refresh), //Todo 更新処理
          onPressed: () => onRefresh(),
        ),
      ),
    );
  }

  //Todo 更新処理
  onRefresh() {
    print("Headlinepage.onRefresh.");
  }
}
