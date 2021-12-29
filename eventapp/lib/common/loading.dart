// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers

import 'package:eventapp/common/constant.dart';
import "package:flutter/material.dart";
import "package:flutter_spinkit/flutter_spinkit.dart";

class Loading extends StatefulWidget {
  final double? pourcent;
  const Loading({Key? key, this.pourcent}) : super(key: key);

  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: background,
        body: Container(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 50,
                  height: 50,
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: lightbackground,
                    borderRadius: BorderRadius.circular(9),
                  ),
                  child: SpinKitPouringHourGlass(
                    size: 40,
                    duration: Duration(milliseconds: 890),
                    color: Colors.orange,
                  ),
                ),
                SizedBox(height: 10),
                if (widget.pourcent != null)
                  Text(
                    "${widget.pourcent} %",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
