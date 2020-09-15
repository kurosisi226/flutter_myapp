import 'package:flutter/material.dart';
import 'package:flutter_wordpress/flutter_wordpress.dart' as wp;
import 'package:flutter_html/flutter_html.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:yonezawa/details_page.dart';
import 'package:yonezawa/main.dart';



class LandingPage extends StatelessWidget {
  

  wp.WordPress wordPress = wp.WordPress(
    baseUrl: 'https://bitcoin77777.com/',
  );

  _fetchPosts() {
    Future<List<wp.Post>> posts = wordPress.fetchPosts(
      postParams: wp.ParamsPostList(
        context: wp.WordPressContext.view,
        pageNum: 1,
        perPage: 10,        
      ),  
      fetchAuthor: true,
      fetchFeaturedMedia: true,
      fetchComments: true
    );

    readflg=1;

    return posts;
  }

  _getPostImage(wp.Post post) {
    if (post.featuredMedia == null) {
      return SizedBox();
    }
    return Image.network(post.featuredMedia.sourceUrl);
  }

  _launchUrl(String link) async {
    if (await canLaunch(link)) {
      await launch(link);
    } else {
      throw 'Cannot launch $link';
    }
  }

  @override
  Widget build(BuildContext context) {

  // if (readflg == 1){
  //   return null;
  // }

    return Scaffold(
      // appBar: AppBar(
      //   title: Text('WordPress Demo API'),
      //   centerTitle: true,
      // ),
      body: Container(
        child: FutureBuilder(
          future: _fetchPosts(),
          builder: (BuildContext context, AsyncSnapshot<List<wp.Post>> snapshot) {
            if (snapshot.connectionState == ConnectionState.none) {
              return Container();
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context, index) {
                wp.Post post = snapshot.data[index];
                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context, 
                      MaterialPageRoute(
                        builder: (context) => DetailsPage(post)
                      )
                    );
                  },
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 40.0,),
                      ListTile(
                        trailing: Container(
                          height: 100,
                          width: 100,
                          decoration: new BoxDecoration(
                            image: DecorationImage(
                              image: new NetworkImage(post.featuredMedia.sourceUrl),
                              fit: BoxFit.contain,
                            ),
                            // borderRadius: BorderRadius.circular(5.0),
                          ),
                        ),
                        title:
                          Text(
                            post.title.rendered.toString(), 
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18
                            ),
                          ),
                          subtitle:
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(post.date.toString().replaceAll('T', ' ')),
                                Text(post.author.name),
                              ],
                            ),   
                      ),
                    ]
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }

}