import 'dart:convert';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../ApiCallingPage/PinThePlaceFile.dart';
import '../ApiImplement/ViewDialog.dart';
import '../Dimension.dart';
import '../Routes/RouteHelper.dart';
import '../model/NearByplaces.dart';
import 'package:http/http.dart' as http;

import '../modelclass/PinPlace_Response.dart';

class CustomAlertDialogShow extends StatefulWidget {
  List<Results> nearbyLocations;
  String delightId;

  CustomAlertDialogShow(
      {super.key, required this.nearbyLocations, required this.delightId});

  @override
  State<CustomAlertDialogShow> createState() => _CustomAlertDialogShowState();
}

class _CustomAlertDialogShowState extends State<CustomAlertDialogShow> {
  bool isVisible = false;
  String googleApikey = "AIzaSyAuFYxq-RX0I1boI5HU5-olArirEi2Ez8k";

  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(
      builder: (BuildContext, Orientation, ScreenType) {
        return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              leading: IconButton(
                icon: Image.asset(
                  "assets/images/arrow.png",
                  height: 20,
                  width: 20,
                ),
                onPressed: () =>  Navigator.pop(context)/*Get.toNamed(RouteHelper.getHomeScreenpage())*/,
              ),
              backgroundColor: Colors.white,
              title: Text(
                "You might be interested in",
                style: TextStyle(fontSize: 16.sp, color: Colors.black),
                textAlign: TextAlign.center,
              ),
              elevation: 0.5,
            ),
            body: Container(
              height: 100.h,
              margin: EdgeInsets.only(top: 0.2.dp),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    child: Container(
                        child: widget.nearbyLocations.isNotEmpty
                            ? Container(
                                height: 100.h,
                                width: Dimensions.size600,
                                margin: const EdgeInsets.all(5),
                                child: ListView.builder(
                                    shrinkWrap: true,
                                    scrollDirection: Axis.vertical,
                                    itemCount: widget.nearbyLocations.length,
                                    itemBuilder:
                                        (context, int index) => GestureDetector(
                                              onTap: () async {
                                                SharedPreferences pre =
                                                    await SharedPreferences
                                                        .getInstance();
                                                pre.setString(
                                                    "placeId",
                                                    widget
                                                        .nearbyLocations[index]
                                                        .placeId!);
                                                //save String
                                                Get.toNamed(RouteHelper
                                                    .getdetailsScreen());
                                              },
                                              child: SingleChildScrollView(
                                                child: Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                            .size
                                                            .width,
                                                    margin:
                                                        const EdgeInsets.all(5),
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      gradient: const LinearGradient(
                                                          begin: Alignment(
                                                              6.123234262925839e-17,
                                                              1),
                                                          end: Alignment(-1,
                                                              6.123234262925839e-17),
                                                          colors: [
                                                            Color.fromRGBO(255,
                                                                255, 255, 255),
                                                            Color.fromRGBO(255,
                                                                255, 255, 255),
                                                          ]),
                                                    ),
                                                    child: Container(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 5,
                                                              right: 5),
                                                      margin:
                                                          const EdgeInsets.only(
                                                        left: 0,
                                                        right: 0,
                                                        top: 0,
                                                        bottom: 10,
                                                      ),
                                                      width:
                                                          MediaQuery.of(context)
                                                              .size
                                                              .width,
                                                      height:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width /
                                                              2.5,
                                                      child: Card(
                                                        elevation: 5,
                                                        shadowColor:
                                                            Colors.black12,
                                                        color: Colors.white,
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(18),
                                                        ),
                                                        child: Row(
                                                          children: [
                                                            Expanded(
                                                                flex: 2, // 20%
                                                                child:
                                                                    Container(
                                                                  height: 130,
                                                                  decoration: BoxDecoration(
                                                                      color: Colors
                                                                          .white,
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              20)),
                                                                  width: 100,
                                                                  margin: const EdgeInsets
                                                                      .only(
                                                                      top: 10,
                                                                      left: 10,
                                                                      right: 10,
                                                                      bottom:
                                                                          10),
                                                                  child:
                                                                      ClipRRect(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            20),
                                                                    // Image border
                                                                    child: SizedBox
                                                                        .fromSize(
                                                                      size: const Size
                                                                          .fromRadius(
                                                                          48),
                                                                      // Image radius
                                                                      child: widget.nearbyLocations[index].photos?[0].photoReference ==
                                                                              null
                                                                          ? Image
                                                                              .network(
                                                                              widget.nearbyLocations[index].icon!,
                                                                              height: Dimensions.size100,
                                                                              width: Dimensions.size100,
                                                                            )
                                                                          : getImage(
                                                                              "${widget.nearbyLocations[index].photos?[0].photoReference}",
                                                                              "${widget.nearbyLocations[index].photos?[0].width}") /*Image.network(nearbyLocations[index].icon!,)*/,
                                                                    ),
                                                                  ),
                                                                )),
                                                            Expanded(
                                                                flex: 3, // 60%
                                                                child:
                                                                    SingleChildScrollView(
                                                                  scrollDirection:
                                                                      Axis.vertical,
                                                                  child:
                                                                      Container(
                                                                    margin: const EdgeInsets
                                                                        .only(
                                                                        left: 2,
                                                                        right:
                                                                            2,
                                                                        top:
                                                                            10),
                                                                    child:
                                                                        Column(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .start,
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .max,
                                                                      children: [
                                                                        Row(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.spaceBetween,
                                                                          children: [
                                                                            Expanded(
                                                                              child: Text(
                                                                                widget.nearbyLocations[index].name!,
                                                                                style: const TextStyle(fontSize: 14, color: Colors.black, fontWeight: FontWeight.normal),
                                                                              ),
                                                                            ),
                                                                            Container(
                                                                              height: 30,
                                                                              child: TextButton(
                                                                                style: ButtonStyle(
                                                                                  backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                                                                                ),
                                                                                onPressed: () {},
                                                                                child: Row(
                                                                                  children: <Widget>[
                                                                                    SvgPicture.asset(
                                                                                      'assets/images/star.svg',
                                                                                      width: 18,
                                                                                      color: const Color(0xFFF9BF3A),
                                                                                    ),
                                                                                    const SizedBox(
                                                                                      width: 2,
                                                                                    ),
                                                                                    widget.nearbyLocations[index].rating != null
                                                                                        ? Text(
                                                                                            widget.nearbyLocations[index].rating.toString(),
                                                                                            style: const TextStyle(fontSize: 11, color: Color(0xFF616768), fontWeight: FontWeight.normal),
                                                                                          )
                                                                                        : const Text(
                                                                                            "0",
                                                                                            style: TextStyle(fontSize: 11, color: Color(0xFF616768), fontWeight: FontWeight.normal),
                                                                                          ),
                                                                                    // text
                                                                                  ],
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                        const SizedBox(
                                                                          height:
                                                                              2,
                                                                        ),
                                                                        Row(
                                                                          children: [
                                                                            Text(
                                                                              widget.nearbyLocations[index].types![0],
                                                                              overflow: TextOverflow.ellipsis,
                                                                              style: TextStyle(fontSize: 12, color: Colors.grey[500], fontWeight: FontWeight.normal),
                                                                            ),
                                                                            Text(
                                                                              "",
                                                                              overflow: TextOverflow.ellipsis,
                                                                              style: TextStyle(fontSize: 11, color: Colors.grey[500], fontWeight: FontWeight.normal),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                        const SizedBox(
                                                                          height:
                                                                              2,
                                                                        ),
                                                                        Row(
                                                                          children: [
                                                                            Text(
                                                                              widget.nearbyLocations[index].businessStatus == "OPERATIONAL" ? "open" : "close",
                                                                              overflow: TextOverflow.ellipsis,
                                                                              style: TextStyle(fontSize: 12, color: Colors.grey[500], fontWeight: FontWeight.normal),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                        const SizedBox(
                                                                          height:
                                                                              10,
                                                                        ),
                                                                        Row(
                                                                          children: [
                                                                            Container(
                                                                              height: 35,
                                                                              child: TextButton(
                                                                                style: ButtonStyle(
                                                                                  backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                                                                                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
                                                                                    borderRadius: BorderRadius.circular(50.0),
                                                                                    side: const BorderSide(
                                                                                      color: Color(0xFFDDE4E4),
                                                                                    ),
                                                                                  )),
                                                                                  padding: MaterialStateProperty.all<EdgeInsets>(const EdgeInsets.only(
                                                                                    left: 12,
                                                                                    right: 12,
                                                                                  )),
                                                                                ),
                                                                                onPressed: () {},
                                                                                child: Row(
                                                                                  children: <Widget>[
                                                                                    SvgPicture.asset(
                                                                                      'assets/images/direction-icon.svg',
                                                                                      width: 18,
                                                                                      color: const Color(0xFF00B8CA),
                                                                                    ),
                                                                                    const SizedBox(
                                                                                      width: 5,
                                                                                    ),
                                                                                    const Text(
                                                                                      "Directions",
                                                                                      style: TextStyle(fontSize: 11, color: Color(0xFF00B8CA), fontWeight: FontWeight.normal),
                                                                                    ),
                                                                                    // text
                                                                                  ],
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            const SizedBox(width: 10),
                                                                            Container(
                                                                              height: 36,
                                                                              decoration: BoxDecoration(
                                                                                borderRadius: BorderRadius.circular(25),
                                                                                gradient: const LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [
                                                                                  Color.fromRGBO(31, 203, 220, 1),
                                                                                  Color.fromRGBO(0, 184, 202, 1)
                                                                                ]),
                                                                              ),
                                                                              child: TextButton(
                                                                                style: TextButton.styleFrom(
                                                                                  foregroundColor: Colors.white,
                                                                                  padding: const EdgeInsets.only(left: 12, right: 12, top: 5.0, bottom: 5.0),
                                                                                  textStyle: const TextStyle(fontSize: 13),
                                                                                ),
                                                                                onPressed: () async {
                                                                                  // pr4.show();

                                                                                  SharedPreferences pre = await SharedPreferences.getInstance();
                                                                                  final islogin = pre.getBool("islogin") ?? false;
                                                                                  final userId = pre.getInt("userId") ?? 0;
                                                                                  final struserId = userId.toString();
                                                                                  final strlat = widget.nearbyLocations[index].geometry?.location?.lat.toString();
                                                                                  final strlng = widget.nearbyLocations[index].geometry?.location?.lng.toString();
                                                                                  final placeid = widget.nearbyLocations[index].placeId!;

                                                                                  http.Response response = await PinPlaces().insertPinPlaces(struserId, widget.delightId, widget.nearbyLocations[index].types![0], placeid, strlat!, strlng!, widget.nearbyLocations[index].name!, "", widget.nearbyLocations[index].vicinity!, "", "", "", "", "", "", "", "", widget.nearbyLocations[index].photos![0].photoReference!, widget.nearbyLocations[index].rating.toString(), "");

                                                                                  print(response);

                                                                                  var pinResponse = jsonDecode(response.body);
                                                                                  var userResponse = PinThePlace.fromJson(pinResponse);

                                                                                  if (userResponse.status == "200") {
                                                                                    //   pr4.hide();

                                                                                    Fluttertoast.showToast(msg: userResponse.message!, toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.BOTTOM, timeInSecForIosWeb: 1, backgroundColor: Colors.green, textColor: Colors.white, fontSize: 16.0);
                                                                                  } else {
                                                                                    //   pr4.hide();

                                                                                    Fluttertoast.showToast(msg: userResponse.message!, toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.BOTTOM, timeInSecForIosWeb: 1, backgroundColor: Colors.green, textColor: Colors.white, fontSize: 16.0);
                                                                                  }
                                                                                },
                                                                                child: Row(
                                                                                  children: <Widget>[
                                                                                    SvgPicture.asset(
                                                                                      'assets/images/Pin-s.svg',
                                                                                      width: 11,
                                                                                      color: Colors.white,
                                                                                    ),
                                                                                    const SizedBox(
                                                                                      width: 5,
                                                                                    ),
                                                                                    const Text(
                                                                                      "Pinned",
                                                                                      style: TextStyle(fontSize: 13, color: Colors.white, fontWeight: FontWeight.normal),
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
                                                                  ),
                                                                )),
                                                          ],
                                                        ),
                                                      ),
                                                    )),
                                              ),
                                            )))
                            : Visibility(
                                visible: isVisible,
                                child: Align(
                                    alignment: Alignment.bottomCenter,
                                    child: ResponsiveSizer(builder:
                                        (context, orientation, screenType) {
                                      return Container(
                                        padding: const EdgeInsets.all(10),
                                        height: 25.h,
                                        width: 100.w,
                                        margin: EdgeInsets.all(0.5.dp),
                                        decoration: const BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10))),
                                        child: Text(
                                          "List Not Found",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: 23.sp,
                                              fontFamily: 'Poppins'),
                                        ),
                                      );
                                    })))),
                  ),
                ],
              ),
            ));
      },
    );
  }

  Image getImage(String photoReference, String maxwidth) {
    var baseurl = "https://maps.googleapis.com/maps/api/place/photo";
    // var maxwidth = "100";
    // var maxHeight = "100";
    final url =
        "$baseurl?maxwidth=$maxwidth&photo_reference=$photoReference&key=$googleApikey";
    return Image.network(
      url,
      filterQuality: FilterQuality.high,
      fit: BoxFit.cover,
    );
  }
}
