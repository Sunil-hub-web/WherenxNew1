import 'package:flutter/material.dart';
import 'package:wherenxnew1/UserScerrn/DelightsScreen.dart';
import 'EventDetails.dart';
import 'ExploreScreen.dart';
import 'MyPinsScreen.dart';
import 'UserProfile.dart';

import 'package:responsive_sizer/responsive_sizer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  int pageIndex = 0;

  final pages = [
    ExploreScreen(),
    MyPinsScreen(),
    DelightsScreen(),
    // const MenuScreen(),
    UserProfile(),
    EventDetails()
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[pageIndex],
      bottomNavigationBar: buildMyNavBar(context),
    );
  }

  ResponsiveSizer buildMyNavBar(BuildContext context) {

    return ResponsiveSizer(builder: (context,orientation, screenType){

      return Container(
        padding: const EdgeInsets.only(left: 9, top: 0, right: 9, bottom: 0,),
        height: 7.h,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(10.0),
            topLeft: Radius.circular(10.0),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 2.0,
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {
                setState(() {
                  pageIndex = 0;
                });
              },
              child: Container(
                padding: const EdgeInsets.all(5,),
                width: 17.w,
                height: 4.h,
                decoration: BoxDecoration(
                  gradient: pageIndex == 0 ? const LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xFF1FCBDC),
                      Color(0xFF00B8CA),
                    ],
                  ) : const LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.white,
                      Colors.white,
                    ],
                  ),
                  borderRadius: BorderRadius.circular(13.0),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 4.w,
                      height: 3.h,
                      child: Center(
                        child: pageIndex == 0
                            ? Image.asset(
                          'assets/images/explore-w.png',
                        )
                            : Image.asset(
                          'assets/images/explore-g.png',
                        ),
                      ),
                    ),
                    Container(
                      child: pageIndex == 0
                          ?  Text("Explore",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 13.sp,
                          ))
                          : const Text(""),
                    ),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  pageIndex = 1;
                });
              },
              child: Container(
                padding: const EdgeInsets.all(5,),
                width: 17.w,
                height: 4.h,
                decoration: BoxDecoration(
                  gradient: pageIndex == 1 ? const LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xFF1FCBDC),
                      Color(0xFF00B8CA),
                    ],
                  ) : const LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.white,
                      Colors.white,
                    ],
                  ),
                  borderRadius: BorderRadius.circular(13.0),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 4.w,
                      height: 3.h,
                      child: Center(
                        child: pageIndex == 1
                            ? Image.asset(
                          'assets/images/Pin-w.png',
                        )
                            : Image.asset(
                          'assets/images/Pin-g.png',
                        ),
                      ),
                    ),
                    Container(
                      child: pageIndex == 1
                          ? Text("My Pins",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 13.sp,
                          ))
                          : const Text(""),
                    ),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  pageIndex = 2;
                });
              },
              child: Container(
                 padding: const EdgeInsets.all(5,),
                width: 17.w,
                height: 4.h,
                decoration: BoxDecoration(
                  gradient: pageIndex == 2 ? const LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xFF1FCBDC),
                      Color(0xFF00B8CA),
                    ],
                  ) : const LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.white,
                      Colors.white,
                    ],
                  ),
                  borderRadius: BorderRadius.circular(13.0),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 4.w,
                      height: 3.h,
                      child: Center(
                        child: pageIndex == 2
                            ? Image.asset(
                          'assets/images/list-w.png',
                        )
                            : Image.asset(
                          'assets/images/list-g.png',
                        ),
                      ),
                    ),
                    Container(
                      child: pageIndex == 2
                          ? Text("List",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 13.sp,
                          ))
                          : const Text(""),
                    ),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  pageIndex = 3;
                });
              },
              child: Container(
                padding: const EdgeInsets.all(5,),
                width: 17.w,
                height: 4.h,
                decoration: BoxDecoration(
                  gradient: pageIndex == 3 ? const LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xFF1FCBDC),
                      Color(0xFF00B8CA),
                    ],
                  ) : const LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.white,
                      Colors.white,
                    ],
                  ),
                  borderRadius: BorderRadius.circular(13.0),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 4.w,
                      height: 3.h,
                      child: Center(
                        child: pageIndex == 3
                            ? Image.asset(
                          'assets/images/user-w.png',
                        )
                            : Image.asset(
                          'assets/images/user-g.png',
                        ),
                      ),
                    ),
                    Container(
                      child: pageIndex == 3
                          ? Text("User",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 13.sp,
                          ))
                          : const Text(""),
                    ),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  pageIndex = 4;
                });
              },
              child: Container(
                 padding: const EdgeInsets.all(5,),
                width: 17.w,
                height: 4.h,
                decoration: BoxDecoration(
                  gradient: pageIndex == 4 ? const LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xFF1FCBDC),
                      Color(0xFF00B8CA),
                    ],
                  ) : const LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.white,
                      Colors.white,
                    ],
                  ),
                  borderRadius: BorderRadius.circular(13.0),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 5.w,
                      height: 3.h,
                      child: Center(
                        child: pageIndex == 4
                            ? Image.asset(
                          'assets/images/eventwhite.png',
                        )
                            : Image.asset(
                          'assets/images/event.png',
                        ),
                      ),
                    ),
                    Container(
                      child: pageIndex == 4
                          ? Text("Event",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 13.sp,
                          ))
                          : const Text(""),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
