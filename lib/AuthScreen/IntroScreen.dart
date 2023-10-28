import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../Dimension.dart';
import '../GoogleSigninPack/Authentication.dart';
import '../Routes/RouteHelper.dart';
import 'SignUpScreen.dart';

class IntroScreen extends StatelessWidget {
  IntroScreen({Key? key}) : super(key: key);

  late bool islogin = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.cyan,
      body: Container(
        height: Dimensions.screenHeight,
        width: Dimensions.screenWidth,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment(6.123234262925839e-17, 1),
              end: Alignment(-1, 6.123234262925839e-17),
              colors: [
                Color.fromRGBO(31, 203, 220, 1),
                Color.fromRGBO(0, 184, 202, 1)
              ]),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 20,
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 50, bottom: 30, right: 0, left: 0),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          height: 42,
                          width: 40,
                          child: Image.asset(
                            'assets/images/logo_w.png',
                          ),
                        ),
                        const Text(
                          " WhereNX",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 32,
                              fontWeight: FontWeight.normal),
                        ),
                      ],
                    ),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const [
                    Text(
                      "Personalizing",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.normal),
                    ),
                    Text(
                      "the local experience",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "for all travelers",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.normal),
                    ),
                  ],
                ),
              ],
            ),
            Column(
              children: [
                Container(
                  padding: const EdgeInsets.only(top: 0, right: 30, bottom: 0, left: 30),
                  child: Row(
                    children: [
                      Container(
                        height: 60,
                        width: 60,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(
                            10,
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: SvgPicture.asset('assets/images/list-s.svg'),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: const [
                                Text(
                                  "Step 1",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            Text(
                              'Select your Delights and we will show you personalized recommendations.',
                              style: TextStyle(
                                  fontSize: Dimensions.size14,
                                  color: Colors.white,
                                  fontWeight: FontWeight.normal),
                              softWrap: false,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis, // new
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(top: 0, right: 30, bottom: 0, left: 30),
                  margin: const EdgeInsets.only(top: 20, right: 0, bottom: 20, left: 0),
                  child: Row(
                    children: [
                      Container(
                        height: 60,
                        width: 60,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(
                            10,
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: SvgPicture.asset('assets/images/loce.svg',
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: const [
                                Text(
                                  "Step 2",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            Text(
                              'Explore your personalized map to see recommendations near you.',
                              style: TextStyle(
                                  fontSize: Dimensions.size14,
                                  color: Colors.white,
                                  fontWeight: FontWeight.normal),
                              softWrap: false,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis, // new
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(top: 0, right: 30, bottom: 0, left: 30),
                  child: Row(
                    children: [
                      Container(
                        height: 60,
                        width: 60,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(
                            10,
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: SvgPicture.asset('assets/images/Pin-s.svg',
                          ),
                        ),
                      ),

                      const SizedBox(
                        width: 10,
                      ),

                      Expanded(
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: const [
                                Text(
                                  "Step 3",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            Text(
                              'Click to see recommended place details or Pin to explore later.',
                              style: TextStyle(
                                  fontSize: Dimensions.size14,
                                  color: Colors.white,
                                  fontWeight: FontWeight.normal),
                              softWrap: false,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis, // new
                            ),
                          ],
                        ),
                      ),

                      // Column(
                      //   mainAxisAlignment: MainAxisAlignment.start,
                      //   crossAxisAlignment: CrossAxisAlignment.start,
                      //   children: [
                      //     Row(
                      //       children: [
                      //         Text("Step 3",style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.bold),),
                      //       ],
                      //     ),
                      //     Row(
                      //       children: [
                      //         Text("Click to see recommended place\ndetails or Pin to explore later.",style: TextStyle(color: Colors.white,fontSize: 15,fontWeight: FontWeight.normal),),
                      //       ],
                      //     ),
                      //
                      //   ],
                      // ),
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 0, right: 30, bottom: 40, left: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () async {

                      Get.toNamed(RouteHelper.getSignUpScreen());

                      // SharedPreferences pre = await SharedPreferences.getInstance();
                      // islogin = pre.getBool("islogin") ?? false;
                      //
                      // if(islogin == false){
                      //
                      //   FirebaseApp firebaseApp = await Firebase.initializeApp();
                      //
                      //   User? user = FirebaseAuth.instance.currentUser;
                      //
                      //   if (user != null) {
                      //
                      //     Get.toNamed(RouteHelper.getHomeScreenpage());
                      //     // Navigator.of(context).pushReplacement(
                      //     //   MaterialPageRoute(
                      //     //     builder: (context) => UserInfoScreen(
                      //     //       user: user,
                      //     //     ),
                      //     //   ),
                      //     // );
                      //   }else{
                      //
                      //     Get.toNamed(RouteHelper.getSignUpScreen());
                      //   }
                      //
                      // }else{
                      //
                      //     Get.toNamed(RouteHelper.getHomeScreenpage());
                      // }

                      // islogin == false ? Get.toNamed(RouteHelper.getSignUpScreen()) :
                      // Get.toNamed(RouteHelper.getHomeScreenpage());
                      // Get.toNamed(RouteHelper.getexploreScreenpage());
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.cyan,
                      minimumSize: Size(Dimensions.screenWidth / 2.5, 50),
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(
                          color: Colors.white,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text('Sign Up',
                        style: TextStyle(color: Colors.white, fontSize: 15)),
                  ),
                  // ElevatedButton(
                  //   onPressed: () async {
                  //
                  //     SharedPreferences pre = await SharedPreferences.getInstance();
                  //     islogin = pre.getBool("islogin") ?? false;
                  //
                  //     islogin == false ? Get.toNamed(RouteHelper.getSignInScreen()) :
                  //     Get.toNamed(RouteHelper.getHomeScreenpage());
                  //     // Get.toNamed(RouteHelper.getexploreScreenpage());
                  //   },
                  //   style: ElevatedButton.styleFrom(
                  //     primary: Colors.white,
                  //     minimumSize: Size(Dimensions.screenWidth / 2.5, 50),
                  //     shape: RoundedRectangleBorder(
                  //       borderRadius: BorderRadius.circular(10),
                  //     ),
                  //   ),
                  //   child: const Text('Sign In',
                  //       style: TextStyle(color: Colors.cyan, fontSize: 15)),
                  // ),
                ],
              ),
            ),
            Container(
              width: Dimensions.screenWidth,
              height: Dimensions.size10,
              child:  FutureBuilder(
                future: Authentication.initializeFirebase(context: context),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return const Text('Error initializing Firebase');
                  } else if (snapshot.connectionState == ConnectionState.done) {
                    return SignUpScreen();
                  }
                  return const CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                      Colors.green,
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
