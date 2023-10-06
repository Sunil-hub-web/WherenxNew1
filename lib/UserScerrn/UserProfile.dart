import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:progress_dialog_null_safe/progress_dialog_null_safe.dart';
import 'package:wherenxnew1/ApiCallingPage/AddKMRadius.dart';
import 'package:wherenxnew1/ApiCallingPage/UpdateProfileImage.dart';
import 'package:wherenxnew1/ApiCallingPage/ViewDelight_List.dart';
import 'package:wherenxnew1/ApiCallingPage/ViewUserDeatils.dart';
import 'package:wherenxnew1/ApiCallingPage/ViewUserProfileImage.dart';
import 'package:wherenxnew1/ApiImplement/ViewDialog.dart';
import 'package:wherenxnew1/Dimension.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wherenxnew1/modelclass/ProfileImageResponse.dart';
import 'package:wherenxnew1/modelclass/ProfileImageSuccess.dart';
import 'package:wherenxnew1/modelclass/SuccessResponseKM.dart';
import 'package:wherenxnew1/modelclass/ViewUserResponse.dart';

import '../GoogleSigninPack/Authentication_signOut.dart';
import '../Routes/RouteHelper.dart';
import '../model/WherenxDeo.dart';
import '../model/WherenxEntity.dart';
import '../model/app_database.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';

import '../modelclass/ViewDelightList.dart';

import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:image_picker/image_picker.dart';

class UserProfile extends StatefulWidget {
  UserProfile({Key? key}) : super(key: key);

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  bool edit = false;
  String? km_mile = "Kilometers", dropdownCountry;
  String _name = "", city = "", state = "", countary = "", mobileNo = "", profileImage = "", dropValue = "";
  bool islogin = false, data = false;
  int userId = 0, radius = 0;
  bool _isSigningOut = false;

  List<ViewDelightList> viewdelightlist = [];

  List<String> elightlistName = [];

