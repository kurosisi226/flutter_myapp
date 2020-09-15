import 'package:flutter/material.dart';
// import 'package:flutter/scheduler.dart';
// import 'package:flutter/services.dart';
// import 'package:yonezawa/firsttab.dart';
// import 'package:yonezawa/landing_Page.dart';
// import 'package:yonezawa/landing_Page2.dart';
import 'package:flutter_wordpress/flutter_wordpress.dart' as wp;
import 'package:yonezawa/details_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  final Widget child;
  HomePage({Key key, this.child}) : super(key: key);
  _HomePageState createState() => _HomePageState();
}

Color PrimaryColor = Colors.grey;
// dynamic _tablength = 7;

final tabNames = ["MCSニュース", "全員周知", "社員ブログ", "社長ブログ", "お気に入り", "チャット", "資料閲覧"];
final tabCplors = [
  Colors.red,
  Colors.orange,
  Colors.green,
  Colors.blue,
  Colors.purpleAccent,
  Colors.pink,
  Colors.cyan
];
final tabHides = [true, true, true, true, true, true, true];
final tabCategoryIds = [0, 18, 19, 18, 19, 18, 19];
// final List<Tab> tabs = <Tab>[
//      Tab(
//         child:Container(
//           alignment: Alignment.center,
//           width: 100,
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10)),
//             color: tabCplors[0]
//           ),
//           child: Text(tabNames[0]),
//         ),
//       ),
//       Tab(
//         child: Container(
//           alignment: Alignment.center,
//             width: 100,
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10)),
//               color: tabCplors[1]
//             ),
//           child: Text(tabNames[1]),
//         ),
//       ),
//       Tab(
//         child: Container(
//         alignment: Alignment.center,
//             width: 100,
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10)),
//               color: tabCplors[2]
//             ),
//         child: Text(tabNames[2]),
//         ),
//       ),
//       Tab(
//         child: Container(
//         alignment: Alignment.center,
//             width: 100,
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10)),
//               color: tabCplors[3]
//             ),
//         child: Text(tabNames[3]),
//         ),
//       ),
//       Tab(
//         child: Container(
//         alignment: Alignment.center,
//             width: 100,
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10)),
//               color: tabCplors[4]
//             ),
//         child: Text(tabNames[4]),
//         ),
//       ),
//       Tab(
//         child: Container(
//           alignment: Alignment.center,
//           width: 100,
//           decoration: BoxDecoration(
//           borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10)),
//           color: tabCplors[5]
//           ),
//           child: Text(tabNames[5]),
//         ),
//       ),
//       Tab(
//         child: Container(
//           alignment: Alignment.center,
//           width: 100,
//           decoration: BoxDecoration(
//           borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10)),
//           color: tabCplors[6]
//           ),
//           child: Text(tabNames[6]),
//         ),
//       ),
//   ];

//---------------------------------
// Tabの作成
//---------------------------------
List<Tab> tabs = [];

_createtab() {
  // _tablength = 0;

  //Tab用リストクリア
  final tabLength = tabs.length;
  for (int i = 0; i < tabLength; i++) {
    tabs.removeAt(0);
  }

  //Tab用リスト作成
  for (int i = 0; i < tabHides.length; i++) {
    print(tabHides[i]);
    if (i == 0 || tabHides[i] == true) {
      // _tablength++;
      tabs.add(
        Tab(
          child: Container(
            alignment: Alignment.center,
            width: 100,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10)),
                color: tabCplors[i]),
            child: Text(tabNames[i]),
          ),
        ),
      );
    }
  }
  //  _createListView();
}

//---------------------------------
// ListViewの作成
//---------------------------------
List<Scaffold> listViews = [];

