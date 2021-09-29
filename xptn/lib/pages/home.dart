import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Pagehome(),
    );
  }
}

class Pagehome extends StatefulWidget {
  const Pagehome({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Pagehome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // ignore: deprecated_member_use
        brightness: Brightness.dark,
        backgroundColor: const Color(0xFF1c1c1c),
        elevation: 0,
        toolbarHeight: 10,
      ),
      body: Container(
        color: const Color(0xFF1c1c1c),
        child: Column(
          children: [
            const Flexible(
              child: Text(
                'MONDAY, SEP 27',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.grey,
                ),
                textAlign: TextAlign.start,
              ),
            ),
            Flexible(
              flex: 4,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    margin: const EdgeInsets.all(10.0),
                    color: Colors.transparent,
                    child: const Align(
                      alignment: Alignment(0.00, 0.00),
                      child: Text(
                        'Events',
                        style: TextStyle(
                          fontSize: 45,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    color: Colors.transparent,
                    child: const Align(
                      alignment: Alignment.centerRight,
                      child: Icon(
                        Icons.account_circle,
                        size: 45,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Flexible(
              flex: 35,
              child: Container(
                padding: const EdgeInsets.only(
                  right: 15,
                  left: 15,
                  // top: 35,
                  // bottom: 20,
                ),
                decoration: const BoxDecoration(
                  color: Color(0xFF1c1c1c),
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(40.0),
                  ),
                ),
                // height: 450,
                // width: 450,
                child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 1),
                    itemBuilder: (BuildContext context, index) {
                      return GestureDetector(
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            backgroundColor: Colors.transparent,
                            barrierColor: Colors.transparent,
                            isScrollControlled: true,
                            builder: (context) {
                              return Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.92,
                                margin: const EdgeInsets.all(1),
                                child: ClipRRect(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(20)),
                                  child: BackdropFilter(
                                    filter: ImageFilter.blur(
                                      sigmaX: 20.0,
                                      sigmaY: 20.0,
                                    ),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white10,
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(20)),
                                        border: Border.all(
                                          color: Colors.black26,
                                          width: 0.5,
                                        ),
                                      ),
                                      child: Column(
                                        children: [
                                          Center(
                                            child: FractionallySizedBox(
                                              widthFactor: 0.10,
                                              child: Container(
                                                margin:
                                                    const EdgeInsets.symmetric(
                                                  vertical: 8,
                                                ),
                                                height: 4,
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(2),
                                                  border: Border.all(
                                                    color: Colors.black12,
                                                    width: 0.5,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: Container(
                                              alignment: Alignment.center,
                                              child: const Text(
                                                'Bientôt',
                                                style: TextStyle(
                                                    fontSize: 25,
                                                    color: Colors.white),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        },
                        child: ShaderMask(
                          shaderCallback: (rect) {
                            return const LinearGradient(
                              begin: Alignment.topRight,
                              end: Alignment.bottomRight,
                              colors: [Colors.black, Colors.transparent],
                            ).createShader(
                                Rect.fromLTRB(0, 0, rect.width, rect.height));
                          },
                          blendMode: BlendMode.dstIn,
                          child: Container(
                            margin: const EdgeInsets.all(8),
                            decoration: const BoxDecoration(
                              color: Color(0xFFffffff),
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
                            // height: 450,
                            // width: 450,
                          ),
                        ),
                      );
                    }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