  Future<List<String>> showDelightList() async {
    elightlistName.clear();

    SharedPreferences pre = await SharedPreferences.getInstance();
    islogin = pre.getBool("islogin") ?? false;
    userId = pre.getInt("userId") ?? 0;

    String str_userId = userId.toString();

    http.Response response =
        await ViewDelight_List().getDelightList(str_userId);
    var jsonResponse = json.decode(response.body);
    var delightlistResponse = ViewDelightList.fromJson(jsonResponse);

    if (delightlistResponse.status == "success") {
      elightlistName.clear();

      if (delightlistResponse.userInfo!.isNotEmpty) {
        for (int i = 0; i < delightlistResponse.userInfo!.length; i++) {
          elightlistName.add(delightlistResponse.userInfo![i].delightName!);
        }
      } else {
        print("Delight List Not Found");

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

    return elightlistName;

    // Future.delayed(Duration(seconds: 1)).then((value) => setState(() {}));
  }

  Future<void> showData() async {
    SharedPreferences pre = await SharedPreferences.getInstance();
    islogin = pre.getBool("islogin") ?? false;
    userId = pre.getInt("userId") ?? 0;

    String str_usreId = userId.toString();

    print(userId);

    http.Response? response =
        await ViewUserDetails().getUserDetails(str_usreId);
    var jsonResponse = jsonDecode(response!.body);
    var userResponse = ViewUserResponse.fromJson(jsonResponse);

    if (userResponse.status == "success") {
      _name = userResponse.userInfo!.name!;
      state = userResponse.userInfo!.state!;
      countary = userResponse.userInfo!.country!;
      mobileNo = userResponse.userInfo!.email!;
      city = userResponse.userInfo!.city!;
      radius = userResponse.userInfo!.radius!;

      String srt_radius = radius.toString();

      if (srt_radius == "500") {
        dropValue = "0-5";
      } else if (srt_radius == "1000") {
        dropValue = "5-10";
      } else if (srt_radius == "1500") {
        dropValue = "10-15";
      } else if (srt_radius == "2000") {
        dropValue = "15-20";
      } else if (srt_radius == "2500") {
        dropValue = "20-25";
      } else if (srt_radius == "3000") {
        dropValue = "25-30";
      } else if (srt_radius == "3500") {
        dropValue = "30-35";
      } else if (srt_radius == "4000") {
        dropValue = "35-40";
      } else if (srt_radius == "4500") {
        dropValue = "40-45";
      } else if (srt_radius == "5000") {
        dropValue = "45-50";
      }

      // dropValue = dropdownCountry!;

      Fluttertoast.showToast(
          msg: userResponse.message!,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0);
    } else {
      Fluttertoast.showToast(
          msg: userResponse.message!,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0);
    }

    setState(() {});

    //return userResponse.status;
  }

  Future<String> showProfileImage() async {
    SharedPreferences pre = await SharedPreferences.getInstance();
    islogin = pre.getBool("islogin") ?? false;
    userId = pre.getInt("userId") ?? 0;

    String str_userId = userId.toString();

    print(userId);

    http.Response? response =
        await ViewUserProfileImage().getProfileImage(str_userId);
    var jsonResponse = jsonDecode(response.body);
    var userResponse1 = ProfileImageResponse.fromJson(jsonResponse);

    if (userResponse1.status == "success") {
      profileImage = userResponse1.image!;

      // Fluttertoast.showToast(
      //     msg: profileImage,
      //     toastLength: Toast.LENGTH_SHORT,
      //     gravity: ToastGravity.BOTTOM,
      //     timeInSecForIosWeb: 1,
      //     backgroundColor: Colors.green,
      //     textColor: Colors.white,
      //     fontSize: 16.0);

      print(profileImage);
    } else {
      profileImage = "";
    }

    setState(() {});

    return profileImage;
  }

  List<DropdownMenuItem<String>> get dropdownItems {
    List<DropdownMenuItem<String>> menuItems = [
      const DropdownMenuItem(value: "500", child: Text("0-5")),
      const DropdownMenuItem(value: "1000", child: Text("5-10")),
      const DropdownMenuItem(value: "1500", child: Text("10-15")),
      const DropdownMenuItem(value: "2000", child: Text("15-20")),
      const DropdownMenuItem(value: "2500", child: Text("20-25")),
      const DropdownMenuItem(value: "3000", child: Text("25-30")),
      const DropdownMenuItem(value: "3500", child: Text("30-35")),
      const DropdownMenuItem(value: "4000", child: Text("35-40")),
      const DropdownMenuItem(value: "4500", child: Text("40-45")),
      const DropdownMenuItem(value: "5000", child: Text("45-50")),
    ];
    return menuItems;
  }

  bool isVisiable = false;

  Future<void> showdatavalue() async {

    SharedPreferences pre = await SharedPreferences.getInstance();
    data = pre.getBool("data") ?? false;

    if(data){
      isVisiable = true;
      SharedPreferences pre = await SharedPreferences.getInstance();
      pre.setBool("data", false);
    }

  }

  @override
  void initState() {
    super.initState();
    showData();
    //  showDelightList();
    showProfileImage();
    showdatavalue();
  }

  @override
  Widget build(BuildContext context) {
    ImagePicker picker = ImagePicker();
    XFile? image;

    ProgressDialog pr9 = ProgressDialog(context);
    pr9 = ProgressDialog(context, type: ProgressDialogType.normal);
    pr9.style(
        message: 'Upload Image Wait.....',
        borderRadius: 10.0,
        backgroundColor: Colors.white,
        progressWidget: const CircularProgressIndicator(),
        elevation: 10.0,
        insetAnimCurve: Curves.easeInOut,
        progress: 0.0,
        progressTextStyle: TextStyle(
            color: Colors.black, fontSize: 13.0, fontWeight: FontWeight.w400),
        messageTextStyle: TextStyle(
            color: Colors.black, fontSize: 13.0, fontWeight: FontWeight.w600));

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));

    return Scaffold(
        backgroundColor: Colors.cyan,
        appBar: AppBar(
          leading: Visibility(
            visible: isVisiable ,child: IconButton(
            icon: Image.asset("assets/images/arrow.png", height: 20, width: 20,),
            onPressed: () => Get.toNamed(RouteHelper.getHomeScreenpage()),
          ),),
          backgroundColor: Colors.white,
          title: Text("User Profile",style: TextStyle(fontSize: 16.sp,color: Colors.black),textAlign: TextAlign.center,),
          elevation: 0.5,

        ),
        body: ResponsiveSizer(builder: (context, orientation, screenType) {
          return SingleChildScrollView(
            child: SizedBox(
              height: Dimensions.screenHeight,
              width: Dimensions.screenWidth,
              child:   Column(
                children: [
                  // Expanded(
                  //   flex: 2,
                  //   child: Container(
                  //     color: Colors.transparent,
                  //   ),
                  // ),

                  Expanded(
                    flex: 9,
                    child: Container(
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(0),
                          ),
                          color: Color(0xFFF8F8F8),
                          boxShadow: [
                            BoxShadow(
                              color: Color.fromRGBO(0, 0, 0, 0.1),
                              blurRadius: 15.0,
                              spreadRadius: 5,
                              offset: Offset(
                                0,
                                -5,
                              ),
                            )
                          ],
                        ),
                        child: FutureBuilder(
                          future: showDelightList(),
                          builder:
                              (BuildContext context, AsyncSnapshot snapshot) {
                            if (snapshot.hasData) {
                              return Column(
                                children: [
                                  // GestureDetector(
                                  //   onTap: () => Get.toNamed(
                                  //       RouteHelper
                                  //           .getHomeScreenpage()),
                                  //   child: Container(
                                  //     padding: EdgeInsets.only(left: 10),
                                  //     margin:EdgeInsets.only(top: 50),
                                  //     child: Align(
                                  //       alignment:
                                  //       Alignment.topLeft,
                                  //       child: Image.asset(
                                  //         "assets/images/arrow.png",
                                  //         height: 20,
                                  //         width: 20,
                                  //       ),
                                  //     ),
                                  //   ),
                                  // ),
                                  InkWell(
                                    onTap: () async {
                                      // image = await picker.pickImage(source: ImageSource.gallery);
                                      // File imageFile = File(image!.path);
                                      // print(imageFile);
                                      //
                                      // pr9.show();
                                      //
                                      // SharedPreferences pre = await SharedPreferences.getInstance();
                                      // islogin = pre.getBool("islogin") ?? false;
                                      // userId = pre.getInt("userId") ?? 0;
                                      //
                                      // String str_userId = userId.toString();
                                      //
                                      // http.StreamedResponse? response = await UpdateProfileImage().updateImageProfile(str_userId, image!.path);
                                      //
                                      // print(await response!.stream.bytesToString());
                                      //
                                      // if(response.statusCode == 200){
                                      //
                                      //   pr9.hide();
                                      //   showProfileImage();
                                      //
                                      //   Fluttertoast.showToast(
                                      //
                                      //       msg: "Upload Success",
                                      //       toastLength: Toast.LENGTH_SHORT,
                                      //       gravity: ToastGravity.BOTTOM,
                                      //       timeInSecForIosWeb: 1,
                                      //       backgroundColor: Colors.green,
                                      //       textColor: Colors.white,
                                      //       fontSize: 16.0);
                                      //
                                      //
                                      // }else{
                                      //
                                      //   pr9.hide();
                                      //
                                      //   Fluttertoast.showToast(
                                      //       msg: "Image Not Upload",
                                      //       toastLength: Toast.LENGTH_SHORT,
                                      //       gravity: ToastGravity.BOTTOM,
                                      //       timeInSecForIosWeb: 1,
                                      //       backgroundColor: Colors.green,
                                      //       textColor: Colors.white,
                                      //       fontSize: 16.0);
                                      //
                                      // }
                                      //
                                      // setState(() {});
                                    },
                                    child: Container(
                                        padding: EdgeInsets.only(
                                            top: 1.h, right: 3.h),
                                        child: Column(
                                          children: [

                                            Center(
                                              child: Stack(
                                                children: [
                                                  Column(
                                                    children: [
                                                      Container(
                                                        width: 190,
                                                        height: 190,
                                                        decoration:
                                                        BoxDecoration(
                                                          border: Border.all(
                                                              width: 4,
                                                              color: Colors
                                                                  .white),
                                                          boxShadow: [
                                                            BoxShadow(
                                                                spreadRadius:
                                                                2,
                                                                blurStyle:
                                                                BlurStyle
                                                                    .solid,
                                                                blurRadius:
                                                                10,
                                                                color: Colors
                                                                    .black
                                                                    .withOpacity(
                                                                    0.1))
                                                          ],
                                                          shape:
                                                          BoxShape.circle,
                                                          image: profileImage ==
                                                              ""
                                                              ? const DecorationImage(
                                                            image: AssetImage(
                                                                'assets/images/profileimage.jpg'), //Your Background image
                                                          )
                                                              : DecorationImage(
                                                            image: NetworkImage(
                                                                profileImage),
                                                            fit: BoxFit
                                                                .cover,

                                                            //Your Background image
                                                          ),
                                                        ),
                                                        // child: profileImage == "" ? Image.file(imageFile) : Image.network(profileImage, height: Dimensions.size100, width: Dimensions.size100,),
                                                      ),
                                                    ],
                                                  )

                                                  //   Positioned(
                                                  //       bottom: 0,
                                                  //       right: 0,
                                                  //       child: Container(
                                                  //           height: 45,
                                                  //           width: 45,
                                                  //           decoration: BoxDecoration(
                                                  //               shape: BoxShape.circle,
                                                  //               border: Border.all(width: 4, color: Colors.white),
                                                  //               color: Colors.blue),
                                                  //           child:Image(image: AssetImage('assets/images/camera.png'),
                                                  //             fit: BoxFit.cover,height: 30,width: 30,)/* Icon(
                                                  //   Icons.edit,
                                                  //   color: Colors.white,
                                                  // ),*/
                                                  //       )
                                                  //   )
                                                ],
                                              ),
                                            ),
                                          ],
                                        ) /* Card(
                              elevation: 5,
                              shadowColor: Color.fromRGBO(0, 0, 0, 0.4),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                      bottomRight: Radius.circular(100),
                                      bottomLeft: Radius.circular(100),
                                      topLeft: Radius.circular(100),
                                      topRight: Radius.circular(100)),
                                  side: BorderSide(width: 5, color: Colors.white)),
                              child: Stack(children: [
                                Container(
                                    width: 50.w,
                                    height: 25.h,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: AssetImage(
                                            'assets/images/profileimage.jpg'),
                                        fit: BoxFit.cover,
                                      ),
                                      borderRadius: BorderRadius.circular(90.dp),
                                    )),
                              ])),*/
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      margin: EdgeInsets.only(
                                          top: 0.1.dp, left: 10, right: 10),
                                      width: 100.w,
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              Expanded(
                                                flex: 1,
                                                child: Container(
                                                  color: Colors.transparent,
                                                ),
                                              ),
                                              Expanded(
                                                flex: 9,
                                                child: Container(
                                                  child: Align(
                                                    alignment:
                                                    Alignment.center,
                                                    child: Text(
                                                      _name,
                                                      style: TextStyle(
                                                          fontSize: 18.sp,
                                                          color:
                                                          Colors.black),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                flex: 1,
                                                child: Container(
                                                  child: IconButton(
                                                    onPressed: () {
                                                      Get.toNamed(RouteHelper
                                                          .getprofileEditpage());
                                                    },
                                                    alignment:
                                                    Alignment.centerRight,
                                                    icon: SvgPicture.asset(
                                                      'assets/images/edit-icon.svg',
                                                      width: 8.w,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Container(
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
                                                      5.0,
                                                      // Move to right 5  horizontally
                                                      5.0, // Move to bottom 5 Vertically
                                                    ),
                                                  )
                                                ],
                                                borderRadius:
                                                BorderRadius.circular(10),
                                              ),
                                              child: Expanded(
                                                child: Padding(
                                                  padding: const EdgeInsets
                                                      .fromLTRB(
                                                      10, 10, 10, 10),
                                                  child: Container(
                                                    width: Dimensions
                                                        .screenWidth,
                                                    height:
                                                    Dimensions.size100,
                                                    color: Colors.white,
                                                    child: Column(
                                                      mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                      children: [
                                                        Row(
                                                          mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                          crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                          children: [
                                                            Text(
                                                              "Email            ",
                                                              style: TextStyle(
                                                                  fontSize:
                                                                  15.sp,
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                                  color: Colors
                                                                      .grey),
                                                            ),
                                                            SizedBox(
                                                              width: 3.w,
                                                            ),
                                                            Text(
                                                              ":",
                                                              style: TextStyle(
                                                                  fontSize:
                                                                  15.sp,
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                                  color: Colors
                                                                      .grey),
                                                            ),
                                                            SizedBox(
                                                              width: 3.w,
                                                            ),
                                                            Text(
                                                              mobileNo,
                                                              style: TextStyle(
                                                                  fontSize:
                                                                  15.sp,
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                                  color: Colors
                                                                      .grey[
                                                                  800]),
                                                            ),
                                                          ],
                                                        ),
                                                        Row(
                                                          mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                          //crossAxisAlignment: CrossAxisAlignment.center,
                                                          children: [
                                                            Text(
                                                              "Country      ",
                                                              style: TextStyle(
                                                                  fontSize:
                                                                  15.sp,
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                                  color: Colors
                                                                      .grey),
                                                              overflow:
                                                              TextOverflow
                                                                  .ellipsis,
                                                            ),
                                                            SizedBox(
                                                              width: 3.w,
                                                            ),
                                                            Text(
                                                              ":",
                                                              style: TextStyle(
                                                                  fontSize:
                                                                  15.sp,
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                                  color: Colors
                                                                      .grey),
                                                            ),
                                                            SizedBox(
                                                              width: 3.w,
                                                            ),
                                                            Text(
                                                              countary,
                                                              overflow:
                                                              TextOverflow
                                                                  .ellipsis,
                                                              maxLines: 1,
                                                              style: TextStyle(
                                                                  fontSize:
                                                                  15.sp,
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                                  color: Colors
                                                                      .grey[
                                                                  800]),
                                                            ),
                                                          ],
                                                        ),
                                                        Row(
                                                          mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                          crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                          children: [
                                                            Text(
                                                              "State            ",
                                                              style: TextStyle(
                                                                  fontSize:
                                                                  15.sp,
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                                  color: Colors
                                                                      .grey),
                                                              overflow:
                                                              TextOverflow
                                                                  .ellipsis,
                                                            ),
                                                            SizedBox(
                                                              width: 3.w,
                                                            ),
                                                            Text(
                                                              ":",
                                                              style: TextStyle(
                                                                  fontSize:
                                                                  15.sp,
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                                  color: Colors
                                                                      .grey),
                                                            ),
                                                            SizedBox(
                                                              width: 3.w,
                                                            ),
                                                            Text(
                                                              state,
                                                              style: TextStyle(
                                                                  fontSize:
                                                                  15.sp,
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                                  color: Colors
                                                                      .grey[
                                                                  800]),
                                                              overflow:
                                                              TextOverflow
                                                                  .ellipsis,
                                                            ),
                                                          ],
                                                        ),
                                                        Row(
                                                          mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                          //crossAxisAlignment: CrossAxisAlignment.center,
                                                          children: [
                                                            Text(
                                                              "City              ",
                                                              style: TextStyle(
                                                                  fontSize:
                                                                  15.sp,
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                                  color: Colors
                                                                      .grey),
                                                              overflow:
                                                              TextOverflow
                                                                  .ellipsis,
                                                            ),
                                                            SizedBox(
                                                              width: 3.w,
                                                            ),
                                                            Text(
                                                              ":",
                                                              style: TextStyle(
                                                                  fontSize:
                                                                  15.sp,
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                                  color: Colors
                                                                      .grey),
                                                            ),
                                                            SizedBox(
                                                              width: 3.w,
                                                            ),
                                                            Text(
                                                              city,
                                                              overflow:
                                                              TextOverflow
                                                                  .ellipsis,
                                                              maxLines: 1,
                                                              style: TextStyle(
                                                                  fontSize:
                                                                  15.sp,
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                                  color: Colors
                                                                      .grey[
                                                                  800]),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              )),
                                          SizedBox(
                                            height: 3.w,
                                          ),
                                          Container(
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
                                                    5.0,
                                                    // Move to right 5  horizontally
                                                    5.0, // Move to bottom 5 Vertically
                                                  ),
                                                )
                                              ],
                                              borderRadius:
                                              BorderRadius.circular(10),
                                            ),
                                            child: Padding(
                                              padding: EdgeInsets.fromLTRB(
                                                  20, 10, 10, 12),
                                              child: Container(
                                                width: 100.w,
                                                color: Colors.white,
                                                child: Column(
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment
                                                      .start,
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                      margin:
                                                      EdgeInsets.fromLTRB(
                                                          0, 0, 0, 0),
                                                      height: 5.h,
                                                      child: Row(
                                                        mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                        crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                        children: [
                                                          Expanded(
                                                            flex: 8,
                                                            child: Align(
                                                              alignment: Alignment
                                                                  .centerLeft,
                                                              child: Text(
                                                                "My delights",
                                                                style: TextStyle(
                                                                    fontSize:
                                                                    17.sp,
                                                                    color: Colors
                                                                        .black),
                                                              ),
                                                            ),
                                                          ),
                                                          Expanded(
                                                            flex: 1,
                                                            child: Container(
                                                              child:
                                                              IconButton(
                                                                onPressed:
                                                                    () {
                                                                  Get.toNamed(
                                                                      RouteHelper
                                                                          .getDelightSelectScreen());
                                                                },
                                                                alignment:
                                                                Alignment
                                                                    .centerRight,
                                                                icon:
                                                                SvgPicture
                                                                    .asset(
                                                                  'assets/images/edit-icon.svg',
                                                                  width: 18.w,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),

                                                    Container(
                                                        margin: EdgeInsets
                                                            .fromLTRB(
                                                            0.1.dp,
                                                            0.1.dp,
                                                            0.1.dp,
                                                            0.2.dp),
                                                        child: Wrap(
                                                          spacing: 0.2.dp,
                                                          children: elightlistName
                                                              .map((chip) => Container(
                                                              height: 4.h,
                                                              margin: EdgeInsets.fromLTRB(0.1.dp, 0.1.dp, 0.1.dp, 0.2.dp),
                                                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), color: Colors.black26),
                                                              child: Padding(
                                                                padding:
                                                                EdgeInsets.all(
                                                                    8.5),
                                                                child: Text(
                                                                    chip,
                                                                    textAlign: TextAlign
                                                                        .center,
                                                                    style: TextStyle(
                                                                        color: Colors.white,
                                                                        fontWeight: FontWeight.bold,
                                                                        fontSize: 14.sp)),
                                                              )))
                                                              .toList(),
                                                        )
                                                      // child: Row(
                                                      //   mainAxisAlignment: MainAxisAlignment.start,
                                                      //   children: [
                                                      //
                                                      //
                                                      //
                                                      //     Chip(
                                                      //       elevation: 0,
                                                      //       backgroundColor:  Color(0xFFF8F8F8),
                                                      //       padding:  EdgeInsets.fromLTRB(6,10,6,10),
                                                      //       label: Text(
                                                      //         "Restaurants",
                                                      //         style: TextStyle(
                                                      //             color: Colors.grey[600],
                                                      //             fontSize: 11),
                                                      //       ),
                                                      //     ),
                                                      //      SizedBox(width: 6),
                                                      //     Chip(
                                                      //       elevation: 0,
                                                      //       backgroundColor:  Color(0xFFF8F8F8),
                                                      //       padding:  EdgeInsets.fromLTRB(6,10,6,10),
                                                      //       label: Text(
                                                      //         "Bar & Night clubs",
                                                      //         style: TextStyle(
                                                      //             color: Colors.grey[600],
                                                      //             fontSize: 11),
                                                      //       ),
                                                      //     ),
                                                      //      SizedBox(width: 6),
                                                      //     Chip(
                                                      //       elevation: 0,
                                                      //       backgroundColor:  Color(0xFFF8F8F8),
                                                      //       padding:  EdgeInsets.fromLTRB(6,10,6,10),
                                                      //       label: Text(
                                                      //         "Shopping",
                                                      //         style: TextStyle(
                                                      //             color: Colors.grey[600],
                                                      //             fontSize: 11),
                                                      //       ),
                                                      //     ),
                                                      //   ],
                                                      // ),
                                                    ),
                                                    // Container(
                                                    //   margin:  EdgeInsets.fromLTRB(0,0,0,4),
                                                    //   height: 40,
                                                    //   child: Row(
                                                    //     mainAxisAlignment: MainAxisAlignment.start,
                                                    //     children: [
                                                    //       Chip(
                                                    //         elevation: 0,
                                                    //         backgroundColor:  Color(0xFFF8F8F8),
                                                    //         padding:  EdgeInsets.fromLTRB(6,10,6,10),
                                                    //         label: Text(
                                                    //           "Museums",
                                                    //           style: TextStyle(
                                                    //               color: Colors.grey[600],
                                                    //               fontSize: 11),
                                                    //         ),
                                                    //       ),
                                                    //        SizedBox(width: 6),
                                                    //       Chip(
                                                    //         elevation: 0,
                                                    //         backgroundColor:  Color(0xFFF8F8F8),
                                                    //         padding:  EdgeInsets.fromLTRB(6,10,6,10),
                                                    //         label: Text(
                                                    //           "Health & Fitness",
                                                    //           style: TextStyle(
                                                    //               color: Colors.grey[600],
                                                    //               fontSize: 11),
                                                    //         ),
                                                    //       ),
                                                    //     ],
                                                    //   ),
                                                    // ),
                                                    Container(
                                                      margin:
                                                      EdgeInsets.fromLTRB(
                                                          0, 10, 0, 10),
                                                      child: SizedBox(
                                                        width: Dimensions
                                                            .screenWidth,
                                                        height: 1,
                                                        child: ColoredBox(
                                                            color: Color(
                                                                0xFFDDE4E4)),
                                                      ),
                                                    ),
                                                    Row(
                                                      children: [
                                                        Text(
                                                          "Search Radius (Miles)",
                                                          style: TextStyle(
                                                              fontSize: 14,
                                                              color: Colors
                                                                  .black),
                                                        ),
                                                      ],
                                                    ),
                                                    Container(
                                                      margin:
                                                      EdgeInsets.fromLTRB(
                                                          0, 10, 0, 0),
                                                      width: Dimensions
                                                          .screenWidth,
                                                      child: Row(
                                                        children: [
                                                          Container(
                                                            width: Dimensions
                                                                .screenWidth /
                                                                1.2,
                                                            child:
                                                            DropdownButtonFormField(
                                                              hint:
                                                              dropValue ==
                                                                  ""
                                                                  ? Text(
                                                                "Choose an Radius",
                                                                style:
                                                                TextStyle(fontSize: 15.sp),
                                                              )
                                                                  : Text(
                                                                dropValue,
                                                                style:
                                                                TextStyle(fontSize: 15.sp),
                                                              ),
                                                              decoration:
                                                              InputDecoration(
                                                                //  labelText: 'Choose an Country',
                                                                isDense: true,
                                                                // important line
                                                                contentPadding:
                                                                EdgeInsets.fromLTRB(
                                                                    1.h,
                                                                    2.h,
                                                                    1.h,
                                                                    0),
                                                                enabledBorder:
                                                                OutlineInputBorder(
                                                                  borderSide: BorderSide(
                                                                      color: Color(
                                                                          0xFFDDE4E4),
                                                                      width:
                                                                      1.0),
                                                                  borderRadius:
                                                                  BorderRadius
                                                                      .all(
                                                                    Radius.circular(
                                                                        12),
                                                                  ),
                                                                ),
                                                                focusedBorder:
                                                                OutlineInputBorder(
                                                                  borderSide:
                                                                  BorderSide(
                                                                    color: Color(
                                                                        0xFFDDE4E4),
                                                                  ),
                                                                  borderRadius:
                                                                  BorderRadius
                                                                      .all(
                                                                    Radius.circular(
                                                                        12),
                                                                  ),
                                                                ),
                                                                border:
                                                                OutlineInputBorder(
                                                                  borderRadius:
                                                                  BorderRadius
                                                                      .all(
                                                                    Radius.circular(
                                                                        12),
                                                                  ),
                                                                ),
                                                                filled: true,
                                                                fillColor:
                                                                Colors
                                                                    .white,
                                                              ),
                                                              // validator: (value) => value == null
                                                              //     ? "Select a country"
                                                              //     : null,
                                                              dropdownColor:
                                                              Colors
                                                                  .white,
                                                              value:
                                                              dropdownCountry,
                                                              isExpanded:
                                                              true,
                                                              itemHeight:
                                                              null,
                                                              items:
                                                              dropdownItems,
                                                              onChanged:
                                                                  (newValue) async {
                                                                dropdownCountry =
                                                                ((newValue ??
                                                                    "")
                                                                as String?)!;

                                                                String
                                                                str_userId =
                                                                userId
                                                                    .toString();

                                                                http.Response
                                                                response =
                                                                await AddKMRadius().addkmRadius(
                                                                    str_userId,
                                                                    dropdownCountry!);
                                                                var jsonResponse =
                                                                jsonDecode(
                                                                    response
                                                                        .body);
                                                                var userResponse =
                                                                SuccessResponseKM
                                                                    .fromJson(
                                                                    jsonResponse);

                                                                if (userResponse
                                                                    .status ==
                                                                    "success") {
                                                                  Fluttertoast.showToast(
                                                                      msg: userResponse
                                                                          .message!,
                                                                      toastLength:
                                                                      Toast
                                                                          .LENGTH_SHORT,
                                                                      gravity:
                                                                      ToastGravity
                                                                          .BOTTOM,
                                                                      timeInSecForIosWeb:
                                                                      1,
                                                                      backgroundColor:
                                                                      Colors
                                                                          .green,
                                                                      textColor:
                                                                      Colors
                                                                          .white,
                                                                      fontSize:
                                                                      16.0);
                                                                } else {
                                                                  Fluttertoast.showToast(
                                                                      msg: userResponse
                                                                          .message!,
                                                                      toastLength:
                                                                      Toast
                                                                          .LENGTH_SHORT,
                                                                      gravity:
                                                                      ToastGravity
                                                                          .BOTTOM,
                                                                      timeInSecForIosWeb:
                                                                      1,
                                                                      backgroundColor:
                                                                      Colors
                                                                          .green,
                                                                      textColor:
                                                                      Colors
                                                                          .white,
                                                                      fontSize:
                                                                      16.0);
                                                                }

                                                                //setState(() {});
                                                              },
                                                            ),
                                                          )

                                                          // Row(
                                                          //   children: [
                                                          //     Container(
                                                          //       margin: EdgeInsets.fromLTRB(
                                                          //           0, 0, 5, 0),
                                                          //       width: 25,
                                                          //       child: Transform.scale(
                                                          //         scale: 1.2,
                                                          //         child: Radio(
                                                          //           fillColor:
                                                          //           MaterialStateColor
                                                          //               .resolveWith(
                                                          //                   (states) =>
                                                          //               Colors
                                                          //                   .cyan),
                                                          //           value: "Kilometers",
                                                          //           groupValue: km_mile,
                                                          //           onChanged: (value) {
                                                          //             setState(() {
                                                          //               km_mile =
                                                          //                   value.toString();
                                                          //             });
                                                          //           },
                                                          //         ),
                                                          //       ),
                                                          //     ),
                                                          //     Text(
                                                          //       "Kilometers",
                                                          //       style: TextStyle(
                                                          //           color: Colors.grey[600],
                                                          //           fontSize: 12),
                                                          //       overflow:
                                                          //       TextOverflow.ellipsis,
                                                          //     )
                                                          //   ],
                                                          // ),
                                                          // Row(
                                                          //   children: [
                                                          //     Transform.scale(
                                                          //       scale: 1.2,
                                                          //       child: Radio(
                                                          //         fillColor:
                                                          //         MaterialStateColor
                                                          //             .resolveWith(
                                                          //                 (states) =>
                                                          //             Colors
                                                          //                 .cyan),
                                                          //         value: "Miles",
                                                          //         groupValue: km_mile,
                                                          //         onChanged: (value) {
                                                          //           setState(() {
                                                          //             km_mile =
                                                          //                 value.toString();
                                                          //           });
                                                          //         },
                                                          //       ),
                                                          //     ),
                                                          //     Text(
                                                          //       "Miles",
                                                          //       style: TextStyle(
                                                          //           color: Colors.grey[600],
                                                          //           fontSize: 12),
                                                          //       overflow:
                                                          //       TextOverflow.ellipsis,
                                                          //     ),
                                                          //   ],
                                                          // ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              Get.defaultDialog(
                                                content: getContent(),
                                                barrierDismissible: false,
                                                confirm: confirmBtn(),
                                                cancel: cancelBtn(),
                                              );
                                            },
                                            child: Container(
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
                                                      5.0,
                                                      // Move to right 5  horizontally
                                                      5.0, // Move to bottom 5 Vertically
                                                    ),
                                                  )
                                                ],
                                                borderRadius:
                                                BorderRadius.circular(10),
                                              ),
                                              child: Container(
                                                padding: EdgeInsets.fromLTRB(
                                                    15, 5, 10, 5),
                                                width:
                                                Dimensions.screenHeight,
                                                height: Dimensions.size46,
                                                child: Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment
                                                      .center,
                                                  children: [
                                                    Container(
                                                      width:
                                                      Dimensions.size30,
                                                      height:
                                                      Dimensions.size30,
                                                      child: Center(
                                                          child: Icon(
                                                            Icons.logout,
                                                            size: 22,
                                                            color: Colors.red,
                                                          )),
                                                    ),
                                                    SizedBox(
                                                      width: 5,
                                                    ),
                                                    Text(
                                                      "Logout",
                                                      style: TextStyle(
                                                          fontSize: 14,
                                                          color: Colors.red),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              );
                            } else {
                              return Center(
                                  child: CircularProgressIndicator());
                            }
                          },
                        )),
                  ),
                ],
              ),

              // Stack(children: [
              //
              //   // Stack(
              //   //   children: [
              //   //     Padding(
              //   //       padding: EdgeInsets.only(
              //   //           left: 30.w,
              //   //           top: 5.h),
              //   //       child: Card(
              //   //           elevation: 5,
              //   //           shadowColor: Color.fromRGBO(0, 0, 0, 0.4),
              //   //           shape: RoundedRectangleBorder(
              //   //               borderRadius: BorderRadius.only(
              //   //                   bottomRight: Radius.circular(100),
              //   //                   bottomLeft: Radius.circular(100),
              //   //                   topLeft: Radius.circular(100),
              //   //                   topRight: Radius.circular(100)),
              //   //               side: BorderSide(width: 5, color: Colors.white)),
              //   //           child: Stack(children: [
              //   //             Container(
              //   //                 width: 50.w,
              //   //                 height: 25.h,
              //   //                 decoration: BoxDecoration(
              //   //                   image: DecorationImage(
              //   //                     image: AssetImage(
              //   //                         'assets/images/food-image.png'),
              //   //                     fit: BoxFit.cover,
              //   //                   ),
              //   //                   borderRadius: BorderRadius.circular(90),
              //   //                 ))
              //   //           ])),
              //   //     ),
              //   //   ],
              //   // ),
              // ]),
            ),
          );
        }));

  }

  Widget getContent() {
    return Column(
      children: [
        Text("Are you sure! You want to Logout"),
      ],
    );
  }

  Widget confirmBtn() {
    return Container(
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(12))),
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFF1FCBDC), Color(0xFF00B8CA)],
        ),
      ),
      height: 46,
      child: ElevatedButton(
        onPressed: () async {
          SharedPreferences pre = await SharedPreferences.getInstance();
          await pre.clear();
          pre.remove("name");
          pre.remove("email");
          pre.remove("country");
          pre.remove("state");
          pre.remove("city");
          pre.remove("userId");
          pre.remove("islogin");
          pre.remove("success");

          setState(() {
            _isSigningOut = true;
          });

          await Authentication_signOut.signOut(context: context);

          setState(() {
            _isSigningOut = false;
          });

          //exit(0);

          Get.toNamed(RouteHelper.getIntroScreen());
        },
        style: ElevatedButton.styleFrom(
          shadowColor: Colors.transparent,
          backgroundColor: Colors.transparent,
          minimumSize: Size(MediaQuery.of(context).size.width, 40),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12), // <-- Radius
          ),
        ),
        child: Text('Confirm',
            style: TextStyle(color: Colors.white, fontSize: 15)),
      ),
    );
  }

  Widget cancelBtn() {
    return Container(
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(12))),
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFF1FCBDC), Color(0xFF00B8CA)],
        ),
      ),
      height: 46,
      child: ElevatedButton(
        onPressed: () {
          Get.back();
        },
        style: ElevatedButton.styleFrom(
          shadowColor: Colors.transparent,
          backgroundColor: Colors.transparent,
          minimumSize: Size(MediaQuery.of(context).size.width, 40),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12), // <-- Radius
          ),
        ),
        child:
            Text('Cancel', style: TextStyle(color: Colors.white, fontSize: 15)),
      ),
    );
  }
}
