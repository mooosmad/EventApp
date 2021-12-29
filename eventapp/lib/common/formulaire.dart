// ignore_for_file: prefer_const_constructors

import "package:flutter/material.dart";

class Formulaire extends StatefulWidget {
  final Function(String)? onchanged;
  final String? Function(String?)? validator;
  final String? hinText;
  final IconData? icon;
  final TextEditingController? controller;
  const Formulaire({
    Key? key,
    this.onchanged,
    required this.hinText,
    this.icon,
    this.validator,
    this.controller,
  }) : super(key: key);

  @override
  _FormulaireState createState() => _FormulaireState();
}

class _FormulaireState extends State<Formulaire> {
  bool show = false;
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        colorScheme: ColorScheme(
          primary: Colors.orange,
          primaryVariant: Colors.orange,
          secondary: Colors.red,
          secondaryVariant: Colors.red,
          surface: Colors.red,
          background: Colors.red,
          error: Colors.red,
          onPrimary: Colors.red,
          onSecondary: Colors.red,
          onSurface: Colors.red,
          onBackground: Colors.red,
          onError: Colors.red,
          brightness: Brightness.dark,
        ),
      ),
      child: Container(
        padding: EdgeInsets.all(10),
        width: double.infinity,
        height: 65,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            width: 1.5,
            color: Colors.grey,
          ),
        ),
        child: TextFormField(
          controller: widget.controller,
          onChanged: widget.onchanged,
          validator: widget.validator,
          obscureText: widget.icon != null ? !show : false,
          style: TextStyle(
            color: Colors.white,
            fontSize: 17,
          ),
          cursorColor: Colors.white,
          cursorHeight: 20,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: widget.hinText,
            suffixIcon: widget.icon != null
                ? IconButton(
                    onPressed: () {
                      setState(() {
                        show = !show;
                      });
                    },
                    icon: !show
                        ? Icon(Icons.visibility)
                        : Icon(Icons.visibility_off),
                  )
                : null,
            suffixIconColor: Colors.grey,
            hintStyle: TextStyle(
              color: Colors.grey,
              fontSize: 17,
            ),
          ),
        ),
      ),
    );
  }
}
