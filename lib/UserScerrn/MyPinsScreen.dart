import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_share_me/flutter_share_me.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:progress_dialog_null_safe/progress_dialog_null_safe.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wherenxnew1/ApiCallingPage/ShowAllPin.dart';
import 'package:wherenxnew1/ApiCallingPage/ShowNearByLocation.dart';
import 'package:wherenxnew1/ApiCallingPage/ShowRecentPin.dart';
import 'package:wherenxnew1/ApiCallingPage/ViewDelight_List.dart';
import 'package:wherenxnew1/UserScerrn/SearchItemList.dart';
import 'package:wherenxnew1/modelclass/NearByLocationResponse.dart';
import 'package:wherenxnew1/modelclass/RecentPinResponse.dart';
import 'package:wherenxnew1/modelclass/ShowAllPinResponse.dart';
import 'package:wherenxnew1/modelclass/ViewDelightList.dart';
import '../Dimension.dart';
import '../Routes/RouteHelper.dart';
import 'package:http/http.dart' as http;

import 'package:fluttertoast/fluttertoast.dart';


enum Share {
  facebook,
  twitter,
  whatsapp,
  whatsapp_business,
  share_system,
}

class MyPinsScreen extends StatefulWidget {
  const MyPinsScreen({Key? key}) : super(key: key);

  @override
  State<MyPinsScreen> createState() => _MyPinsScreenState();
}

class _MyPinsScreenState extends State<MyPinsScreen> {
  List<Map<String, String>> searchKeywords = [
    {'name': 'All', 'active': "no"},
    {'name': 'Restaurants', 'active': "no"},
    {'name': 'bar', 'active': "no"},
    {'name': 'Shopping', 'active': "no"},
    {'name': 'Museums', 'active': "no"},
    {'name': 'More', 'active': "no"},
  ];
  List<String> icon_black = [
    "assets/images/list-g.png",
    "assets/images/food-g.png",
    "assets/images/drink-g.png",
    "assets/images/shopping-g.png",
    "assets/images/museum-g.png",
    "assets/images/menu-g.png",
  ];
  List<String> icon_white = [
    "assets/images/list-w.png",
    "assets/images/food-w.png",
    "assets/images/drink-w.png",
    "assets/images/shopping-w.png",
    "assets/images/museum-w.png",
    "assets/images/menu.png",
  ];

  int curIndex = -1;

  List<String> elightlistName = [];
  List<UserInfo> elightlistName1 = [];

  List<ShowAllPinResponse> showPinResponse = [];
  List<AllPinList> userinfoPin = [];

  List<NearByLocationResponse> nearByLocation = [];
  List<LocationList> locationList = [];

  List<RecentPinResponse> recentPinResponse = [];
  List<RecentPin> recentPinDet = [];

  late bool islogin = false;
  int userId = 0, radius = 0;
  String value = "0";
  double latitude1 = 0.0, longitude1 = 0.0;

  String googleApikey = "AIzaSyAuFYxq-RX0I1boI5HU5-olArirEi2Ez8k";

  File? file;
  ImagePicker picker = ImagePicker();
  bool videoEnable = false;

  List<Data> dataList = [
    Data(name: "Facebook", imageURL: 'assets/images/facebook_share.png'),
    Data(name: "Whatsapp", imageURL: 'assets/images/whatsapp_share.png'),
    // Data(name: "Whatsapp Business",imageURL: 'assets/images/whatsappbusiness_share.png'),
    Data(name: "Twitter", imageURL: 'assets/images/twitter_share.png'),
    Data(name: "More", imageURL: 'assets/images/more_share.png'),
  ];

  Future<List<UserInfo>> showDelightList() async {
    //elightlistName1.clear();

    SharedPreferences pre = await SharedPreferences.getInstance();

    islogin = pre.getBool("islogin") ?? false;
    userId = pre.getInt("userId") ?? 0;

    String str_userId = userId.toString();

    print("userdetails ${str_userId}");

    http.Response response =
        await ViewDelight_List().getDelightList(str_userId);
    var jsonResponse = json.decode(response.body);
    var delightlistResponse = ViewDelightList.fromJson(jsonResponse);

    if (elightlistName1.isEmpty) {
      if (delightlistResponse.status == "success") {
        if (delightlistResponse.userInfo!.isNotEmpty) {
          for (int i = 0; i < delightlistResponse.userInfo!.length; i++) {
            elightlistName1.add(delightlistResponse.userInfo![i]);
          }
        } else {
          //print("Delight List Not Found");

          Fluttertoast.showToast(
              msg: "Delight List Not Found",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.green,
              textColor: Colors.white,
              fontSize: 16.0);
        }
      } else {
        Fluttertoast.showToast(
            msg: delightlistResponse.message!,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0);
      }
    }

    // Future.delayed(Duration(seconds: 1)).then((value) => setState(() {}));

    return elightlistName1;
  }

