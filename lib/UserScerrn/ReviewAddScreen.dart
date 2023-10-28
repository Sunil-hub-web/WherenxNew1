import 'dart:convert';

import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:progress_dialog_null_safe/progress_dialog_null_safe.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wherenxnew1/ApiCallingPage/AddReview.dart';
import 'package:wherenxnew1/modelclass/ReviewSuccessStatues.dart';
import 'package:wherenxnew1/videorecording/CameraPage.dart';
import '../Dimension.dart';
import '../Helper/img.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../Routes/RouteHelper.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

class ReviewAddScreen extends StatefulWidget {
  @override
  _ReviewAddScreenState createState() => _ReviewAddScreenState();
}

class _ReviewAddScreenState extends State<ReviewAddScreen> {
  TextEditingController userInput = TextEditingController();
  String text = "",
      placeId = "",
      placename = "",
      F_name = "",
      formattedDate = "",
      placeType = "",
      profileImage = "";
  int userId = 0, profileImagehight = 0;
  double? _rating = 0.0;
  String googleApikey = "AIzaSyAuFYxq-RX0I1boI5HU5-olArirEi2Ez8k";

  //TextEditingController messageController = TextEditingController();

  Future<void> getUserData() async {
    SharedPreferences pre = await SharedPreferences.getInstance();
    placeId = pre.getString("placeId") ?? "";
    placename = pre.getString("placename") ?? "";
    userId = pre.getInt("userId") ?? 0;
    F_name = pre.getString("name") ?? "";
    placeType = pre.getString("placeType") ?? "";
    profileImage = pre.getString("profileImage") ?? "";
    profileImagehight = pre.getInt("profileImagehight") ?? 0;

    var now = new DateTime.now();
    var formatter = new DateFormat('yyyy-MM-dd');
    formattedDate = formatter.format(now);
    print(formattedDate); // 2016-01-25

    Future.delayed(Duration(seconds: 1)).then((value) => setState(() {}));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getUserData();
  }

