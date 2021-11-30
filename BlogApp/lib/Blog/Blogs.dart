import 'package:BlogApp/Blog/BlogItem.dart';
import 'package:BlogApp/Common/BlogCard.dart';
import 'package:BlogApp/Model/SuperModel.dart';
import 'package:BlogApp/Model/addBlogModels.dart';
import 'package:BlogApp/NetworkHandler.dart';
import 'package:flutter/material.dart';

class Blogs extends StatefulWidget {
  Blogs({Key key, this.url, this.circular}) : super(key: key);
  final String url;
  bool circular;

  @override
  _BlogsState createState() => _BlogsState();
}

class _BlogsState extends State<Blogs> {
  NetworkHandler networkHandler = NetworkHandler();
  SuperModel superModel = SuperModel();
  List<AddBlogModel> data = [];
  // bool circular;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchData();
  }

  void fetchData() async {
    var response = await networkHandler.get(widget.url);
    superModel = SuperModel.fromJson(response);
    setState(() {
      data = superModel.data;
      widget.circular = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return widget.circular
        ? Padding(
            padding: EdgeInsets.symmetric(vertical: 278),
            child: Center(
                child: CircularProgressIndicator(
              strokeWidth: 2.0,
            )),
          )
        : data.length > 0
            ? Column(
                children: data
                    .map((item) => Column(
                          children: <Widget>[
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (contex) => BlogItem(
                                              addBlogModel: item,
                                              networkHandler: networkHandler,
                                            )));
                              },
                              child: BlogCard(
                                addBlogModel: item,
                                networkHandler: networkHandler,
                              ),
                            ),
                            SizedBox(
                              height: 0,
                            ),
                          ],
                        ))
                    .toList(),
              )
            : widget.url != "/blogpost/getOwnBlog"
                ? Center(child: Text("No post from other users"))
                : Center(child: Text(""));
  }
}
