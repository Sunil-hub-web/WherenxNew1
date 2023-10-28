import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:progress_dialog_null_safe/progress_dialog_null_safe.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wherenxnew1/ApiCallingPage/ViewDelight_List.dart';
import 'package:wherenxnew1/modelclass/DelightsResponse.dart';
import 'package:wherenxnew1/ApiCallingPage/InsertDelightList.dart';
import 'package:wherenxnew1/modelclass/SuccessResponse.dart';
import 'package:wherenxnew1/modelclass/ViewDelightList.dart';

import '../ApiCallingPage/DelightLIst.dart';
import '../Dimension.dart';
import '../Routes/RouteHelper.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:http/http.dart' as http;

class DelightsScreen extends StatefulWidget {
  const DelightsScreen({Key? key}) : super(key: key);

  @override
  State<DelightsScreen> createState() => _DelightsScreenState();
}

class _DelightsScreenState extends State<DelightsScreen> {
  List<String> icon_white = [
    "assets/images/food-w.png",
    "assets/images/health-w.png",
    "assets/images/family-w.png",
    "assets/images/shopping-w.png",
    "assets/images/museum-w.png",
    "assets/images/park-w.png",
    "assets/images/music-w.png",
    "assets/images/drink-w.png",
    "assets/images/sports-w.png",
    "assets/images/films-w.png",
    "assets/images/advanture-w.png",
    "assets/images/Event-w.png",
  ];
  List<String> icon_black = [
    "assets/images/food-g.png",
    "assets/images/health-g.png",
    "assets/images/family-g.png",
    "assets/images/shopping-g.png",
    "assets/images/museum-g.png",
    "assets/images/park-g.png",
    "assets/images/music-g.png",
    "assets/images/drink-g.png",
    "assets/images/sports-g.png",
    "assets/images/films-g.png",
    "assets/images/advanture-g.png",
    "assets/images/Event-g.png",
  ];
  List<String> widgetList = [
    'Food',
    'Health & Fitness',
    'Family & Kids',
    'Shopping',
    'Museums ',
    'Parks',
    'Music',
    'Bar & Night clubs',
    'Sports',
    'Films',
    'Adventure',
    'Events',
  ];

  List<DelightsResponse> delightres = [];
  List<DelightsResponse> delightres1 = [];
  String concatenate = "";

  Future<List<DelightsResponse>> getDelightList() async {

    // http.Response response = await getDelight();
    // var jsonResponse = json.decode(response.body);
    // var delightresponse = DelightsResponse.fromJson(jsonResponse);
    // List<dynamic> body = jsonDecode(response.body);
    //
    // delightres = body.map((dynamic item) => DelightsResponse.fromJson(item),).toList();
    //
    // delightres1.add(delightresponse);




    delightres1 = (await DelightList().getDelight())!;

    if(delightres1.isNotEmpty){

      print(delightres1.toString());
      return delightres1;

    }else{

      print(delightres1.toString());
      return delightres1;


    }

    //Future.delayed(const Duration(seconds: 1)).then((value) => setState(() {}));

  }

  List<String> elightlistName = [];
  List<UserInfo> elightlistName1 = [];
  List<String> namelist = [];

  bool islogin = false;
  int userId = 0;



  Future<List<String>> showDelightList() async{

    SharedPreferences pre = await SharedPreferences.getInstance();
    islogin = pre.getBool("islogin") ?? false;
    userId = pre.getInt("userId") ?? 0;

    namelist.clear();

    String strUserid = userId.toString();

    http.Response response = await ViewDelight_List().getDelightList(strUserid);
    var jsonResponse = json.decode(response.body);
    var delightlistResponse = ViewDelightList.fromJson(jsonResponse);

    if(delightlistResponse.status == "success"){

      if(delightlistResponse.userInfo!.isNotEmpty){

        for(int i=0;i<delightlistResponse.userInfo!.length;i++){

          elightlistName1.add(delightlistResponse.userInfo![i]);
          namelist.add(delightlistResponse.userInfo![i].id!.toString());

        }

      }else{

        print("Delight List Not Found");

      }
    }else{

      Fluttertoast.showToast(
          msg: delightlistResponse.message!,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0);

    }



    Future.delayed( Duration(seconds: 1)).then((value) => setState(() {}));

    return namelist;
  }


  List<bool> cardsValue = [false, false];
  int checkedIndex_s = 0;
  late bool isActive_s = false;
  late int index_s = 0;

  late List<int> selectedList;


  List<int> itemList = [];
  List<int> itemListIndex = [];
  bool isSelected1 = false;
  int selectedCard = -1;

  @override
  void initState() {
    super.initState();
  //  getDelightList();
    showDelightList();
  }

