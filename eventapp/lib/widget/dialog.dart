// ignore_for_file: constant_identifier_names, sized_box_for_whitespace, prefer_const_constructors, avoid_unnecessary_containers, dead_code

import "package:flutter/material.dart";

enum Niveau {
  WARNING,
  INFO,
  ERROR,
}

class MyDialog extends StatefulWidget {
  final String? titre;
  final String? description;
  final String? boutton;
  final Niveau? niveau;
  final void Function()? onpress;
  const MyDialog({
    Key? key,
    required this.titre,
    required this.description,
    required this.boutton,
    required this.niveau,
    this.onpress,
  }) : super(key: key);

  @override
  _MyDialogState createState() => _MyDialogState();
}

class _MyDialogState extends State<MyDialog>
    with SingleTickerProviderStateMixin {
  AnimationController? animationController;
  Tween<Offset>? pos;
  Color getColor() {
    switch (widget.niveau) {
      case Niveau.WARNING:
        return Colors.orange;
        break;
      case Niveau.ERROR:
        return Colors.red;
        break;
      default:
        return Colors.green;
    }
  }

  IconData getIcon() {
    switch (widget.niveau) {
      case Niveau.WARNING:
        return Icons.warning;
        break;
      case Niveau.ERROR:
        return Icons.error;
        break;
      default:
        return Icons.info;
    }
  }

  @override
  void initState() {
    animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 600),
    );
    pos = Tween<Offset>(begin: Offset(0, -0.08), end: Offset.zero);

    if (mounted) {
      animationController!.forward();
    }
    super.initState();
  }

  @override
  void dispose() {
    animationController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: pos!.animate(animationController!),
      child: Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.center,
            children: [
              Container(
                height: 200,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: Colors.black.withOpacity(0.8),
                      ),
                      padding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                      child: Text(
                        widget.titre!,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      widget.description!,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 13,
                      ),
                    ),
                    TextButton(
                      onPressed: widget.onpress!,
                      child: Text(
                        widget.boutton!,
                        style: TextStyle(
                          color: getColor(),
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: -20,
                child: Container(
                  padding: EdgeInsets.all(7),
                  decoration: BoxDecoration(
                    color: getColor(),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    getIcon(),
                    color: Colors.white,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