  @override
  Widget build(BuildContext context) {
    IconData? _selectedIcon;

    ImagePicker picker = ImagePicker();
    XFile? image;

    ProgressDialog pr12 = ProgressDialog(context);
    pr12 = ProgressDialog(context, type: ProgressDialogType.normal);
    pr12.style(
        message: 'Update Review Wait...',
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

    return Scaffold(
      backgroundColor: Colors.white,
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              expandedHeight: 300.0,
              floating: false,
              pinned: true,
              backgroundColor: Colors.white,
              foregroundColor: Colors.white,
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                background: profileImage == ""
                    ? Image.asset(Img.get('food-image.png'), fit: BoxFit.cover)
                    : getImage(profileImage,"$profileImagehight"),
              ),
              systemOverlayStyle: SystemUiOverlayStyle.light,
            ),
          ];
        },
        body: Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
            color: Colors.white,
          ),
          child: SingleChildScrollView(
            child: Container(
              clipBehavior: Clip.hardEdge,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25),
                  topRight: Radius.circular(25),
                ),
                color: Colors.white,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.fromLTRB(20, 20, 20, 40),
                    width: Dimensions.screenWidth,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          placename,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(0xFF212828),
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          placeType,
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.black54, fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 30),
                    width: Dimensions.screenWidth,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text(
                              "How will you rate this place?",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 16),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Container(
                          child: RatingBar.builder(
                            initialRating: _rating ?? 0.0,
                            minRating: 1,
                            direction: Axis.horizontal,
                            allowHalfRating: true,
                            itemCount: 5,
                            itemSize: 45.0,
                            itemPadding:
                                const EdgeInsets.symmetric(horizontal: 2.0),
                            itemBuilder: (context, _) => const Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            onRatingUpdate: (rating) async {
                              print(rating);
                              _rating = rating;
                              SharedPreferences pre =
                                  await SharedPreferences.getInstance();
                              pre.setDouble("_rating", _rating!); //s
                              setState(() {});
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: const Color(0xFFDDE4E4),
                        //                   <--- border color
                        width: 1.0,
                      ),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(14.0),
                      ),
                    ),
                    height: 150,
                    child: TextFormField(
                      controller: userInput,
                      style: const TextStyle(
                        fontSize: 13,
                        color: Color(0xFFA1A8A9),
                        fontWeight: FontWeight.w400,
                      ),
                      onChanged: (value) {},
                      cursorColor: const Color(0xFFDDE4E4),
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(13.0),
                          borderSide: BorderSide.none,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(13.0),
                        ),
                        fillColor: Colors.grey,
                        contentPadding: const EdgeInsets.fromLTRB(15, 0, 10, 0),
                        // control your hints text size
                        hintText: 'Please share your experience in this place.',
                        hintStyle: const TextStyle(
                          color: Colors.grey,
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: 46,
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                    margin: const EdgeInsets.fromLTRB(0, 20, 0, 30),
                    width: Dimensions.screenWidth,
                    child: TextButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            const Color(0xFFF8F8F8)),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          // side: const BorderSide(color: Color(0xFFDDE4E4),),
                        )),
                        padding: MaterialStateProperty.all<EdgeInsets>(
                            const EdgeInsets.only(
                          left: 12,
                          right: 12,
                        )),
                      ),
                      onPressed: () async {
                        if(_rating == 0.0){
                          Left_indicator_bar_Flushbar(context,"Select Your Rating");
                        }else{
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const CameraPage()),
                          );
                        }
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          SvgPicture.asset(
                            'assets/images/video-icon.svg',
                            width: 24,
                            color: const Color(0xFF00B8CA),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          const Text(
                            "Add video review",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 14,
                                color: Color(0xFF00B8CA),
                                fontWeight: FontWeight.normal),
                          ), // text
                        ],
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                    child: Container(
                      decoration: const ShapeDecoration(
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(15))),
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [Color(0xFF1FCBDC), Color(0xFF00B8CA)],
                        ),
                      ),
                      height: 46,
                      child: ElevatedButton(
                        onPressed: () async {
                          pr12.show();

                          String struserId = userId.toString();
                          String strrating = _rating.toString();

                          http.Response response = await AddReview()
                              .addReviewDetails(
                                  struserId,
                                  formattedDate,
                                  F_name,
                                  placename,
                                  placeId,
                                  strrating,
                                  userInput.text.toString());
                          var jsonResponse = json.decode(response.body);
                          var reviewResponse =
                              ReviewSuccessStatues.fromJson(jsonResponse);

                          String allvaluedet =
                              "$struserId, $formattedDate, $F_name,$placename, $placeId, $strrating${userInput.text.toString()}";

                          print(allvaluedet);

                          if (reviewResponse.status == "200") {
                            pr12.hide();

                            Fluttertoast.showToast(
                                msg: reviewResponse.message!,
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.green,
                                textColor: Colors.white,
                                fontSize: 16.0);

                            Get.toNamed(RouteHelper.getdetailsScreen());
                          } else {
                            pr12.hide();

                            Fluttertoast.showToast(
                                msg: reviewResponse.message!,
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.red,
                                textColor: Colors.white,
                                fontSize: 16.0);
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          shadowColor: Colors.transparent,
                          backgroundColor: Colors.transparent,
                          minimumSize:
                              Size(MediaQuery.of(context).size.width, 40),
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(12), // <-- Radius
                          ),
                        ),
                        child: const Text('Post review',
                            style:
                                TextStyle(color: Colors.white, fontSize: 15)),
                      ),
                    ),
                  ),
                  // Text(userInput.toString()),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Image getImage(String photoReference,String maxWidth) {
    var baseurl = "https://maps.googleapis.com/maps/api/place/photo";
    //var maxWidth = "100";
   // var maxHeight = "100";
    final url =
        "$baseurl?maxwidth=$maxWidth&photo_reference=$photoReference&key=$googleApikey";
    return Image.network(
         url,
         fit: BoxFit.cover,
        filterQuality: FilterQuality.high
    );
  }

  void Left_indicator_bar_Flushbar(BuildContext context, String Message) {
    Flushbar(
      message: Message,
      icon: Icon(
        Icons.info_outline,
        size: 28.0,
        color: Colors.blue[300],
      ),
      duration: Duration(seconds: 3),
      leftBarIndicatorColor: Colors.red[300],
    )..show(context);
  }
}