//動的ListViewの作成
_createListView() {
  //ListView用リストクリア
  final listLength = listViews.length;
  for (int i = 0; i < listLength; i++) {
    listViews.removeAt(0);
  }

  //ListView用リスト作成
  for (int i = 0; i < tabHides.length; i++) {
    if (i == 0) {
      //TOP用
      listViews.add(Scaffold(
        // appBar: AppBar(
        //   title: Text(''),
        //   centerTitle: true,
        // ),
        body: Container(
          child: FutureBuilder(
            future: _fetchPosts(),
            builder:
                (BuildContext context, AsyncSnapshot<List<wp.Post>> snapshot) {
              if (snapshot.connectionState == ConnectionState.none) {
                return Container();
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }

              var listView = ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  wp.Post post = snapshot.data[index];
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DetailsPage(post)));
                    },
                    child: Column(children: <Widget>[
                      SizedBox(
                        height: 40.0,
                      ),
                      ListTile(
                        trailing: Container(
                          height: 100,
                          width: 100,
                          decoration: new BoxDecoration(
                            image: DecorationImage(
                              image: new NetworkImage(
                                  post.featuredMedia.sourceUrl),
                              fit: BoxFit.contain,
                            ),
                            // borderRadius: BorderRadius.circular(5.0),
                          ),
                        ),
                        title: Text(
                          post.title.rendered.toString(),
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                        subtitle: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(post.date.toString().replaceAll('T', ' ')),
                            Text(post.author.name),
                          ],
                        ),
                      ),
                    ]),
                  );
                },
              );
              return listView;
            },
          ),
        ),
      ));
    } else if (tabHides[i] == true) {
      //TOP以外用
      listViews.add(Scaffold(
        // appBar: AppBar(
        //   title: Text(''),
        //   centerTitle: true,
        // ),
        body: Container(
          child: FutureBuilder(
            future: _fetchPostsId(tabCategoryIds[i]),
            builder:
                (BuildContext context, AsyncSnapshot<List<wp.Post>> snapshot) {
              if (snapshot.connectionState == ConnectionState.none) {
                return Container();
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }

              var listView = ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  wp.Post post = snapshot.data[index];
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DetailsPage(post)));
                    },
                    child: Column(children: <Widget>[
                      SizedBox(
                        height: 40.0,
                      ),
                      ListTile(
                        trailing: Container(
                          height: 100,
                          width: 100,
                          decoration: new BoxDecoration(
                            image: DecorationImage(
                              image: new NetworkImage(
                                  post.featuredMedia.sourceUrl),
                              fit: BoxFit.contain,
                            ),
                            // borderRadius: BorderRadius.circular(5.0),
                          ),
                        ),
                        title: Text(
                          post.title.rendered.toString(),
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                        subtitle: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(post.date.toString().replaceAll('T', ' ')),
                            Text(post.author.name),
                          ],
                        ),
                      ),
                    ]),
                  );
                },
              );
              return listView;
            },
          ),
        ),
      ));
    }
  }
}

//---------------------------------
//WordPressのデータ取得と一覧作成
//---------------------------------
wp.WordPress wordPress = wp.WordPress(
  // baseUrl: 'https://bitcoin77777.com/',
  baseUrl: 'http://mcs-future.com/',
);

_getPostImage(wp.Post post) {
  if (post.featuredMedia == null) {
    return SizedBox();
  }
  return Image.network(
    post.featuredMedia.sourceUrl,
    height: 120,
  );
}

_fetchPosts() {
  Future<List<wp.Post>> posts = wordPress.fetchPosts(
      postParams: wp.ParamsPostList(
        context: wp.WordPressContext.view,
        // excludeCategories: [18],
        pageNum: 1,
        perPage: 10,
      ),
      fetchAuthor: true,
      fetchCategories: true,
      fetchFeaturedMedia: true,
      fetchComments: true);

  return posts;
}

_fetchPostsId(int id) {
  Future<List<wp.Post>> posts = wordPress.fetchPosts(
      postParams: wp.ParamsPostList(
        context: wp.WordPressContext.view,
        excludeCategories: [id],
        pageNum: 1,
        perPage: 10,
      ),
      fetchAuthor: true,
      fetchCategories: true,
      fetchFeaturedMedia: true,
      fetchComments: true);

  return posts;
}

//---------------------------------
// _HomePageState
//---------------------------------
class _HomePageState extends State<HomePage> {
  _restoreValues() async {
    var prefs = await SharedPreferences.getInstance();
    setState(() {
      tabHides[0] = prefs.getBool('TOP') ?? true;
      tabHides[1] = prefs.getBool('市役所') ?? true;
      tabHides[2] = prefs.getBool('商工会議所') ?? true;
      tabHides[3] = prefs.getBool('米沢AWARD') ?? true;
      tabHides[4] = prefs.getBool('小中学校') ?? true;
      tabHides[5] = prefs.getBool('図書館') ?? true;
      tabHides[6] = prefs.getBool('Game') ?? true;
      //Tabの作成
      _createtab();
      //ListViewの作成
      _createListView();
    });
  }

  //初期設定
  @override
  void initState() {
    _restoreValues();
    _createtab();
    _createListView();
    super.initState();
  }