  @override
  Widget build(BuildContext context) {

    ProgressDialog pr3 = ProgressDialog(context);
    pr3 = ProgressDialog(context, type: ProgressDialogType.normal);
    pr3.style(
        message: 'Insert Delights',
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
        child: FutureBuilder(
          future: getDelightList(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {

          //  showDelightList();

            if(snapshot.hasData){

              return Container(
                margin: const EdgeInsets.only(top: 30, left: 20, right: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(
                          left: 0.0, top: 5.0, right: 0.0, bottom: 5.0),
                      padding: const EdgeInsets.only(
                          left: 5.0, top: 0, right: 5.0, bottom: 0),
                      child: const Text(
                        "Almost there! Tell us what delights \nyou in your travels... ",
                        maxLines: 2,
                        style: TextStyle(
                            fontSize: 18,
                            height: 1.3,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.normal,
                            color: Colors.white),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(
                          left: 5.0, top: 0, right: 5.0, bottom: 5),
                      child: const Text(
                        "Select 3 (or more) so that we can create \nsuggestions for you. You will be able to change \nthem later from your Profile.",
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.normal,
                            color: Colors.white),
                      ),
                    ),
                    Container(
                      child: Expanded(
                        child: GridView.builder(
                          itemCount: delightres1.length,
                          gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 1.5,
                            crossAxisSpacing: 7,
                            mainAxisSpacing: 7,
                          ),
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {

                                //Navigator.of(context).pushNamed(RouteName.GridViewCustom);

                                // Fluttertoast.showToast(
                                //     msg: delightres1[index].id!.toString(),
                                //     toastLength: Toast.LENGTH_SHORT,
                                //     gravity: ToastGravity.BOTTOM,
                                //     timeInSecForIosWeb: 1,
                                //     backgroundColor: Colors.red,
                                //     textColor: Colors.white,
                                //     fontSize: 16.0);

                                if (namelist.isEmpty) {
                                  namelist.add(delightres1[index].id!.toString());
                                  // itemList.add(index);
                                } else {
                                  if (namelist.contains(delightres1[index].id!.toString())) {
                                    namelist.remove(delightres1[index].id!.toString());
                                    //  itemList.removeAt(index);

                                  } else {
                                    namelist.add(delightres1[index].id!.toString());
                                    //  itemList.add(index);
                                  }
                                }
                                String jsonUser = jsonEncode(namelist);
                                concatenate = namelist.join(",");
                                print(jsonUser);
                                // print(itemList);
                                print(concatenate);


                                setState(() {});
                              },
                              child: Container(
                                height: MediaQuery.of(context).size.height,
                                // color: selectedIndex.contains(index) ? Colors.blueAccent : Colors.white  /*RandomColorModel().getColor()*/ ,
                                margin: const EdgeInsets.all(5),
                                decoration: namelist.contains(delightres1[index].id!.toString())
                                    ? BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  gradient: const LinearGradient(
                                      begin:
                                      Alignment(6.123234262925839e-17, 1),
                                      end: Alignment(-1, 6.123234262925839e-17),
                                      colors: [
                                        Color.fromRGBO(31, 203, 220, 1),
                                        Color.fromRGBO(31, 203, 220, 1)
                                      ]),
                                )
                                    : BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  gradient: const LinearGradient(
                                      begin:
                                      Alignment(6.123234262925839e-17, 1),
                                      end: Alignment(-1, 6.123234262925839e-17),
                                      colors: [
                                        Color.fromRGBO(255, 255, 255, 1.0),
                                        Color.fromRGBO(255, 255, 255, 1.0)
                                      ]),
                                ),

                                child:Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      const Align(
                                        alignment: Alignment.topRight,
                                        child: Icon(
                                          Icons.verified,
                                          color: Colors.white,
                                          size: 20,
                                          // color: Theme.of(context).primarySwatch,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 30,
                                        height: 30,
                                        child: Center(
                                            child: Image.network(delightres1[index].imageUrl!)
                                        ),
                                      ),
                                      Text(delightres1[index].delightName!,
                                          style: const TextStyle(
                                              fontSize: 12, color: Colors.black),
                                          textAlign: TextAlign.center),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),

                        /*GridView.count(
                    crossAxisCount: 2,
                    childAspectRatio: 2,
                    crossAxisSpacing: 7,
                    mainAxisSpacing: 7,
                    //physics:NeverScrollableScrollPhysics(),
                    // controller: ScrollController(
                    //     keepScrollOffset: true),
                    // shrinkWrap: false,
                    // scrollDirection: Axis.vertical,
                    children: widgetList.map((String value) {
                      //print("____________value____________");
                      // print("value: "+value);
                      //  print("value: "+widgetList.length.toString());

                      bool checked = widgetList.indexOf(value) == checkedIndex_s;
                      return GestureDetector(
                          onTap: () {
                            print("$value is clicked");
                            itemList.add(widgetList.indexOf(value));
                            print(itemList.toString());

                            setState(
                              () {
                                isActive_s = true;
                                int index = widgetList.indexOf(value);
                                // print("index is " + index.toString());
                                checkedIndex_s = index;

                                // if (isActive_s) {
                                //   selectedList.add(itemList[index]);
                                //
                                // } else {
                                //   selectedList.remove(itemList[index]);
                                //
                                // }
                              },
                            );

                            //Get.toNamed(RouteHelper.getpackageBookingpage());
                          },
                          child: Container(
                            child: Card(
                              shadowColor: Colors.black26,  // Change this
                              color: checked ? Colors.white30 : Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(Dimensions.size12),
                              ),
                              elevation: 2,
                              child: Padding(
                                padding: const EdgeInsets.all(1.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Stack(
                                      children: [
                                        Container(
                                          child: Padding(
                                            padding: EdgeInsets.only(
                                              left: Dimensions.size130,
                                              //top: Dimensions.size100
                                            ),
                                            child: const Icon(
                                              Icons.verified,
                                              color: Colors.white,
                                              size: 20,
                                              // color: Theme.of(context).primarySwatch,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Container(
                                      width: 30,
                                      height: 30,
                                      child: Center(
                                        child: Image(
                                          image: checked ? AssetImage(icon_white[ widgetList.indexOf(value)])
                                              : AssetImage(icon_black[ widgetList.indexOf(value)]),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: Dimensions.size1,
                                    ),
                                    Text(
                                      value,
                                      style: TextStyle(
                                        fontSize: Dimensions.size12,
                                        color: checked
                                            ? Colors.white
                                            : Colors.black87,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ));
                    }).toList(),
                  ),*/
                      ),
                    ),

                    Container(
                      margin: const EdgeInsets.only(
                          left: 5.0, top: 0, right: 5.0, bottom: 40),
                      width: Dimensions.screenWidth,
                      child: TextButton(
                        style: ButtonStyle(
                          padding: MaterialStateProperty.all<EdgeInsets>(
                              const EdgeInsets.all(12)),
                          backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.white30),
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.0),
                                side: const BorderSide(
                                  color: Color(0xFFFFFFFF),
                                ),
                              )),
                        ),
                        onPressed: () async{

                          SharedPreferences pre = await SharedPreferences.getInstance();
                          int userId = pre.getInt("userId") ?? 0;
                          String strUserid = userId.toString();

                          if(namelist.isNotEmpty){

                            if(namelist.length >= 3){

                              pr3.show();

                              print(namelist);

                              String jsonUser = jsonEncode(namelist);
                              concatenate = namelist.join(",");
                              print(jsonUser);
                              // print(itemList);
                              print(concatenate);


                              http.Response response = await InsertDelightList().getinsertDelight(strUserid,concatenate);
                              var jsonResponse = json.decode(response.body);
                              var delightlist = SuccessResponse.fromJson(jsonResponse);

                              print("$userId,$concatenate");

                              if(delightlist.status == "success"){

                                pr3.hide();

                                Fluttertoast.showToast(
                                    msg: delightlist.message!,
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Colors.red,
                                    textColor: Colors.white,
                                    fontSize: 16.0);

                                Get.toNamed(RouteHelper.getHomeScreenpage());
                                // Get.toNamed(RouteHelper.getexploreScreenpage());

                              }else{

                                pr3.hide();

                                Fluttertoast.showToast(
                                    msg: delightlist.message!,
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Colors.red,
                                    textColor: Colors.white,
                                    fontSize: 16.0);
                              }
                            }else{

                              Fluttertoast.showToast(
                                  msg: "Please insert Delight more then three",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.red,
                                  textColor: Colors.white,
                                  fontSize: 16.0);
                            }

                          }else{

                            pr3.hide();

                            Fluttertoast.showToast(
                                msg: "Please insert Delight",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.red,
                                textColor: Colors.white,
                                fontSize: 16.0);
                          }

                        },
                        child: namelist.length >= 3
                            ? const Text('Done',

                            style: TextStyle(
                                height: 1.4,
                                color: Colors.white,
                                fontWeight: FontWeight.normal,
                                fontSize: 15))
                            : const Text('Select 1 more',
                            style: TextStyle(
                                height: 1.4,
                                color: Colors.white,
                                fontWeight: FontWeight.normal,
                                fontSize: 15)),
                      ),
                    ),
                  ],
                ),
              );

            }else{

              return Center(child: CircularProgressIndicator());

            }

          },

        )
      ),
    );
  }
}
