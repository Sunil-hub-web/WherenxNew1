import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../ApiCallingPage/ShowAllPin.dart';
import '../Dimension.dart';
import '../Routes/RouteHelper.dart';
import '../modelclass/ShowAllPinResponse.dart';
import 'package:http/http.dart' as http;

class SearchItemList extends StatefulWidget {
  const SearchItemList({super.key});

  @override
  State<SearchItemList> createState() => _SearchItemListState();
}

class _SearchItemListState extends State<SearchItemList> {

  TextEditingController editingController = TextEditingController();

  late bool islogin = false;
  int userId = 0, radius = 0;
  List<ShowAllPinResponse> showPinResponse = [];
  List<AllPinList> userinfoPin = [];
  String value = "0";
  var items = <AllPinList>[];

  String googleApikey = "AIzaSyAuFYxq-RX0I1boI5HU5-olArirEi2Ez8k";

  Future<List<AllPinList>> showAppPin() async {

    SharedPreferences pre = await SharedPreferences.getInstance();
    islogin = pre.getBool("islogin") ?? false;
    userId = pre.getInt("userId") ?? 0;

    String str_userId = userId.toString();

    print("userdetails ${str_userId}");

    http.Response responseData = await ShowAllPin().showPinDetails(str_userId);

    var jsonResponse = json.decode(responseData.body);
    var pinlistResponse = ShowAllPinResponse.fromJson(jsonResponse);

    if(userinfoPin.isEmpty){

      if (pinlistResponse.status == "success") {

        for (int i = 0; i < pinlistResponse.allPinList!.length; i++) {
          userinfoPin.add(pinlistResponse.allPinList![i]);
        }

        value = userinfoPin.length.toString();

        items = userinfoPin;

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

      Future.delayed(const Duration(seconds: 1)).then((value) => setState(() {}));
      print(showPinResponse.toString());
    }

    return userinfoPin;
  }

  void filterSearchResults(String query) {
    setState(() {
      items = userinfoPin.where((item) => item.delightName!.toLowerCase().contains(query.toLowerCase())).toList();
      print("useritemlist${items.toString()}");
    });
  }

  @override
  void initState() {
    showAppPin();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(builder: (BuildContext , Orientation , ScreenType ) {

      return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: IconButton(
            icon: Image.asset("assets/images/arrow.png", height: 20, width: 20,),
            onPressed: () => Get.toNamed(RouteHelper.getHomeScreenpage()),
          ),
          backgroundColor: Colors.white,
          title: Text("Search Pin",style: TextStyle(fontSize: 16.sp,color: Colors.black),textAlign: TextAlign.center,),
          elevation: 0.5,

        ),
        body: Container(
          height: 100.h,
          margin: EdgeInsets.only(top: 0.2.dp),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                width: 100.w,
                child:  Card(
                  shape: RoundedRectangleBorder(
                    borderRadius:
                    BorderRadius.circular(12.sp),
                  ),
                  child: TextField(
                    onChanged: (value) {
                      filterSearchResults(value);
                    },
                    controller: editingController,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.fromLTRB(1.h, 3.h, 3.h, 0),
                      labelText: "Search",
                      hintText: "Search",
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12.sp))),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xFFA1A8A9),
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(12.sp),
                        ),
                      ),),
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () async {
                        SharedPreferences pre = await SharedPreferences.getInstance();
                        pre.setString("placeId", items[index].placeId!);
                        Get.toNamed(RouteHelper.getdetailsScreen());
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
                        width: Dimensions.screenWidth,
                        height: 150,
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
                                  height:
                                  Dimensions.screenHeight,
                                  width: (Dimensions.size110),
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
                                          "${items[index].photolink}") /*Image.network(nearbyLocations[index].icon!,)*/,
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 2, // 60%
                                child: Container(
                                    margin:
                                    const EdgeInsets.only(
                                        left: 5,
                                        right: 5,
                                        top: 5),
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
                                                width: Dimensions
                                                    .screenWidth /
                                                    2.4,
                                                child: Text(
                                                  "${items[index].name}",
                                                  overflow:
                                                  TextOverflow
                                                      .ellipsis,
                                                  maxLines: 5,
                                                  style: TextStyle(
                                                      fontSize: 15
                                                          .sp,
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
                                                      SvgPicture.asset('assets/images/star.svg', width: 18, color:
                                                        const Color(0xFFF9BF3A),
                                                      ),
                                                      const SizedBox(
                                                        width:
                                                        2,
                                                      ),
                                                      Text(
                                                        "${items[index].rating}",
                                                        style: TextStyle(
                                                            fontSize: 11,
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
                                                "${items[index].delightName}",
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
                                                "Closes at 10pm",
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
                                                        const EdgeInsets.only(left: 12, right: 12)),
                                                  ),
                                                  onPressed:
                                                      () {},
                                                  child: Row(
                                                    children: <Widget>[
                                                      SvgPicture.asset('assets/images/direction-icon.svg',width: 18, color:
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
                                                        Color.fromRGBO(31, 203, 220, 1),
                                                        Color.fromRGBO(0, 184, 202, 1)
                                                      ]),
                                                ),
                                                child:
                                                TextButton(
                                                  style: TextButton
                                                      .styleFrom(
                                                    foregroundColor:
                                                    Colors
                                                        .white,
                                                    padding: const EdgeInsets.only(left: 12, right: 12, top: 5.0, bottom: 5.0),
                                                    textStyle:
                                                    const TextStyle(
                                                        fontSize: 13),
                                                  ),
                                                  onPressed: () {

                                                    // String str_photourl = "${items[index].photolink}";
                                                    //
                                                    // String str_Data =
                                                    //     "${items[index].delightName}, ${items[index].rating}, ${items[index].latitude}, "
                                                    //     " ${items[index].longitude},${getImage1(str_photourl)}";
                                                    //
                                                    // showModalBottomSheet<void>(context: context, backgroundColor:
                                                    //   Colors.transparent,
                                                    //   builder: (context) {
                                                    //     return GestureDetector(
                                                    //       onTap: () => Navigator.of(context).pop(), child:
                                                    //       Align(
                                                    //         alignment: Alignment.bottomCenter,
                                                    //         child: Container(
                                                    //             height: MediaQuery.of(context).size.height / 10,
                                                    //             width: MediaQuery.of(context).size.width,
                                                    //             margin: EdgeInsets.only(top: 20, left: 10, right: 10),
                                                    //             decoration: BoxDecoration(
                                                    //               color: Color(0xFFffffff),
                                                    //               boxShadow: [
                                                    //                 BoxShadow(
                                                    //                   color: Colors.black12,
                                                    //                   blurRadius: 5.0,
                                                    //                   // soften the shadow
                                                    //                   spreadRadius: 5.0,
                                                    //                   //extend the shadow
                                                    //                   offset: Offset(
                                                    //                     1.0,
                                                    //                     // Move to right 5  horizontally
                                                    //                     1.0, // Move to bottom 5 Vertically
                                                    //                   ),
                                                    //                 )
                                                    //               ],
                                                    //               borderRadius: BorderRadius.circular(10),
                                                    //             ),
                                                    //             alignment: Alignment.center,
                                                    //             child: ListView(
                                                    //               scrollDirection: Axis.horizontal,
                                                    //               children: dataList.map((data) {
                                                    //                 return InkWell(
                                                    //                   onTap: () {
                                                    //                     if (data.name == "Facebook") {
                                                    //                       onButtonTap(Share.facebook, str_Data, str_photourl);
                                                    //                     } else if (data.name == "Whatsapp") {
                                                    //                       onButtonTap(Share.whatsapp, str_Data, str_photourl);
                                                    //                     } else if (data.name == "Whatsapp Business") {
                                                    //                       onButtonTap(Share.whatsapp_business, str_Data, str_photourl);
                                                    //                     } else if (data.name == "Twitter") {
                                                    //                       onButtonTap(Share.twitter, str_Data, str_photourl);
                                                    //                     } else if (data.name == "More") {
                                                    //                       onButtonTap(Share.share_system, str_Data, str_photourl);
                                                    //                     }
                                                    //                   },
                                                    //                   child: Container(
                                                    //                     margin: EdgeInsets.all(10),
                                                    //                     decoration: BoxDecoration(border: Border(bottom: BorderSide(width: 1.5, color: Colors.white))),
                                                    //                     child: Column(
                                                    //                       children: [
                                                    //                         Image.asset(
                                                    //                           data.imageURL,
                                                    //                           height: 40,
                                                    //                           width: 40,
                                                    //                         ),
                                                    //                         Text(data.name),
                                                    //                       ],
                                                    //                     ),
                                                    //                   ),
                                                    //                 );
                                                    //               }).toList(),
                                                    //             )),
                                                    //       ),
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
                  },
                ),
              ),
            ],
          ),
        )
      );

    },);
  }

  Image getImage(String photo_reference) {
    var baseurl = "https://maps.googleapis.com/maps/api/place/photo";
    var maxWidth = "110";
    var maxHeight = "110";
    final url =
        "$baseurl?maxwidth=$maxWidth&maxheight=$maxHeight&photo_reference=$photo_reference&key=$googleApikey";
    return Image.network(
        url,
        filterQuality: FilterQuality.high,
        fit: BoxFit.fitWidth,
    );
  }
}
