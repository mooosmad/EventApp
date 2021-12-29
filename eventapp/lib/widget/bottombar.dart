// ignore_for_file: prefer_const_constructors

import 'dart:ui';

import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";

class PoyBottomBar extends StatefulWidget {
  final int? index;
  final ValueChanged<int> changed;
  const PoyBottomBar({Key? key, required this.changed, this.index})
      : super(key: key);

  @override
  _PoyBottomBarState createState() => _PoyBottomBarState();
}

class _PoyBottomBarState extends State<PoyBottomBar> {
  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: BottomNavigationBar(
          elevation: 0,
          currentIndex: widget.index!,
          selectedItemColor: Colors.amber[800],
          onTap: widget.changed,
          backgroundColor: Color(0xFF1c1c1c).withOpacity(0.3),
          type: BottomNavigationBarType.fixed,
          unselectedItemColor: Colors.white,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.square_stack_3d_down_right_fill),
              label: 'Even. Friends',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'Settings',
            ),
          ],
        ),
      ),
    );
  }
}
