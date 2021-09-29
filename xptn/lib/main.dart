import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:xptn/pages/details.dart';
import 'package:xptn/pages/home.dart';
import 'package:xptn/widget/fab.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  final String title = 'BottomAppBar With Centered FAB';

  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => MaterialApp(
        title: title,
        theme: ThemeData(
            bottomAppBarColor: Colors.transparent,
            floatingActionButtonTheme: FloatingActionButtonThemeData(
                backgroundColor: Colors.lime.shade600)),
        home: MainPage(title: title),
      );
}

class MainPage extends StatefulWidget {
  final String title;

  const MainPage({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int index = 0;

  final pages = <Widget>[
    const Home(),
    const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) => Scaffold(
        extendBody: true,
        body: pages[index],
        bottomNavigationBar: TabBarMaterialWidget(
          index: index,
          onChangedTab: onChangedTab,
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          elevation: 2,
          onPressed: () {
            showModalBottomSheet(
              context: context,
              backgroundColor: Colors.transparent,
              barrierColor: Colors.transparent,
              isScrollControlled: true,
              builder: (context) {
                return Container(
                  height: MediaQuery.of(context).size.height * 0.92,
                  margin: const EdgeInsets.all(1),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(
                        sigmaX: 20.0,
                        sigmaY: 20.0,
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white10,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(20)),
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
                                  margin: const EdgeInsets.symmetric(
                                    vertical: 8,
                                  ),
                                  height: 4,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(2),
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
                                  'Bientot',
                                  style: TextStyle(
                                      fontSize: 25, color: Colors.white),
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
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      );
  void onChangedTab(int index) {
    setState(() {
      this.index = index;
    });
  }
}
