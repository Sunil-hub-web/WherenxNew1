import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

import 'Routes/RouteHelper.dart';

void main() {
  runApp(const MyApp());
}

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       theme: ThemeData(
//         fontFamily: 'Poppins',
//         //primarySwatch: Colors.grey,
//       ),
//       color: Colors.cyan,
//
//       debugShowCheckedModeBanner: false,
//       title: 'WhereNx',
//       // initialRoute: RouteHelper.getSplashScreenPage(),
//       // getPages: RouteHelper.routes,
//       home: MyPinsScreen(),dart fix --apply
//   }
// }



class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {


    return GetMaterialApp(
      theme: ThemeData(
       fontFamily: 'Poppins',
        //primarySwatch: Colors.grey,
      ),
      color: Colors.cyan,

      debugShowCheckedModeBanner: false,
      title: 'WhereNx',
      initialRoute: RouteHelper.getSplashScreenPage(),
      getPages: RouteHelper.routes,

    );

  }
}
