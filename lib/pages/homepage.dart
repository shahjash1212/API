import 'dart:convert';

import 'package:api_integration_app/models/newsinfo.dart';
import 'package:api_integration_app/services/api_manager.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<Welcome> _welcomeModel;

  @override
  void initState() {
    super.initState();
    _welcomeModel = API_MANAGER().getNews();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff333333),
      appBar: AppBar(
        elevation: 10,
        centerTitle: true,
        title: const Text(
          "News",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color(0xff1E1E1E),
        leading: const Icon(
          Icons.menu,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 8.0, right: 8, bottom: 8),
        child: Container(
          child: FutureBuilder<Welcome>(
            future: _welcomeModel,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  itemCount: snapshot.data?.articles!.length,
                  itemBuilder: (context, index) {
                    var article = snapshot.data?.articles![index];

                    // print(snapshot.data);

                    return Container(
                      padding: EdgeInsets.all(3),
                      height: 100,
                      child: Row(
                        children: [
                          Card(
                            clipBehavior: Clip.antiAlias,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)),
                            child: AspectRatio(
                              aspectRatio: 1,
                              child: Image.network(article!.urlToImage,
                                  fit: BoxFit.cover),
                            ),
                          ),
                          // Image.network(article!.urlToImage)
                          Flexible(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 8.0, top: 5),
                              child: Column(
                                children: [
                                  Text(article.title,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Color(0xfffff9de),
                                      )),
                                  Text(article.description,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 3,
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Color(0xfffff9de),
                                      )),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    );
                  },
                );
              } else {
                return Center(
                    child: CircularProgressIndicator(
                  color: Color(0xffa5a5a5),
                ));
              }
            },
          ),
        ),
      ),
    );
  }
}
