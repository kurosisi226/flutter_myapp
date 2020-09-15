// import 'dart:io';

import 'package:flutter/material.dart';
import 'package:yonezawa/firsttab.dart';
import 'package:yonezawa/landing_Page.dart';
import 'package:yonezawa/landing_Page2.dart';
import 'package:yonezawa/homepage.dart';

void main() {
  runApp(MyApp());
}

const PrimaryColor = const Color(0xFF151026);
var readflg = 0;

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MCS_NEWS',
      theme: ThemeData(
        primaryColor: Color(0xffffffff),
      ),
      home: HomePage(),
    );
  }
}

//コメントーーー
// Color PrimaryColor = Colors.red;

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: DefaultTabController(
//         // タブの数
//         length: 7,
//         child: Scaffold(
//           appBar: AppBar(
//             backgroundColor: Colors.white,

//             //elevation: 0,
//             bottom: TabBar(
//               // タブのオプション
//               isScrollable: true,
//               //unselectedLabelColor: Colors.white.withOpacity(0.3),
//               // unselectedLabelStyle: TextStyle(fontSize: 12.0),
//               // labelColor: Colors.yellowAccent,
//               // labelStyle: TextStyle(fontSize: 16.0),
//               indicatorColor: PrimaryColor,
//               indicatorWeight: 4.0,

//               unselectedLabelColor: Colors.white,
//               //indicatorColor: Colors.redAccent,
//               // indicatorSize: TabBarIndicatorSize.tab,
//               // indicatorPadding: EdgeInsets.only(left: 0.0, right: 0.0),
//               labelPadding: EdgeInsets.symmetric(horizontal: 0.0),

//               onTap: (index){
//                 switch(index){
//                   case 0:
//                   PrimaryColor=Colors.red;
//                   break;
//                   case 1:
//                   PrimaryColor=Colors.orange;
//                   break;
//                   case 2:
//                   PrimaryColor=Colors.green;
//                   break;
//                   case 3:
//                   PrimaryColor=Colors.blue;
//                   break;
//                   case 4:
//                   PrimaryColor=Colors.purpleAccent;
//                   break;
//                   case 5:
//                   PrimaryColor=Colors.pink;
//                   break;
//                   case 6:
//                   PrimaryColor=Colors.cyan;
//                   break;
//                   default:
//                   PrimaryColor=Colors.grey;
//                 }
//               },
//               // indicatorSize: TabBarIndicatorSize.label,
//               // indicator: BoxDecoration(
//               //     borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10)),
//               //     color: Colors.redAccent
//               // ),
//                // タブに表示する内容
//               tabs: [
//                       Tab(
//                           child:Container(
//                             alignment: Alignment.center,
//                            // constraints: BoxConstraints.expand(width: 100),
//                             width: 100,
//                             // margin: EdgeInsets.all(0),
//                             // padding: EdgeInsets.all(0.0),

//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10)),
//                               color: Colors.red
//                             ),
//                             //color: Colors.redAccent,
//                             child: Text("総合"),
//                         ),
//                         ),
//                       Tab(
//                         child: Container(
//                           alignment: Alignment.center,
// //                          constraints: BoxConstraints.expand(width: 100),
//                             width: 100,
//                             // margin: EdgeInsets.all(0.0),
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10)),
//                               color: Colors.orange
//                             ),
//                           //color: Colors.blue,
//                           child: Text("市役所"),
//                         ),
//                       ),
//                       Tab(
//                         child: Container(
//                         alignment: Alignment.center,
//                         // constraints: BoxConstraints.expand(width: 80),
//                             width: 100,
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10)),
//                               color: Colors.green
//                             ),
//                         child: Text("商工会議所"),
//                         ),
//                       ),
//                       Tab(
//                         child: Container(
//                         alignment: Alignment.center,
//                             width: 100,
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10)),
//                               color: Colors.blue
//                             ),
//                         child: Text("米沢AWARD"),
//                         ),
//                       ),
//                       Tab(
//                         child: Container(
//                         alignment: Alignment.center,
//                             width: 100,
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10)),
//                               color: Colors.purpleAccent
//                             ),
//                         child: Text("小中学校"),
//                         ),
//                       ),
//                       Tab(
//                         child: Container(
//                         alignment: Alignment.center,
//                             width: 100,
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10)),
//                               color: Colors.pink
//                             ),
//                         child: Text("図書館"),
//                         ),
//                       ),
//                       Tab(
//                         child: Container(
//                         alignment: Alignment.center,
//                             width: 100,
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10)),
//                               color: Colors.cyan
//                             ),
//                         child: Text("Game"),
//                         ),
//                       )
//               ],
//             ),
//             title: Text('Tabs Demo'),
//           ),
//           body: TabBarView(
//             // 各タブの内容
//             children: [
//               // Icon(Icons.directions_car),
//               //new FirstTab('test'), // 別ファイルで定義しているウィジェットを使用する。
//               new LandingPage(),
//               new LandingPage2(),
//               //Icon(Icons.directions_transit),
//               Icon(Icons.directions_bike),
//               Icon(Icons.directions_car),
//               Icon(Icons.directions_transit),
//               Icon(Icons.directions_bike),
//               Icon(Icons.directions_car)
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
//コメントーーー

// const PrimaryColor = Colors.blue;

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter demo',
//       theme: ThemeData(
//         primaryColor: Color(0xffffffff),
//       ),
//       home:HomePage(),
//     );
//   }
// }
