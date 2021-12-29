// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers

import 'package:eventapp/common/constant.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      body: NestedScrollView(
        headerSliverBuilder: (context, b) {
          return [
            SliverAppBar(
              backgroundColor: background.withOpacity(0.4),
              pinned: true,
              expandedHeight: 150,
              automaticallyImplyLeading: false,
              flexibleSpace: FlexibleSpaceBar(
                titlePadding: EdgeInsets.only(left: 25, bottom: 16),
                title: Text(
                  'Events Friends',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                collapseMode: CollapseMode.pin,
                background: Image.asset(
                  "assets/events2.jpg",
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ];
        },
        body: Container(
          padding: const EdgeInsets.only(
            right: 15,
            left: 15,
          ),
          child: ListView.builder(
            physics: BouncingScrollPhysics(),
            itemCount: 7,
            itemBuilder: (context, i) {
              return GestureDetector(
                onTap: () {
                  // showMore();
                },
                child: ShaderMask(
                  shaderCallback: (rect) {
                    return const LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomRight,
                      colors: [Colors.black, Colors.transparent],
                    ).createShader(
                      Rect.fromLTRB(0, 0, rect.width, rect.height),
                    );
                  },
                  blendMode: BlendMode.dstIn,
                  child: Container(
                    margin: const EdgeInsets.all(8),
                    decoration: const BoxDecoration(
                      color: Color(0xffffffff),
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(20.0),
                        bottom: Radius.circular(20.0),
                      ),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 0.2,
                          offset: Offset(1.0, 1.0),
                          spreadRadius: 0.2,
                          color: Color(0x00ffffff),
                        ),
                      ],
                    ),
                    height: 300,
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
