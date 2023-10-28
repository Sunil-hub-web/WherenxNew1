import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:progress_dialog_null_safe/progress_dialog_null_safe.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wherenxnew1/ApiCallingPage/InsertDelightList.dart';
import 'package:wherenxnew1/ApiCallingPage/ViewDelight_List.dart';
import 'package:wherenxnew1/Dimension.dart';
import 'package:wherenxnew1/Routes/RouteHelper.dart';
import 'package:wherenxnew1/modelclass/SuccessResponse.dart';
import 'package:wherenxnew1/modelclass/ViewDelightList.dart';

import '../ApiCallingPage/DelightLIst.dart';
import '../modelclass/DelightsResponse.dart';

import 'package:http/http.dart' as http;

class DelightSelectScreen extends StatefulWidget {
  const DelightSelectScreen({Key? key}) : super(key: key);

  @override
  State<DelightSelectScreen> createState() => _DelightSelectScreenState();
}

class _DelightSelectScreenState extends State<DelightSelectScreen> {
  List<String> data = [
    "Restaurants",
    "Health & Fitness",
    "Family & Kids",
    "Shopping",
    "Museums",
    "Parks",
    "Music",
    "Bar & Night clubs",
    "Sports",
    "Films",
    "Adventure",
    "Events",
  ];
  List<String> icon_data = [
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
  List<String> userChecked = [];
  final List<bool> _selected = List.generate(20, (i) => false);

  List<DelightsResponse> delightres = [];
  List<DelightsResponse> delightres1 = [];
  String value = "";

  Future<List<DelightsResponse>> getDelightList() async {

    // http.Response response = await getDelight();
    // var jsonResponse = json.decode(response.body);
    // var delightresponse = DelightsResponse.fromJson(jsonResponse);
    // List<dynamic> body = jsonDecode(response.body);
    //
    // delightres = body.map((dynamic item) => DelightsResponse.fromJson(item),).toList();
    //
    // delightres1.add(delightresponse);

    // value = delightres1.length.toString();

    delightres1 = (await DelightList().getDelight())!;

    if(delightres1.isNotEmpty){

      print(delightres1.toString());
      return delightres1;

    }else{

      print(delightres1.toString());
      return delightres1;


    }

  }

  List<String> elightlistName = [];
  List<UserInfo> elightlistName1 = [];

  bool islogin = false;
  int userId = 0;

  void showDelightList() async{

    SharedPreferences pre = await SharedPreferences.getInstance();
    islogin = pre.getBool("islogin") ?? false;
    userId = pre.getInt("userId") ?? 0;

    String strUserid = userId.toString();

    http.Response response = await ViewDelight_List().getDelightList(strUserid);
    var jsonResponse = json.decode(response.body);
    var delightlistResponse = ViewDelightList.fromJson(jsonResponse);

    if(delightlistResponse.userInfo!.isNotEmpty){

      for(int i=0;i<delightlistResponse.userInfo!.length;i++){

        elightlistName1.add(delightlistResponse.userInfo![i]);
        userChecked.add(delightlistResponse.userInfo![i].id!.toString());

      }

      value = elightlistName1.length.toString();

    }else{

      print("Delight List Not Found");

    }

    Future.delayed( Duration(seconds: 1)).then((value) => setState(() {}));

  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
   // getDelightList();
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
      backgroundColor: const Color(0xFFF8F8F8),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF8F8F8),
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Container(
          padding: const EdgeInsets.only(
            left: 4.0,
            right: 22.0,
            top: 0.0,
            bottom: 0.0,
          ),
          child: Row(
            children: [
              SizedBox(
                height: 22.0,
                width: 26.0,
                child: IconButton(
                    padding: const EdgeInsets.all(0.0),
                    icon: const Icon(
                      Icons.arrow_back_outlined,
                      color: Colors.black,
                      size: 24.0,
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    }),
              ),
              const SizedBox(
                width: 6,
              ),
              const Text(
                'Select your Delights',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                height: 20,
                padding: const EdgeInsets.only(left: 6, right: 6),
                decoration: BoxDecoration(
                    color: Colors.grey[400],
                    borderRadius: const BorderRadius.all(Radius.circular(50))),
                child: Text(
                  value,
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
      ),
      body: Container(
        width: Dimensions.screenWidth,
        height: Dimensions.screenHeight,
        padding: const EdgeInsets.fromLTRB(18, 10, 18, 18),
        child: FutureBuilder(
          future: getDelightList(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {

            if(snapshot.hasData){
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: Card(
                      color: Colors.white,
                      elevation: 5,
                      shadowColor: Colors.black26,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(20),
                        ),
                      ),
                      child: Container(
                        padding: const EdgeInsets.fromLTRB(15,10,15,10),
                        height: MediaQuery.of(context).size.height * 0.75,
                        color: Colors.transparent,
                        child: ListView.separated(
                          padding: const EdgeInsets.fromLTRB(0,0,0,0),
                          itemCount: delightres1.length,
                          itemBuilder: (context, i) {
                            return ListTile(
                              tileColor: _selected[i] ? const Color(0xFFF8F8F8) : null, // If current item is selected show blue color
                              onTap: () => setState(() => _selected[i] = !_selected[i]),
                              // dense: true,
                              // visualDensity: const VisualDensity(vertical: 1),
                              contentPadding: const EdgeInsets.fromLTRB(12,0,0,0),
                              leading: SizedBox(
                                  height: 22.0,
                                  width: 22.0, // fixed width and height
                                  child: Image.network(delightres1[i].imageUrl!,width: 20,)
                              ),
                              minLeadingWidth : 10,
                              title: Text(delightres1[i].delightName!,
                                style: const TextStyle(
                                  fontSize: 13,
                                  color: Color(0x6F000000),
                                ),
                              ),
                              trailing:Transform.scale(
                                scale: 1.1,
                                child: Checkbox(
                                  activeColor: const Color(0xFF00B8CA),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  side: const BorderSide(
                                    color: Color(0xFFA1A8A9),
                                    width: 1.0,
                                  ),
                                  value: userChecked.contains(delightres1[i].id.toString()),
                                  onChanged: (val) {
                                    _onSelected(val!, delightres1[i].id!.toString());
                                  },
                                ),
                              ),
                            );
                          },
                          separatorBuilder: (context, i) {//<-- SEE HERE
                            return const Divider(
                              height: 1,
                              thickness: 1,
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                  Container(
                    decoration: const ShapeDecoration(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15))),
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Color(0xFF1FCBDC), Color(0xFF00B8CA)],
                      ),
                    ),
                    height: 46,
                    child: ElevatedButton(
                      onPressed: () async {
                        //Get.toNamed(RouteHelper.getotpScreenpage());

                        String jsonUser = jsonEncode(userChecked);
                        var concatenate = userChecked.join(",");
                        print(jsonUser);
                        print(concatenate);

                        SharedPreferences pre = await SharedPreferences.getInstance();
                        int userId = pre.getInt("userId") ?? 0;
                        String strUserid = userId.toString();

                        if(userChecked.isNotEmpty){

                          if(userChecked.length >= 3){

                            pr3.show();

                            print(userChecked);

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

                              SharedPreferences pre = await SharedPreferences.getInstance();
                              pre.setBool("data", true); //save String
                             // Get.toNamed(RouteHelper.getprofileScreenpage());
                              // Get.toNamed(RouteHelper.getHomeScreenpage());

                              Get.toNamed(RouteHelper.getprofileScreenpage());

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
                      style: ElevatedButton.styleFrom(
                        shadowColor: Colors.transparent,
                        backgroundColor: Colors.transparent,
                        minimumSize: Size(MediaQuery.of(context).size.width, 40),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12), // <-- Radius
                        ),
                      ),
                      child: const Text('Save Changes',
                          style: TextStyle(color: Colors.white, fontSize: 15)),
                    ),
                  ),
                ],
              );
            }
            else{return Center(child: CircularProgressIndicator());}

          },

        )
      ),
    );
  }

  void _onSelected(bool selected, String dataName) {
    if (selected == true) {
      setState(() {
        userChecked.add(dataName);
        print(userChecked);

      });
    } else {
      setState(() {
        userChecked.remove(dataName);
        print(userChecked);
      });
    }
  }
}
