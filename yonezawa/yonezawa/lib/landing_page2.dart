import 'package:flutter/material.dart';
import 'package:flutter_wordpress/flutter_wordpress.dart' as wp;
import 'package:flutter_html/flutter_html.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:yonezawa/details_page.dart';


class LandingPage2 extends StatelessWidget {
  
  wp.WordPress wordPress = wp.WordPress(
    baseUrl: 'http://mcs-future.com',
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

    return posts;
  }

  _getPostImage(wp.Post post) {
    if (post.featuredMedia == null) {
      return SizedBox();
    }
    return Image.network(post.featuredMedia.sourceUrl,height: 120,);
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
                        builder: (context) => DetailsPage(post)
                      )
                    );
                  },
                  child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Column(
                          children: <Widget>[
                             _getPostImage(post), 
                            SizedBox(height: 8,),
                            Text(
                              post.title.rendered.toString(), 
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15
                              ),
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
          },
        ),
      ),
    );
  }

}