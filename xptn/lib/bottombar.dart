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
    return BottomNavigationBar(
        elevation: 0,
        currentIndex: widget.index!,
        selectedItemColor: Colors.amber[800],
        onTap: widget.changed,
        backgroundColor: Colors.transparent,
        type: BottomNavigationBarType.fixed,
        unselectedItemColor: Colors.blue,
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
        ]);
  }
}