  Future<List<AllPinList>> showAppPin() async {
    SharedPreferences pre = await SharedPreferences.getInstance();
    islogin = pre.getBool("islogin") ?? false;
    userId = pre.getInt("userId") ?? 0;

    String str_userId = userId.toString();

    print("userdetails ${str_userId}");

    http.Response responseData = await ShowAllPin().showPinDetails(str_userId);

    var jsonResponse = json.decode(responseData.body);
    var pinlistResponse = ShowAllPinResponse.fromJson(jsonResponse);

    if (userinfoPin.isEmpty) {
      if (pinlistResponse.status == "success") {
        for (int i = 0; i < pinlistResponse.allPinList!.length; i++) {
          userinfoPin.add(pinlistResponse.allPinList![i]);
        }

        value = userinfoPin.length.toString();
      } else {
        Fluttertoast.showToast(
            msg: pinlistResponse.message!,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0);
      }

      // Future.delayed(const Duration(seconds: 1)).then((value) => setState(() {}));
      print(showPinResponse.toString());
    }

    return userinfoPin;
  }

  Future<List<RecentPin>> showRecentAppPin() async {
    SharedPreferences pre = await SharedPreferences.getInstance();
    islogin = pre.getBool("islogin") ?? false;
    userId = pre.getInt("userId") ?? 0;

    String str_userId = userId.toString();

    print("userdetails ${str_userId}");

    http.Response responseData =
        await ShowRecentPin().showRecentPinDetails(str_userId);

    var jsonResponse = json.decode(responseData.body);
    var pinlistResponse = RecentPinResponse.fromJson(jsonResponse);

    if (recentPinDet.isEmpty) {
      if (pinlistResponse.status == "success") {
        for (int i = 0; i < pinlistResponse.recentPin!.length; i++) {
          recentPinDet.add(pinlistResponse.recentPin![i]);
        }

        value = recentPinDet.length.toString();
      } else {
        Fluttertoast.showToast(
            msg: pinlistResponse.message!,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0);
      }

      // Future.delayed(const Duration(seconds: 1)).then((value) => setState(() {}));
      print(recentPinDet.toString());
    }

    return recentPinDet;
  }

  Future<List<LocationList>> _determinePosition() async {
    bool serviceEnabler;
    LocationPermission permission;

    serviceEnabler = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabler) {
      return Future.error("Location services are disabled");
    }

    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();

      if (permission == LocationPermission.denied) {
        return Future.error("Location Permission is denide");
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error("Location Permission is deniedForever");
    }

    Position position = await Geolocator.getCurrentPosition();

    //_getAddressFromLatLng(position);

    latitude1 = position.latitude;
    longitude1 = position.longitude;

    SharedPreferences pre = await SharedPreferences.getInstance();
    islogin = pre.getBool("islogin") ?? false;
    userId = pre.getInt("userId") ?? 0;
    radius = pre.getInt("radius") ?? 0;

    String str_userId = userId.toString();
    String str_radius = radius.toString();
    String str_latitude1 = latitude1.toString();
    String str_longitude1 = longitude1.toString();

    if (radius == 0.0) {
      str_radius = "500";
    }

    print(
        "userdetails ${str_userId},${str_latitude1},${str_longitude1},${str_radius}");

    http.Response response = await ShowNearByLocation()
        .showNearByPin(str_userId, str_latitude1, str_longitude1, str_radius);
    var jsonResponse = jsonDecode(response.body);
    var viewNearByResponse = NearByLocationResponse.fromJson(jsonResponse);

    if (locationList.isEmpty) {
      if (viewNearByResponse.status == "success") {
        if (viewNearByResponse.locationList!.isNotEmpty) {
          for (int j = 0; j < viewNearByResponse.locationList!.length; j++) {
            locationList.add(viewNearByResponse.locationList![j]);
          }
        } else {
          Fluttertoast.showToast(
              msg: "List Not Found",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.green,
              textColor: Colors.white,
              fontSize: 16.0);
        }
      } else {
        Fluttertoast.showToast(
            msg: viewNearByResponse.message!,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0);
      }
    }