  //build
  @override
  Widget build(BuildContext context) {
    print("TAB${tabs.length}");
    int _bottom_index = 0;
    // return MaterialApp(
    return MaterialApp(
      home: DefaultTabController(
        // タブの数
        length: tabs.length,
        child: Scaffold(
          // child: NestedScrollView(
          //   headerSliverBuilder: (
          //     BuildContext context,
          //     bool innerBoxIsScrolled,
          //   ){
          //     return <Widget>[
          //       SliverOverlapAbsorber(
          //         handle: NestedScrollView.sliverOverlapAbsorberHandleFor(
          //           context,
          //         ),

          appBar: AppBar(
            // child: SliverAppBar(
            backgroundColor: Colors.white,
            leading: IconButton(
              icon: Icon(Icons.cached),
              color: Colors.grey,
              onPressed: () {
                _createListView();
              },
            ),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.settings),
              )
            ],

            //elevation: 0,
            bottom: TabBar(
              // タブのオプション
              isScrollable: true,
              //unselectedLabelColor: Colors.white.withOpacity(0.3),
              // unselectedLabelStyle: TextStyle(fontSize: 12.0),
              // labelColor: Colors.yellowAccent,
              // labelStyle: TextStyle(fontSize: 16.0),
              indicatorColor: PrimaryColor,
              indicatorWeight: 4.0,

              unselectedLabelColor: Colors.white,
              //indicatorColor: Colors.redAccent,
              // indicatorSize: TabBarIndicatorSize.tab,
              //indicatorPadding: EdgeInsets.only(left: 0.0, right: 0.0),
              labelPadding: EdgeInsets.symmetric(horizontal: 0.0),

              // onTap: (index){
              //   // debugPrint('{$index}');
              //   switch(index){
              //     case 0:
              //     PrimaryColor=Colors.red;
              //     break;
              //     case 1:
              //     PrimaryColor=Colors.orange;
              //     break;
              //     case 2:
              //     PrimaryColor=Colors.green;
              //     break;
              //     case 3:
              //     PrimaryColor=Colors.blue;
              //     break;
              //     case 4:
              //     PrimaryColor=Colors.purpleAccent;
              //     break;
              //     case 5:
              //     PrimaryColor=Colors.pink;
              //     break;
              //     case 6:
              //     PrimaryColor=Colors.cyan;
              //     break;
              //     default:
              //     PrimaryColor=Colors.grey;
              //   }
              // },
              tabs: tabs,
              //tabs: _createtab(),
            ),
            title: Text('Tabs Demo'),
          ),
          // body: TabBarView(
          //   children: tabs.map((Tab tab) {
          //     return createTab(tab);
          //   }).toList(),
          body: TabBarView(
            // 各タブの内容
            // children: [
            //   // Icon(Icons.directions_car),
            //   //new FirstTab('test'), // 別ファイルで定義しているウィジェットを使用する。
            //   //★★ここも可変にしないとダメ★
            //   createListView(),
            //   createListViewId(18),
            //   createListViewId(19),
            //   //Icon(Icons.directions_transit),
            //   Icon(Icons.directions_car),
            //   Icon(Icons.directions_transit),
            //   Icon(Icons.directions_bike),
            //   Icon(Icons.directions_car)
            // ],
            children: listViews,
          ),
          floatingActionButton: new FloatingActionButton(
            child: new Icon(
              Icons.reorder,
              color: Colors.grey,
            ),
            backgroundColor: Colors.white,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return _GategoryPage();
                  },
                  fullscreenDialog: true, // ダイアログで表示するかどうか
                ),
              );
            },
          ),

          // bottomNavigationBar: BottomNavigationBar(
          //   currentIndex: _bottom_index,
          //   items:<BottomNavigationBarItem>[
          //     BottomNavigationBarItem(
          //       title: Text('buttom'),
          //       icon: Icon(Icons.android),
          //     ),
          //     BottomNavigationBarItem(
          //       title: Text('buttom'),
          //       icon: Icon(Icons.android),
          //     ),
          //   ],
          //   onTap: tapBottomIcon,
          // ),
        ),
      ),
    );
  }

  void tapBottomIcon(int valus) {
    var items = ['Android', 'Heart'];
    setState(() {
      // _bottom_index = values;
    });
  }

  // Widget createTab(Tab tab) {
  Widget createListView() {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text(''),
      //   centerTitle: true,
      // ),
      body: RefreshIndicator(
        onRefresh: () {
          return Future.delayed(const Duration(seconds: 5), () {});
        },
        child: Container(
          child: FutureBuilder(
            future: _fetchPosts(),
            builder:
                (BuildContext context, AsyncSnapshot<List<wp.Post>> snapshot) {
              if (snapshot.connectionState == ConnectionState.none) {
                return Container();
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              return ListView.builder(
                physics: const AlwaysScrollableScrollPhysics(), //?
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  wp.Post post = snapshot.data[index];
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DetailsPage(post)));
                    },
                    child: Column(children: <Widget>[
                      SizedBox(
                        height: 40.0,
                      ),
                      ListTile(
                        trailing: Container(
                          height: 100,
                          width: 100,
                          decoration: new BoxDecoration(
                            image: DecorationImage(
                              image: new NetworkImage(
                                  post.featuredMedia.sourceUrl),
                              fit: BoxFit.contain,
                            ),
                            // borderRadius: BorderRadius.circular(5.0),
                          ),
                        ),
                        title: Text(
                          post.title.rendered.toString(),
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                        subtitle: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(post.date.toString().replaceAll('T', ' ')),
                            Text(post.author.name),
                          ],
                        ),
                      ),
                    ]),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }

  //一覧作成（カテゴリIDで検索）
  Widget createListViewId(int id, {int loopcnt = 0}) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text(''),
      //   centerTitle: true,
      // ),
      body: Container(
        child: FutureBuilder(
          future: _fetchPostsId(id),
          builder:
              (BuildContext context, AsyncSnapshot<List<wp.Post>> snapshot) {
            if (snapshot.connectionState == ConnectionState.none) {
              return Container();
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            loopcnt += 1;
            if (loopcnt == 2) {
              loopcnt = 0;

              var listView = ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  wp.Post post = snapshot.data[index];
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DetailsPage(post)));
                    },
                    child: Column(children: <Widget>[
                      SizedBox(
                        height: 40.0,
                      ),
                      ListTile(
                        trailing: Container(
                          height: 100,
                          width: 100,
                          decoration: new BoxDecoration(
                            image: DecorationImage(
                              image: new NetworkImage(
                                  post.featuredMedia.sourceUrl),
                              fit: BoxFit.contain,
                            ),
                            // borderRadius: BorderRadius.circular(5.0),
                          ),
                        ),
                        title: Text(
                          post.title.rendered.toString(),
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                        subtitle: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(post.date.toString().replaceAll('T', ' ')),
                            Text(post.author.name),
                          ],
                        ),
                      ),
                    ]),
                  );
                },
              );
              return listView;
            } else {
              return GridView.builder(
                itemCount: snapshot.data.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.9,
                ),
                itemBuilder: (context, index) {
                  wp.Post post = snapshot.data[index];
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DetailsPage(post)));
                    },
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Column(
                          children: <Widget>[
                            _getPostImage(post),
                            SizedBox(
                              height: 8,
                            ),
                            Text(
                              post.title.rendered.toString(),
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 15),
                            ),
                            // SizedBox(height: 15,),
                            //  Html(
                            //   //data: post.excerpt.rendered.toString(),
                            //   data: post.title.rendered.toString(),
                            //   onLinkTap: (String link) {
                            //     _launchUrl(link);
                            //   },
                            // ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(post.date.toString().replaceAll('T', ' ')),
                                Text(post.author.name),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}

