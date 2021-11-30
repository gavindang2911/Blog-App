import 'dart:io';

import 'package:BlogApp/Model/addBlogModels.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../NetworkHandler.dart';

class BlogCard extends StatelessWidget {
  const BlogCard({Key key, this.addBlogModel, this.networkHandler})
      : super(key: key);

  final AddBlogModel addBlogModel;
  final NetworkHandler networkHandler;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 260,
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      width: MediaQuery.of(context).size.width,
      child: Card(
        child: Stack(
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                image: DecorationImage(
                    image: networkHandler.getImage(addBlogModel.id),
                    fit: BoxFit.fill),
              ),
            ),
            Positioned(
              bottom: 0.1,
              child: Container(
                padding: EdgeInsets.all(7),
                height: 70,
                width: MediaQuery.of(context).size.width - 30,
                decoration: BoxDecoration(
                  color: Colors.white70,
                  // borderRadius: BorderRadius.circular(8)
                ),
                child: Column(
                  children: <Widget>[
                    Text(
                      addBlogModel.title,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "By " + addBlogModel.username,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.w200,
                          fontSize: 12,
                          color: Colors.black45),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