    return locationList;
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ));
    return ResponsiveSizer(builder: (context, orientation, screenType) {
      return Scaffold(
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            // height: Dimensions.screenHeight,
            width: 100.w,
            // height: 100.h,
            margin: EdgeInsets.only(top: 0.5.dp),
            child: Column(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(left: 10, right: 10, bottom: 0),
                      child: Column(
                        children: [
                          GestureDetector(
                            onTap: (){
                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                  builder: (context) => SearchItemList(),),);
                            },
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                BorderRadius.circular(Dimensions.size20),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.of(context).pushReplacement(
                                          MaterialPageRoute(
                                            builder: (context) => SearchItemList(),),);
                                      },
                                      child: Row(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.search,
                                            size: 35,
                                            color: Colors.grey[800],
                                          ),
                                          const Text(
                                            "Search My Pins",
                                            style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.normal),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          )

                          // Container(
                          //     margin: const EdgeInsets.only(
                          //         left: 0, right: 0, top: 0, bottom: 0),
                          //     height: Dimensions.size44,
                          //     child: FutureBuilder(
                          //       future: showDelightList(),
                          //       builder: (BuildContext context,
                          //           AsyncSnapshot<dynamic> snapshot) {
                          //         if (snapshot.hasData) {
                          //           return ListView.builder(
                          //             scrollDirection: Axis.horizontal,
                          //             itemCount: elightlistName1.length,
                          //             itemBuilder:
                          //                 (BuildContext context, int index) {
                          //               return _buildItemForChips(index);
                          //             },
                          //           );
                          //         } else {
                          //           return Center(
                          //               child: CircularProgressIndicator());
                          //         }
                          //       },
                          //     )),
                        ],
                      ),
                    ),
                    Container(
                      child: FutureBuilder(
                        future: _determinePosition(),
                        builder: (BuildContext context,
                            AsyncSnapshot<dynamic> snapshot) {
                          if (snapshot.hasData) {
                            return Column(
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(
                                      left: 10, right: 10, top: 10),
                                  padding:
                                      const EdgeInsets.only(left: 5, right: 5),
                                  child: Row(
                                    children: [
                                      const Text(
                                        "Nearby Pins",
                                        style: TextStyle(
                                            fontSize: 15, color: Colors.black),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Container(
                                        height: 20,
                                        padding: const EdgeInsets.only(
                                            left: 6, right: 6),
                                        decoration: BoxDecoration(
                                            color: Colors.grey[400],
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(50))),
                                        child: Text(
                                          // userinfoPin.length == 1 ?  "${0}${userinfoPin.length}" : userinfoPin.length.toString(),
                                          locationList.length > 9
                                              ? locationList.length.toString()
                                              : "${0}${locationList.length.toString()}",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontWeight: FontWeight.normal,
                                            color: Colors.white,
                                            height: 1.6,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  width: Dimensions.screenWidth,
                                  height: 250,
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    scrollDirection: Axis.horizontal,
                                    itemCount: locationList.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return GestureDetector(
                                        onTap: () async {
                                          SharedPreferences pre =
                                              await SharedPreferences
                                                  .getInstance();
                                          pre.setString("placeId",
                                              locationList[index].placeId!);
                                          Get.toNamed(
                                              RouteHelper.getdetailsScreen());
                                        },
                                        child: Container(
                                          width: Dimensions.size150,
                                          padding: const EdgeInsets.only(
                                              bottom: 7.0),
                                          child: Card(
                                            elevation: 5,
                                            shadowColor: Colors.black26,
                                            color: Colors.white,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      Dimensions.size18),
                                            ),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Container(
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                  height: 150,
                                                  margin: const EdgeInsets.only(
                                                      top: 8,
                                                      left: 8,
                                                      right: 8,
                                                      bottom: 2),
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.all(
                                                      Radius.circular(
                                                          Dimensions.size12),
                                                    ),
                                                  ),
                                                  child: getImage(
                                                      "${locationList[index].photolink}"),
                                                ),
                                                Container(
                                                  margin: const EdgeInsets.only(
                                                      left: 5,
                                                      right: 5,
                                                      top: 2),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            "${locationList[index].name}",
                                                            maxLines: 2,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style:
                                                                const TextStyle(
                                                              fontSize: 12,
                                                              color:
                                                                  Colors.black,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      const SizedBox(
                                                        height: 1,
                                                      ),
                                                      Row(
                                                        children: [
                                                          Text(
                                                            "${locationList[index].delightName}",
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style: TextStyle(
                                                                fontSize: 10,
                                                                color: Colors
                                                                    .grey[500],
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal),
                                                          ),
                                                          Text(
                                                            "",
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style: TextStyle(
                                                                fontSize: 10,
                                                                color: Colors
                                                                    .grey[500],
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal),
                                                          ),
                                                        ],
                                                      ),
                                                      const SizedBox(
                                                        height: 1,
                                                      ),
                                                      Row(
                                                        children: [
                                                          Text(
                                                            "",
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style: TextStyle(
                                                                fontSize: 11,
                                                                color: Colors
                                                                    .grey[500],
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                )
                              ],
                            );
                          } else {
                            return Center(child: CircularProgressIndicator());
                          }
                        },
                      ),
                    ),
                    Container(
                      child: FutureBuilder(
                        future: showRecentAppPin(),
                        builder: (BuildContext context,
                            AsyncSnapshot<dynamic> snapshot) {
                          if (snapshot.hasData) {
                            return Column(
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(
                                      left: 5, right: 5, top: 5),
                                  padding:
                                      const EdgeInsets.only(left: 5, right: 5),
                                  child: Row(
                                    children: [
                                      const Text(
                                        "Recently Pinned",
                                        style: TextStyle(
                                            fontSize: 15, color: Colors.black),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Container(
                                        height: 20,
                                        padding: const EdgeInsets.only(
                                            left: 6, right: 6),
                                        decoration: BoxDecoration(
                                            color: Colors.grey[400],
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(50))),
                                        child: Text(
                                          // userinfoPin.length == 1 ?  "${0}${userinfoPin.length}" : userinfoPin.length.toString(),
                                          recentPinDet.length > 9
                                              ? recentPinDet.length.toString()
                                              : "${0}${recentPinDet.length.toString()}",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontWeight: FontWeight.normal,
                                            color: Colors.white,
                                            height: 1.6,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  width: Dimensions.screenWidth,
                                  padding: const EdgeInsets.only(
                                    left: 10,
                                    right: 10,
                                  ),
                                  height: 250,
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: recentPinDet.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return GestureDetector(
                                        onTap: () async {
                                          SharedPreferences pre =
                                              await SharedPreferences
                                                  .getInstance();
                                          pre.setString("placeId",
                                              recentPinDet[index].placeId!);
                                          Get.toNamed(
                                              RouteHelper.getdetailsScreen());
                                        },
                                        child: Container(
                                          width: Dimensions.size150,
                                          padding: const EdgeInsets.only(
                                              bottom: 7.0),
                                          child: Card(
                                            elevation: 5,
                                            shadowColor: Colors.black26,
                                            color: Colors.white,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      Dimensions.size18),
                                            ),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Container(
                                                  width: Dimensions.screenWidth,
                                                  height: 150,
                                                  margin: const EdgeInsets.only(
                                                      top: 8,
                                                      left: 8,
                                                      right: 8,
                                                      bottom: 2),
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.all(
                                                      Radius.circular(
                                                          Dimensions.size12),
                                                    ),
                                                  ),
                                                  child: getImage(
                                                      "${recentPinDet[index].photolink}"),
                                                ),
                                                Container(
                                                  margin: const EdgeInsets.only(
                                                      left: 5,
                                                      right: 5,
                                                      top: 2),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        "${recentPinDet[index].name}",
                                                        maxLines: 2,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: const TextStyle(
                                                          fontSize: 12,
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.normal,
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        height: 1,
                                                      ),
                                                      Row(
                                                        children: [
                                                          Text(
                                                            "${recentPinDet[index].delightName}",
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style: TextStyle(
                                                                fontSize: 11,
                                                                color: Colors
                                                                    .grey[500],
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal),
                                                          ),
                                                          Text(
                                                            "",
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style: TextStyle(
                                                                fontSize: 11,
                                                                color: Colors
                                                                    .grey[500],
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal),
                                                          ),
                                                        ],
                                                      ),
                                                      const SizedBox(
                                                        height: 1,
                                                      ),
                                                      Row(
                                                        children: [
                                                          Text(
                                                            "",
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style: TextStyle(
                                                                fontSize: 11,
                                                                color: Colors
                                                                    .grey[500],
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                )
                              ],
                            );
                          } else {
                            return Center(child: CircularProgressIndicator());
                          }
                        },
                      ),
                    ),
                    Container(
                        child: FutureBuilder(
                      future: showAppPin(),
                      builder: (BuildContext context,
                          AsyncSnapshot<dynamic> snapshot) {
                        if (snapshot.hasData) {
                          return Column(
                            children: [
                              Container(
                                margin: const EdgeInsets.only(
                                  left: 5,
                                  right: 5,
                                  top: 5,
                                ),
                                padding:
                                    const EdgeInsets.only(left: 5, right: 5),
                                child: Row(
                                  //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      children: [
                                        Row(
                                          children: [
                                            const Text(
                                              "All Pins",
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.black),
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Container(
                                              height: 20,
                                              padding: const EdgeInsets.only(
                                                  left: 6, right: 6),
                                              decoration: BoxDecoration(
                                                  color: Colors.grey[400],
                                                  borderRadius:
                                                      const BorderRadius.all(
                                                          Radius.circular(50))),
                                              child: Text(
                                                // userinfoPin.length == 1 ?  "${0}${userinfoPin.length}" : userinfoPin.length.toString(),
                                                userinfoPin.length > 9
                                                    ? userinfoPin.length
                                                        .toString()
                                                    : "${0}${userinfoPin.length.toString()}",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontWeight: FontWeight.normal,
                                                  color: Colors.white,
                                                  height: 1.6,
                                                  fontSize: 12,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: 100.w,
                                height: 60.h,
                                child: ListView.builder(
                                    scrollDirection: Axis.vertical,
                                    itemCount: userinfoPin.length,
                                    itemBuilder: (context, int index) {
                                      return GestureDetector(
                                        onTap: () async {
                                          SharedPreferences pre =
                                              await SharedPreferences
                                                  .getInstance();
                                          pre.setString("placeId",
                                              recentPinDet[index].placeId!);
                                          Get.toNamed(
                                              RouteHelper.getdetailsScreen());
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.only(
                                              left: 10, right: 10),
                                          margin: const EdgeInsets.only(
                                            left: 0,
                                            right: 0,
                                            top: 0,
                                            bottom: 10,
                                          ),
                                          width: 100.w,
                                          height: 16.h,
                                          child: Card(
                                            elevation: 5,
                                            shadowColor: Colors.black26,
                                            color: Colors.white,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      Dimensions.size18),
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Expanded(
                                                  flex: 1, // 20%
                                                  child: Container(
                                                    height: 100.h,
                                                    width: (15.w),
                                                    margin:
                                                        const EdgeInsets.only(
                                                            top: 5,
                                                            left: 10,
                                                            right: 10,
                                                            bottom: 10),
                                                    decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius:
                                                          BorderRadius.all(
                                                        Radius.circular(
                                                            Dimensions.size12),
                                                      ),
                                                    ),
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20),
                                                      // Image border
                                                      child: SizedBox.fromSize(
                                                        size:
                                                            Size.fromRadius(48),
                                                        // Image radius
                                                        child: getImage(
                                                            "${userinfoPin[index].photolink}") /*Image.network(nearbyLocations[index].icon!,)*/,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 2, // 60%
                                                  child: Container(
                                                      // margin:
                                                      //     const EdgeInsets.only(
                                                      //         left: 5,
                                                      //         right: 5,
                                                      //         top: 5),
                                                      child:
                                                          SingleChildScrollView(
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                Container(
                                                                  width: 40.w,
                                                                  child: Text(
                                                                    "${userinfoPin[index].name}",
                                                                    overflow:
                                                                        TextOverflow
                                                                            .ellipsis,
                                                                    maxLines: 5,
                                                                    style: TextStyle(
                                                                        fontSize: 15.sp,
                                                                        color: Colors
                                                                            .black,
                                                                        fontWeight:
                                                                            FontWeight.normal),
                                                                  ),
                                                                ),
                                                                Container(
                                                                  height: 30,
                                                                  child:
                                                                      TextButton(
                                                                    style:
                                                                        ButtonStyle(
                                                                      backgroundColor: MaterialStateProperty.all<
                                                                              Color>(
                                                                          Colors
                                                                              .white),
                                                                    ),
                                                                    onPressed:
                                                                        () {},
                                                                    child: Row(
                                                                      children: <Widget>[
                                                                        SvgPicture
                                                                            .asset(
                                                                          'assets/images/star.svg',
                                                                          width:
                                                                              3.5.w,
                                                                          color:
                                                                              const Color(0xFFF9BF3A),
                                                                        ),
                                                                        const SizedBox(
                                                                          width:
                                                                              2,
                                                                        ),
                                                                        Text(
                                                                          "${userinfoPin[index].rating}",
                                                                          style: TextStyle(
                                                                              fontSize: 14.5.sp,
                                                                              color: Color(0xFF616768),
                                                                              fontWeight: FontWeight.normal),
                                                                        ),
                                                                        // text
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            const SizedBox(
                                                              height: 2,
                                                            ),
                                                            Row(
                                                              children: [
                                                                Text(
                                                                  "${userinfoPin[index].delightName}",
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          15.sp,
                                                                      color: Colors
                                                                              .grey[
                                                                          500],
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .normal),
                                                                ),
                                                                Text(
                                                                  "",
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          11,
                                                                      color: Colors
                                                                              .grey[
                                                                          500],
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .normal),
                                                                ),
                                                              ],
                                                            ),
                                                            const SizedBox(
                                                              height: 2,
                                                            ),
                                                            Row(
                                                              children: [
                                                                Text(
                                                                  "",
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          12,
                                                                      color: Colors
                                                                              .grey[
                                                                          500],
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .normal),
                                                                ),
                                                              ],
                                                            ),
                                                            const SizedBox(
                                                              height: 10,
                                                            ),
                                                            Row(
                                                              children: [
                                                                Container(
                                                                  height: 36,
                                                                  child:
                                                                      TextButton(
                                                                    style:
                                                                        ButtonStyle(
                                                                      backgroundColor: MaterialStateProperty.all<
                                                                              Color>(
                                                                          Colors
                                                                              .white),
                                                                      shape: MaterialStateProperty.all<
                                                                              RoundedRectangleBorder>(
                                                                          RoundedRectangleBorder(
                                                                        borderRadius:
                                                                            BorderRadius.circular(50.0),
                                                                        side:
                                                                            const BorderSide(
                                                                          color:
                                                                              Color(0xFFDDE4E4),
                                                                        ),
                                                                      )),
                                                                      padding: MaterialStateProperty.all<
                                                                              EdgeInsets>(
                                                                          const EdgeInsets
                                                                              .only(
                                                                        left:
                                                                            12,
                                                                        right:
                                                                            12,
                                                                      )),
                                                                    ),
                                                                    onPressed:
                                                                        () {},
                                                                    child: Row(
                                                                      children: <Widget>[
                                                                        SvgPicture
                                                                            .asset(
                                                                          'assets/images/direction-icon.svg',
                                                                          width:
                                                                              18,
                                                                          color:
                                                                              const Color(0xFF00B8CA),
                                                                        ),
                                                                        const SizedBox(
                                                                          width:
                                                                              5,
                                                                        ),
                                                                        const Text(
                                                                          "Directions",
                                                                          style: TextStyle(
                                                                              fontSize: 11,
                                                                              color: Color(0xFF00B8CA),
                                                                              fontWeight: FontWeight.normal),
                                                                        ),
                                                                        // text
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ),
                                                                const SizedBox(
                                                                    width: 10),
                                                                Container(
                                                                  height: 36,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            25),
                                                                    gradient: const LinearGradient(
                                                                        begin: Alignment
                                                                            .topCenter,
                                                                        end: Alignment.bottomCenter,
                                                                        colors: [
                                                                          Color.fromRGBO(
                                                                              31,
                                                                              203,
                                                                              220,
                                                                              1),
                                                                          Color.fromRGBO(
                                                                              0,
                                                                              184,
                                                                              202,
                                                                              1)
                                                                        ]),
                                                                  ),
                                                                  child:
                                                                      TextButton(
                                                                       style: TextButton
                                                                        .styleFrom(
                                                                      foregroundColor:
                                                                          Colors
                                                                              .white,
                                                                       padding: const EdgeInsets.only(
                                                                          left:
                                                                              12,
                                                                          right:
                                                                              12,
                                                                          top:
                                                                              5.0,
                                                                          bottom:
                                                                              5.0),
                                                                       textStyle:
                                                                          const TextStyle(
                                                                              fontSize: 13),
                                                                      ),
                                                                        onPressed:
                                                                        () {
                                                                      String
                                                                          str_photourl =
                                                                          "${userinfoPin[index].photolink}";

                                                                      String
                                                                          str_Data =
                                                                          "${userinfoPin[index].delightName}, ${userinfoPin[index].rating}, ${userinfoPin[index].latitude}, "
                                                                          " ${userinfoPin[index].longitude},${getImage1(str_photourl)}";

                                                                      showModalBottomSheet<
                                                                          void>(
                                                                        context:
                                                                            context,
                                                                        backgroundColor:
                                                                            Colors.transparent,
                                                                        builder:
                                                                            (BuildContext
                                                                                context) {
                                                                          return GestureDetector(
                                                                            onTap: () =>
                                                                                Navigator.of(context).pop(),
                                                                            child:
                                                                                Align(
                                                                              alignment: Alignment.bottomCenter,
                                                                              child: Container(
                                                                                  height: MediaQuery.of(context).size.height / 10,
                                                                                  width: MediaQuery.of(context).size.width,
                                                                                  margin: EdgeInsets.only(top: 20, left: 10, right: 10),
                                                                                  decoration: BoxDecoration(
                                                                                    color: Color(0xFFffffff),
                                                                                    boxShadow: [
                                                                                      BoxShadow(
                                                                                        color: Colors.black12,
                                                                                        blurRadius: 5.0,
                                                                                        // soften the shadow
                                                                                        spreadRadius: 5.0,
                                                                                        //extend the shadow
                                                                                        offset: Offset(
                                                                                          1.0,
                                                                                          // Move to right 5  horizontally
                                                                                          1.0, // Move to bottom 5 Vertically
                                                                                        ),
                                                                                      )
                                                                                    ],
                                                                                    borderRadius: BorderRadius.circular(10),
                                                                                  ),
                                                                                  alignment: Alignment.center,
                                                                                  child: ListView(
                                                                                    scrollDirection: Axis.horizontal,
                                                                                    children: dataList.map((data) {
                                                                                      return InkWell(
                                                                                        onTap: () {
                                                                                          if (data.name == "Facebook") {
                                                                                            onButtonTap(Share.facebook, str_Data, str_photourl);
                                                                                          } else if (data.name == "Whatsapp") {
                                                                                            onButtonTap(Share.whatsapp, str_Data, str_photourl);
                                                                                          } else if (data.name == "Whatsapp Business") {
                                                                                            onButtonTap(Share.whatsapp_business, str_Data, str_photourl);
                                                                                          } else if (data.name == "Twitter") {
                                                                                            onButtonTap(Share.twitter, str_Data, str_photourl);
                                                                                          } else if (data.name == "More") {
                                                                                            onButtonTap(Share.share_system, str_Data, str_photourl);
                                                                                          }
                                                                                        },
                                                                                        child: Container(
                                                                                          margin: EdgeInsets.all(10),
                                                                                          decoration: BoxDecoration(border: Border(bottom: BorderSide(width: 1.5, color: Colors.white))),
                                                                                          child: Column(
                                                                                            children: [
                                                                                              Image.asset(
                                                                                                data.imageURL,
                                                                                                height: 40,
                                                                                                width: 40,
                                                                                              ),
                                                                                              Text(data.name),
                                                                                            ],
                                                                                          ),
                                                                                        ),
                                                                                      );
                                                                                    }).toList(),
                                                                                  )),
                                                                            ),
                                                                          );
                                                                        },
                                                                      );

                                                                      // showDialog(
                                                                      //   context: context,
                                                                      //   builder: (BuildContext context) {
                                                                      //     return Dialog(
                                                                      //         elevation: 0,
                                                                      //         backgroundColor: Colors.transparent,
                                                                      //         child:  Container(
                                                                      //             height: MediaQuery.of(context).size.height / 9,
                                                                      //             width: MediaQuery.of(context).size.width,
                                                                      //             decoration: BoxDecoration(
                                                                      //               color: Color(0xFFffffff),
                                                                      //               boxShadow: [
                                                                      //                 BoxShadow(
                                                                      //                   color: Colors.black12,
                                                                      //                   blurRadius: 5.0, // soften the shadow
                                                                      //                   spreadRadius: 5.0, //extend the shadow
                                                                      //                   offset: Offset(
                                                                      //                     1.0, // Move to right 5  horizontally
                                                                      //                     1.0, // Move to bottom 5 Vertically
                                                                      //                   ),
                                                                      //                 )
                                                                      //               ],
                                                                      //               borderRadius: BorderRadius.circular(10),
                                                                      //             ),
                                                                      //             child: ListView(
                                                                      //               scrollDirection: Axis.horizontal,
                                                                      //               children: dataList.map((data){
                                                                      //                 return InkWell(
                                                                      //                   onTap: (){
                                                                      //
                                                                      //                     if(data.name == "Facebook"){
                                                                      //
                                                                      //                       onButtonTap(Share.facebook);
                                                                      //
                                                                      //                     }else if(data.name == "Whatsapp"){
                                                                      //
                                                                      //                       onButtonTap(Share.whatsapp);
                                                                      //
                                                                      //                     }else if(data.name == "Whatsapp Business"){
                                                                      //
                                                                      //                       onButtonTap(Share.whatsapp_business);
                                                                      //
                                                                      //                     }else if(data.name == "Twitter"){
                                                                      //
                                                                      //                       onButtonTap(Share.twitter);
                                                                      //
                                                                      //                     }else if(data.name == "More"){
                                                                      //
                                                                      //                       onButtonTap(Share.share_system);
                                                                      //
                                                                      //                     }
                                                                      //
                                                                      //                   },
                                                                      //                   child: Container(
                                                                      //                     margin: EdgeInsets.all(10),
                                                                      //                     decoration: BoxDecoration(border: Border(bottom: BorderSide(width: 1.5,color: Colors.white))),
                                                                      //                     child: Column(
                                                                      //                       children: [
                                                                      //                         Image.asset(data.imageURL,height: 40,width: 40,),
                                                                      //                         Text(data.name),
                                                                      //                       ],
                                                                      //                     ),
                                                                      //                   ),
                                                                      //                 );
                                                                      //               }).toList(),
                                                                      //
                                                                      //             )
                                                                      //         )
                                                                      //     );
                                                                      //   },
                                                                      // );
                                                                    },
                                                                    child: Row(
                                                                      children: <Widget>[
                                                                        Image
                                                                            .asset(
                                                                          "assets/images/share-g.png",
                                                                          width:
                                                                              11,
                                                                          color:
                                                                              Colors.white,
                                                                        ),
                                                                        const SizedBox(
                                                                          width:
                                                                              5,
                                                                        ),
                                                                        const Text(
                                                                          "Share",
                                                                          style: TextStyle(
                                                                              fontSize: 13,
                                                                              color: Colors.white,
                                                                              fontWeight: FontWeight.normal),
                                                                        ),
                                                                        // text
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      )),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    }),
                              )
                            ],
                          );
                        } else {
                          return Center(child: CircularProgressIndicator());
                        }
                      },
                    )),
                    const SizedBox(
                      height: 30,
                    ),
                  ],
                ),

                // const SizedBox(
                //   height: 30,
                // ),
              ],
            ),
          ),
        ),
      );
    });
  }

  Widget _buildItemForChips(int index) {
    return GestureDetector(
      onTap: () {
        // checknow(searchKeywords[index]['name']!);
        setState(() {
          curIndex = index;
          String kename = elightlistName1[index].delightName!;

          // _determinePosition("food",_radius2);

          //   "Family & Kids",
          //   "Music",
          // "Adventure",

          //  _determinePosition(kename);

          // Fluttertoast.showToast(
          //     msg: kename,
          //     toastLength: Toast.LENGTH_SHORT,
          //     gravity: ToastGravity.BOTTOM,
          //     timeInSecForIosWeb: 1,
          //     backgroundColor: Colors.green,
          //     textColor: Colors.white,
          //     fontSize: 16.0);

          // KeyWord_formarker = KeyWord_formarker_chips;
        });
        //searchNow(searchKeywords[index]['name']!);
      },
      child: Container(
        margin: EdgeInsets.only(
          left: 8,
          top: 3,
          right: 0,
          bottom: 8,
        ),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Color(0xD000000), //New
              blurRadius: 12.0,
            )
          ],
          gradient: curIndex == index
              ? LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFF1FCBDC),
                    Color(0xFF00B8CA),
                  ],
                )
              : LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.white,
                    Colors.white,
                  ],
                ),
          borderRadius: BorderRadius.circular(50.0),
        ),
        child: Theme(
          data: ThemeData(canvasColor: Colors.transparent),
          child: Chip(
            // Change this
            shadowColor: Colors.transparent,
            backgroundColor: Colors.transparent,
            padding: EdgeInsets.all(Dimensions.size11),
            avatar: CircleAvatar(
                backgroundColor: Colors.transparent,
                radius: 10,
                // child: Image.asset('assets/images/drink-g.png'),
                child: Image.network(elightlistName1[index].imageUrl!)),
            label: Text(
              elightlistName1[index].delightName!,
              style: TextStyle(fontSize: Dimensions.size11),
            ),
          ),
        ),
      ),
    );
  }

  Image getImage(String photo_reference) {
    var baseurl = "https://maps.googleapis.com/maps/api/place/photo";
    var maxWidth = "110";
   // var maxHeight = "110";
    final url =
        "$baseurl?maxwidth=$maxWidth&photo_reference=$photo_reference&key=$googleApikey";
    return Image.network(
      url,
      fit: BoxFit.cover,
      filterQuality: FilterQuality.high,
    );
  }

  String getImage1(String photo_reference) {
    var baseurl = "https://maps.googleapis.com/maps/api/place/photo";
    var maxWidth = "110";
    var maxHeight = "110";
    final url =
        "$baseurl?maxwidth=$maxWidth&maxheight=$maxHeight&photo_reference=$photo_reference&key=$googleApikey";
    return url;
  }

  Future showDialog123456() {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
            elevation: 0,
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0)),
            child: Container(
                height: 80,
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.only(top: 20, left: 10, right: 10),
                decoration: BoxDecoration(
                  color: Color(0xFFffffff),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 5.0, // soften the shadow
                      spreadRadius: 5.0, //extend the shadow
                      offset: Offset(
                        1.0, // Move to right 5  horizontally
                        1.0, // Move to bottom 5 Vertically
                      ),
                    )
                  ],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: dataList.map((data) {
                    return InkWell(
                      onTap: () {
                        if (data.name == "Facebook") {
                          onButtonTap(Share.facebook, "", "");
                        } else if (data.name == "Whatsapp") {
                          onButtonTap(Share.whatsapp, "", "");
                        } else if (data.name == "Whatsapp Business") {
                          onButtonTap(Share.whatsapp_business, "", "");
                        } else if (data.name == "Twitter") {
                          onButtonTap(Share.twitter, "", "");
                        } else if (data.name == "More") {
                          onButtonTap(Share.share_system, "", "");
                        }
                      },
                      child: Container(
                        margin: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                                    width: 1.5, color: Colors.white))),
                        child: Column(
                          children: [
                            Image.asset(
                              data.imageURL,
                              height: 40,
                              width: 40,
                            ),
                            Text(data.name),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                )));
      },
    );
  }

  Future<void> onButtonTap(
      Share share, String str_data, String str_photourl) async {
    String msg = str_data;
    String url = getImage1(str_photourl);

    String? response;
    final FlutterShareMe flutterShareMe = FlutterShareMe();
    switch (share) {
      case Share.facebook:
        response = await flutterShareMe.shareToFacebook(url: url, msg: msg);
        break;
      // case Share.messenger:
      //   response = await flutterShareMe.shareToMessenger(url: url, msg: msg);
      //   break;
      case Share.twitter:
        response = await flutterShareMe.shareToTwitter(url: url, msg: msg);
        break;
      case Share.whatsapp:
        if (file != null) {
          response =
              await flutterShareMe.shareToWhatsApp(imagePath: url, msg: msg);
        } else {
          response = await flutterShareMe.shareToWhatsApp(msg: msg);
        }
        break;
      case Share.whatsapp_business:
        response = await flutterShareMe.shareToWhatsApp(msg: msg);
        break;
      case Share.share_system:
        response = await flutterShareMe.shareToSystem(
          msg: msg,
        );
        break;
      // case Share.whatsapp_personal:
      //   response = await flutterShareMe.shareWhatsAppPersonalMessage(
      //       message: msg, phoneNumber: 'phone-number-with-country-code');
      //   break;
      // case Share.share_instagram:
      //   response = await flutterShareMe.shareToInstagram(
      //       filePath: file!.path,
      //       fileType: videoEnable ? FileType.video : FileType.image);
      //   break;
      // case Share.share_telegram:
      //   response = await flutterShareMe.shareToTelegram(msg: msg);
      //   break;
    }
    debugPrint(response);
  }
}

class Data {
  String name;
  String imageURL;

  Data({required this.name, required this.imageURL});
}