//チャネルの表示制御一覧
class _GategoryPage extends StatefulWidget {
  @override
  _GategoryPageState createState() => _GategoryPageState();
}

class _GategoryPageState extends State<_GategoryPage> {
  // bool _isSwitched = false;

  _saveBool(String key, bool value) async {
    var prefs = await SharedPreferences.getInstance();
    prefs.setBool(key, value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text('チャンネル'),
      ),
      body: ListView.builder(
        itemCount: tabNames.length,
        itemBuilder: (context, index) {
          return Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Colors.black38),
              ),
            ),
            child: ListTile(
              leading: const Icon(Icons.flight_land),
              title: Text(tabNames[index]),
              trailing: createSwitch(index),

              // subtitle: Text('&listItem'),
              // onTap: () { /* react to the tile being tapped */ },
            ),
          );
        },
      ),
    );
  }

  //スイッチの制御
  Widget createSwitch(int index) {
    if (index != 0) {
      return Switch(
        value: tabHides[index],
        activeColor: Colors.pink,
        activeTrackColor: Colors.pinkAccent,
        onChanged: (value) {
          setState(() {
            tabHides[index] = value;
            _saveBool(tabNames[index], value);
            _createtab();
            _createListView();
            if (value == true) {
              print(tabHides[index]);
            }
          });
        },
      );
    } else {
      return null;
    }
  }
}
