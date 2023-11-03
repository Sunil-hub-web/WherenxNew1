import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:another_flushbar/flushbar.dart';
import 'package:custom_info_window/custom_info_window.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:progress_dialog_null_safe/progress_dialog_null_safe.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wherenxnew1/ApiCallingPage/AddKMRadius.dart';
import 'package:wherenxnew1/ApiCallingPage/PinThePlaceFile.dart';
import 'package:wherenxnew1/ApiImplement/ViewDialog.dart';
import 'package:wherenxnew1/Dimension.dart';
import 'package:flutter_google_places_hoc081098/flutter_google_places_hoc081098.dart';
import 'package:google_api_headers/google_api_headers.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wherenxnew1/modelclass/PinPlace_Response.dart';
import 'package:wherenxnew1/modelclass/SuccessResponseKM.dart';
import '../ApiCallingPage/ViewDelight_List.dart';
import '../Routes/RouteHelper.dart';
import 'package:http/http.dart' as http;
import '../model/NearByplaces.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../modelclass/ViewDelightList.dart';

import 'package:responsive_sizer/responsive_sizer.dart';

class ExploreScreen extends StatefulWidget {
  ExploreScreen({Key? key}) : super(key: key);

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  final CustomInfoWindowController _customInfoWindowController =
      CustomInfoWindowController();
  TextEditingController editingController = TextEditingController();
  final Set<Marker> markers = Set();
  Set<Marker> marker = {}; //markers for google map
  // String style = '  [{"elementType":"geometry","stylers":[{"color":"#f5f5f5"}]},{"elementType":"labels.icon","stylers":[{"visibility":"off"}]},{"elementType":"labels.text.fill","stylers":[{"color":"#616161"}]},{"elementType":"labels.text.stroke","stylers":[{"color":"#f5f5f5"}]},{"featureType":"administrative.land_parcel","elementType":"labels.text.fill","stylers":[{"color":"#bdbdbd"}]},{"featureType":"poi","elementType":"geometry","stylers":[{"color":"#eeeeee"}]},{"featureType":"poi","elementType":"labels.text.fill","stylers":[{"color":"#757575"}]},{"featureType":"poi.park","elementType":"geometry","stylers":[{"color":"#e5e5e5"}]},{"featureType":"poi.park","elementType":"labels.text.fill","stylers":[{"color":"#9e9e9e"}]},{"featureType":"road","elementType":"geometry","stylers":[{"color":"#ffffff"}]},{"featureType":"road.arterial","elementType":"labels.text.fill","stylers":[{"color":"#757575"}]},{"featureType":"road.highway","elementType":"geometry","stylers":[{"color":"#dadada"}]},{"featureType":"road.highway","elementType":"labels.text.fill","stylers":[{"color":"#616161"}]},{"featureType":"road.local","elementType":"labels.text.fill","stylers":[{"color":"#9e9e9e"}]},{"featureType":"transit.line","elementType":"geometry","stylers":[{"color":"#e5e5e5"}]},{"featureType":"transit.station","elementType":"geometry","stylers":[{"color":"#eeeeee"}]},{"featureType":"water","elementType":"geometry","stylers":[{"color":"#c9c9c9"}]},{"featureType":"water","elementType":"labels.text.fill","stylers":[{"color":"#9e9e9e"}]}]   ';
  List<Marker> _markers = <Marker>[];
  late final List<LatLng> _latlang = <LatLng>[
    const LatLng(37.8040512, -122.2731983),
    const LatLng(37.8034709, -122.2795151),
    const LatLng(37.8034709, -122.2795151),
    const LatLng(
      37.8018137,
      -122.2827713,
    ),
    const LatLng(37.8065459, -122.2809447),
    const LatLng(37.8064198, -122.279487),
    const LatLng(37.8007816, -122.2849908),
    const LatLng(37.8055785, -122.2802621),
    const LatLng(37.8067759, -122.2845563),
    const LatLng(37.8064198, -122.279597),
  ];

//chips
  List<Map<String, String>> searchKeywords = [
    {'name': 'My delights', 'active': "no"},
    {'name': 'Restaurants', 'active': "no"},
    {'name': 'bar', 'active': "no"},
    {'name': 'Shopping', 'active': "no"},
    {'name': 'Museums', 'active': "no"},
    {'name': 'More', 'active': "no"},
  ];
  List<String> icon_black = [
    "assets/images/user-g1.png",
    "assets/images/food-g.png",
    "assets/images/drink-g.png",
    "assets/images/shopping-g.png",
    "assets/images/museum-g.png",
    "assets/images/menu-g.png",
  ];
  List<String> icon_white = [
    "assets/images/user-w.png",
    "assets/images/food-w.png",
    "assets/images/drink-w.png",
    "assets/images/shopping-w.png",
    "assets/images/museum-w.png",
    "assets/images/menu.png",
  ];

  String miles = "";
  String _radius1 = "10";
  String _radius3 = "0";
  String _radius2 = "1000";
  bool tap = false;
  double _radius = 0;
  int curIndex = -1;
  String googleApikey = "AIzaSyAuFYxq-RX0I1boI5HU5-olArirEi2Ez8k";

  //String googleApikey = "AIzaSyAuFYxq-RX0I1boI5HU5-olArirEi2Ez8k";
  String locationString = "Search delights";
  late LatLng _latLng;
  late String _name = "", city = "", state = "", countary = "", mobileNo = "";
  late bool islogin = false;
  int userId = 0;
  NearByplaces nearByplaces = NearByplaces();
  List<Results> nearbyLocations = [];
  List<Results> nearbyLocations1 = [];
  double totalDistance = 0;
  List<String> kilometers = [];
  String? _currentAddress;

  loaddata() async {
    BitmapDescriptor mapMarker;
    mapMarker = await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(),
        tap ? 'assets/images/kitchen-150.png' : 'assets/images/kitchen-70.png');

    for (int i = 0; i < _latlang.length; i++) {
      _markers.add(
        Marker(
            markerId: MarkerId(i.toString()),
            icon: mapMarker,
            //infoWindow: InfoWindow(title: '210 pinned'),
            position: _latlang[i],
            onTap: () {
              setState(() {
                tap = true;
              });
              print("taped : " + _latlang[i].toString());

              Get.toNamed(RouteHelper.getexploreOnScreenpage());

              // _customInfoWindowController.addInfoWindow!(
              //
              //   Container(
              //       //width: 500,
              //      // height: 500,
              //       // decoration: BoxDecoration(
              //       //   color: Colors.red,
              //       //   border: Border.all(color: Colors.grey),
              //       //   borderRadius: BorderRadius.circular(10.0),
              //       // ),
              //      // child: Text("taped : "+_latlang[i].toString()),
              //       // child: Column(
              //       //   mainAxisAlignment: MainAxisAlignment.start,
              //       //   crossAxisAlignment: CrossAxisAlignment.start,
              //       //   children: [
              //       //     Container(
              //       //       width: 200,
              //       //       height: 100,
              //       //       decoration:  BoxDecoration(
              //       //         image: DecorationImage(
              //       //           image: NetworkImage("https://www.experiencetravelgroup.com/blog/wp-content/uploads/2019/09/Periyar-_7245-Small.jpg"),
              //       //           fit: BoxFit.fitWidth,
              //       //           filterQuality: FilterQuality.high,
              //       //         ),
              //       //         borderRadius:  BorderRadius.all(
              //       //           Radius.circular(10.0),
              //       //         ),
              //       //       ),
              //       //     ),
              //       //     Container(
              //       //       margin: EdgeInsets.only(left: 5),
              //       //       child: Text("Name of Place",
              //       //         style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 15),
              //       //         textAlign: TextAlign.start,
              //       //       ),
              //       //     ),
              //       //     Container(
              //       //       margin: EdgeInsets.only(left: 5),
              //       //       child: Text("210 Pinned",
              //       //         style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 12),
              //       //         textAlign: TextAlign.start,
              //       //       ),
              //       //     )
              //       //
              //       //   ],
              //       // )
              //   ),
              //
              //   _latlang[i],
              // );
            }),
      );
      setState(() {});
    }
  }

  List<ViewDelightList> viewdelightlist = [];

  List<String> elightlistName = [];
  List<UserInfo> elightlistName1 = [];
  String kename = "", delightId = "", kenameType = "";
  int delight_Id = 0;

  bool isVisible = false, isTextVisible = false;

  double startlatitude1 = 0.0, startlongitude1 = 0.0, dob_radiusData = 0.0;

  Future<List<UserInfo>> showDelightList() async {
    //elightlistName1.clear();

    SharedPreferences pre = await SharedPreferences.getInstance();
    islogin = pre.getBool("islogin") ?? false;
    userId = pre.getInt("userId") ?? 0;
    dob_radiusData = pre.getDouble("radiusData") ?? 0.0;

    String radiusData = dob_radiusData.toString();
    _radius3 = radiusData;

    print("dataradis$radiusData");
    print("userIddataradis$userId");

    String strUserid = userId.toString();

    http.Response response = await ViewDelight_List().getDelightList(strUserid);
    var jsonResponse = json.decode(response.body);
    var delightlistResponse = ViewDelightList.fromJson(jsonResponse);

    if (delightlistResponse.status == "success") {
      if (elightlistName1.isEmpty) {
        if (delightlistResponse.userInfo!.isNotEmpty) {
          for (int i = 0; i < delightlistResponse.userInfo!.length; i++) {
            elightlistName1.add(delightlistResponse.userInfo![i]);
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
      }
    } else {
      Fluttertoast.showToast(
          msg: delightlistResponse.message!,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.redAccent,
          textColor: Colors.white,
          fontSize: 16.0);
    }

    _determinePosition1();

    Future.delayed(const Duration(seconds: 1)).then((value) => setState(() {}));

    return elightlistName1;
  }

  Completer<GoogleMapController> _controller = Completer();

  static LatLng _center = const LatLng(37.8024085, -122.2751843);

  static CameraPosition cameraPosition =
      const CameraPosition(target: LatLng(20.3490, 85.8077), zoom: 14.4465);
  late GoogleMapController googleMapController;
  String kmMiles = "1.609344";
  double kmMiles_d = 1.609344;

  Future<Position> _determinePosition1() async {
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

    startlatitude1 = position.latitude;
    startlongitude1 = position.longitude;

    if (kDebugMode) {
      print("latitudedetails1 $startlatitude1");
      print("latitudedetails1 $startlongitude1");
    }

    for (int i = 0; i < elightlistName1.length; i++) {
      if (elightlistName1[i].delightName == "Restaurant") {
        getNearbyPlaces2(
            startlatitude1, startlongitude1, "1000", "restaurant|food");
      } else if (elightlistName1[i].delightName == "Bar") {
        getNearbyPlaces2(
            startlatitude1, startlongitude1, "1000", "bar|night_club");
      } else if (elightlistName1[i].delightName == "Shopping") {
        getNearbyPlaces2(
            startlatitude1, startlongitude1, "1000", "shopping_mall");
      } else if (elightlistName1[i].delightName == "Museum") {
        getNearbyPlaces2(startlatitude1, startlongitude1, "1000", "museum");
      } else if (elightlistName1[i].delightName == "Health & Fitness") {
        getNearbyPlaces2(
            startlatitude1, startlongitude1, "1000", "gym|health|hospital");
      } else if (elightlistName1[i].delightName == "Park") {
        getNearbyPlaces2(
            startlatitude1, startlongitude1, "1000", "park|amusement_park");
      } else if (elightlistName1[i].delightName == "Sports") {
        getNearbyPlaces2(
            startlatitude1, startlongitude1, "1000", "shoe_store|store");
      } else if (elightlistName1[i].delightName == "Films") {
        getNearbyPlaces2(
            startlatitude1, startlongitude1, "1000", "movie_theater");
      } else if (elightlistName1[i].delightName == "Event") {
        getNearbyPlaces2(startlatitude1, startlongitude1, "1000", "event");
      } else if (elightlistName1[i].delightName == "Music") {
        getNearbyPlaces2(startlatitude1, startlongitude1, "1000", "night_club");
      } else if (elightlistName1[i].delightName == "Adventure") {
        getNearbyPlaces2(startlatitude1, startlongitude1, "1000",
            "aquarium|art_gallery|tourist_attraction");
      }
    }

    // getNearbyPlaces1(latitude1, longitude1, radius, kename);

    Future.delayed(const Duration(seconds: 1)).then((value) => setState(() {}));

    return position;
  }

  Set<Circle> getcirclesdet() {
    Set<Circle> circles = {
      Circle(
          circleId: const CircleId("1"),
          center: LatLng(startlatitude1, startlongitude1),
          radius: 1000,
          fillColor: Colors.redAccent,
          strokeColor: Colors.white,
          strokeWidth: 1)
    };

    return circles;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    showDelightList();
    _determinePosition1();
  }

  @override
  Widget build(BuildContext context) {
    // _determinePosition1();

    // showDelightList();

    ProgressDialog pr4 = ProgressDialog(context);
    pr4 = ProgressDialog(context, type: ProgressDialogType.normal);
    pr4.style(
        message: 'Insert Pin Details Wait...',
        borderRadius: 10.0,
        backgroundColor: Colors.white,
        progressWidget: const CircularProgressIndicator(),
        elevation: 10.0,
        insetAnimCurve: Curves.easeInOut,
        progress: 0.0,
        progressTextStyle: const TextStyle(
            color: Colors.black, fontSize: 13.0, fontWeight: FontWeight.w400),
        messageTextStyle: const TextStyle(
            color: Colors.black, fontSize: 13.0, fontWeight: FontWeight.w600));

    ProgressDialog pr11 = ProgressDialog(context);
    pr11 = ProgressDialog(context, type: ProgressDialogType.normal);
    pr11.style(
        message: 'Show Details Wait.....',
        borderRadius: 10.0,
        backgroundColor: Colors.white,
        progressWidget: const CircularProgressIndicator(),
        elevation: 10.0,
        insetAnimCurve: Curves.easeInOut,
        progress: 0.0,
        progressTextStyle: const TextStyle(
            color: Colors.black, fontSize: 13.0, fontWeight: FontWeight.w400),
        messageTextStyle: const TextStyle(
            color: Colors.black, fontSize: 13.0, fontWeight: FontWeight.w600));

    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ));

    return Scaffold(
        body: SizedBox(
      height: Dimensions.screenHeight,
      width: Dimensions.screenWidth,
      child: Stack(
        children: <Widget>[
          GoogleMap(
            initialCameraPosition: cameraPosition,
            markers: displayPrediction(),
            zoomControlsEnabled: true,
            mapToolbarEnabled: true,
            myLocationEnabled: true,
            compassEnabled: true,
            mapType: MapType.terrain,
            onMapCreated: (GoogleMapController controller) {
              googleMapController = controller;
            },
          ),

          /* GoogleMap(
                zoomControlsEnabled: true,
                mapToolbarEnabled: true,
                mapType: MapType.terrain,
                // mapType: controller,
                onMapCreated: (GoogleMapController controller) {
                  controller.setMapStyle(style);
                },
                initialCameraPosition:  CameraPosition(
                  target: _center,
                  zoom: 14.0,
                ),
                markers: Set.of(_markers),
              ),*/

          // Container(
          //   color: Colors.red,
          //   margin: EdgeInsets.only(top: 200),
          //   child: CustomInfoWindow(controller: _customInfoWindowController,
          //     width: 500,
          //     height: Dimensions.size100,
          //     offset: 20,
          //   ),
          // ),

          ResponsiveSizer(builder: (context, orientation, screenType) {
            return Container(
              margin: EdgeInsets.only(
                  top: 0.4.dp, left: 0.1.dp, right: 0.1.dp, bottom: 0.3.dp),
              width: 100.w,
              height: 15.h,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 3,
                    child: InkWell(
                      onTap: () async {
                        // var place = await PlacesAutocomplete.show(
                        //     context: context,
                        //     apiKey: googleApikey,
                        //     mode: Mode.overlay,
                        //     types: [],
                        //     strictbounds: false,
                        //     // components: [Component(Component.country, 'us')],
                        //     //google_map_webservice package
                        //     onError: (err) {
                        //       print("errordetails ${err}");
                        //     });
                        // if (place != null) {
                        //   setState(() {
                        //     // location = place.description.toString();
                        //   });
                        //
                        //   //form google_maps_webservice package
                        //   final plist = GoogleMapsPlaces(
                        //     apiKey: googleApikey,
                        //     apiHeaders: await GoogleApiHeaders().getHeaders(),
                        //     //from google_api_headers package
                        //   );
                        //   String placeid = place.placeId ?? "0";
                        //   final detail =
                        //       await plist.getDetailsByPlaceId(placeid);
                        //   final geometry = detail.result.geometry!;
                        //   final lat = geometry.location.lat;
                        //   final lang = geometry.location.lng;
                        //   var newlatlang = LatLng(lat, lang);
                        //
                        //   getNearbyPlaces(lat, lang, _radius2);
                        //
                        //   //  _markers.add(Marker(markerId: MarkerId('Home'),
                        //   // icon: mapMarker,
                        //   // position: LatLng(lat, lang)));
                        //
                        //   // _controller?.animateCamera(CameraUpdate.newCameraPosition(new CameraPosition(
                        //   //   target: LatLng(lat,lang),
                        //   //   zoom: 17,
                        //   // )));
                        //   setState(() {
                        //     // getLatitude= lat;
                        //     // getLongitude = lang;
                        //
                        //     _markers.add(Marker(
                        //         markerId: MarkerId('Home'),
                        //         // icon: mapMarker,
                        //         position: LatLng(lat, lang)));
                        //   });
                        // }
                      },
                      child: Container(
                        // height: 6.5.h,
                        // margin: EdgeInsets.only(bottom: 0.3.dp),
                        margin: EdgeInsets.only(top: 0.1.dp, bottom: 0.2.dp),
                        //padding: EdgeInsets.only(top: 0.1.dp, right: 0.1.dp, bottom: 0.1.dp, left: 0.1.dp,),
                        // decoration: BoxDecoration(
                        //     borderRadius: BorderRadius.circular(12),
                        //     color: Colors.white),
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: TextField(
                            onChanged: (value) async {
                              // var url = Uri.parse('https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=' + latitude.toString() + ',' + longitude.toString() + '&radius=' + radius + '&key=' + apikey);
                              _determinePosition2(value);

                              setState(() {});
                            },
                            controller: editingController,
                            decoration: InputDecoration(
                              errorStyle: TextStyle(height: 0),
                              isDense: true,
                              // important line
                              contentPadding:
                                  EdgeInsets.fromLTRB(1.h, 3.5.h, 3.h, 0),
                              labelText: 'Search Delights',
                              prefixIcon: Icon(Icons.search, size: 25),
                              labelStyle: const TextStyle(
                                color: Color(0xFFDDE4E4),
                              ),
                              floatingLabelStyle:
                                  const TextStyle(color: Color(0xFFA1A8A9)),
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Color(0xFFDDE4E4), width: 1.0),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(30.sp),
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0xFFA1A8A9),
                                ),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(30.sp),
                                ),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(30.sp),
                                ),
                              ),
                            ),
                          ),
                        ),

                        // Padding(
                        //   padding: EdgeInsets.only(top: 0.1.dp, right: 0.1.dp, bottom: 0.1.dp, left: 0.1.dp,),
                        //   child:
                        //
                        //   Row(
                        //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //     children: [
                        //       Row(
                        //         crossAxisAlignment: CrossAxisAlignment.center,
                        //         children: [
                        //           Icon(
                        //             Icons.search,
                        //             size: 0.3.dp,
                        //             color: Color(0xFF616768),
                        //           ),
                        //           Text(
                        //             "Search Delights",
                        //             style: TextStyle(
                        //                 fontSize: 15.sp,
                        //                 color: Color(0xFF616768),
                        //                 fontWeight: FontWeight.w400),
                        //           ),
                        //
                        //
                        //
                        //         ],
                        //       ),
                        //       Row(
                        //         children: [
                        //           SvgPicture.asset(
                        //             'assets/images/map-pin.svg',
                        //             width: 4.w,
                        //           ),
                        //           SizedBox(
                        //             width: 2,
                        //           ),
                        //           Text(
                        //             "near me",
                        //             style: TextStyle(
                        //                 fontSize: 15.sp, color: Colors.grey),
                        //           ),
                        //         ],
                        //       ),
                        //     ],
                        //   ),
                        // ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: GestureDetector(
                      onTap: () {
                        showBootomSheet();
                      },
                      child: Container(
                        child: Container(
                          margin: EdgeInsets.only(top: 0.2.dp, bottom: 0.2.dp),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Colors.white),
                          child: Padding(
                            padding: EdgeInsets.only(
                              top: 0.2.dp,
                              right: 0.2.dp,
                              bottom: 0.2.dp,
                              left: 0.2.dp,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                SvgPicture.asset(
                                  'assets/images/km-icon.svg',
                                  width: 4.w,
                                ),
                                Text(
                                  "${_radius3}Mile",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 16.sp, color: Colors.grey),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
          Container(
            margin: EdgeInsets.only(
                left: Dimensions.size7,
                top: Dimensions.size100,
                right: Dimensions.size10,
                bottom: 0),
            height: Dimensions.size45,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: elightlistName1.length,
              itemBuilder: (context, int index) {
                return _buildItemForChips(index);
              },
            ),

            // FutureBuilder(
            //   future: showDelightList(),
            //   builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            //
            //     if(snapshot.hasData){
            //
            //       return
            //     }else{
            //
            //       return Center(child: CircularProgressIndicator());
            //     }
            //   },
            //
            // )
          ),
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.end,
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                    height: Dimensions.size170,
                    width: Dimensions.size600,
                    margin: EdgeInsets.only(
                        left: Dimensions.size7,
                        top: Dimensions.size135,
                        right: Dimensions.size10,
                        bottom: 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.end,
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        Container(
                            height: Dimensions.size150,
                            width: Dimensions.size600,
                            margin: const EdgeInsets.all(5),
                            child: ListView.builder(
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemCount: nearbyLocations1.length,
                                itemBuilder:
                                    (context, int index) => GestureDetector(
                                          onTap: () async {
                                            SharedPreferences pre =
                                                await SharedPreferences
                                                    .getInstance();
                                            pre.setString(
                                                "placeId",
                                                nearbyLocations1[index]
                                                    .placeId!);
                                            //save String
                                            Get.toNamed(
                                                RouteHelper.getdetailsScreen());
                                          },
                                          child: SingleChildScrollView(
                                            child: Container(
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                margin: const EdgeInsets.all(5),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  gradient: const LinearGradient(
                                                      begin: Alignment(
                                                          6.123234262925839e-17,
                                                          1),
                                                      end: Alignment(-1,
                                                          6.123234262925839e-17),
                                                      colors: [
                                                        Color.fromRGBO(
                                                            255, 255, 255, 255),
                                                        Color.fromRGBO(
                                                            255, 255, 255, 255),
                                                      ]),
                                                ),
                                                child: Container(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 10, right: 10),
                                                  margin: const EdgeInsets.only(
                                                    left: 0,
                                                    right: 0,
                                                    top: 0,
                                                    bottom: 10,
                                                  ),
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      2.5,
                                                  child: Card(
                                                    elevation: 5,
                                                    shadowColor: Colors.black12,
                                                    color: Colors.white,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              18),
                                                    ),
                                                    child: Row(
                                                      children: [
                                                        Expanded(
                                                            flex: 2, // 20%
                                                            child: Container(
                                                              height: 130,
                                                              decoration: BoxDecoration(
                                                                  color: Colors
                                                                      .white,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              20)),
                                                              width: 100,
                                                              margin:
                                                                  const EdgeInsets
                                                                      .only(
                                                                      top: 10,
                                                                      left: 10,
                                                                      right: 10,
                                                                      bottom:
                                                                          10),
                                                              child: ClipRRect(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            20),
                                                                // Image border
                                                                child: SizedBox
                                                                    .fromSize(
                                                                  size: const Size
                                                                      .fromRadius(
                                                                      48),
                                                                  // Image radius
                                                                  child: nearbyLocations1[index]
                                                                              .photos?[
                                                                                  0]
                                                                              .photoReference ==
                                                                          null
                                                                      ? Image
                                                                          .network(
                                                                          nearbyLocations1[index]
                                                                              .icon!,
                                                                          height:
                                                                              Dimensions.size100,
                                                                          width:
                                                                              Dimensions.size100,
                                                                        )
                                                                      : getImage(
                                                                          "${nearbyLocations1[index].photos?[0].photoReference}",
                                                                          "${nearbyLocations1[index].photos?[0].width}") /*Image.network(nearbyLocations[index].icon!,)*/,
                                                                ),
                                                              ),
                                                            )),
                                                        Expanded(
                                                            flex: 3, // 60%
                                                            child:
                                                                SingleChildScrollView(
                                                              scrollDirection:
                                                                  Axis.vertical,
                                                              child: Container(
                                                                margin:
                                                                    const EdgeInsets
                                                                        .only(
                                                                        left: 2,
                                                                        right:
                                                                            2,
                                                                        top:
                                                                            10),
                                                                child: Column(
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
                                                                          MainAxisAlignment
                                                                              .spaceBetween,
                                                                      children: [
                                                                        Expanded(
                                                                          child:
                                                                              Text(
                                                                            nearbyLocations1[index].name!,
                                                                            style: const TextStyle(
                                                                                fontSize: 14,
                                                                                color: Colors.black,
                                                                                fontWeight: FontWeight.normal),
                                                                          ),
                                                                        ),
                                                                        Container(
                                                                          height:
                                                                              30,
                                                                          child:
                                                                              TextButton(
                                                                            style:
                                                                                ButtonStyle(
                                                                              backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                                                                            ),
                                                                            onPressed:
                                                                                () {},
                                                                            child:
                                                                                Row(
                                                                              children: <Widget>[
                                                                                SvgPicture.asset(
                                                                                  'assets/images/star.svg',
                                                                                  width: 18,
                                                                                  color: const Color(0xFFF9BF3A),
                                                                                ),
                                                                                const SizedBox(
                                                                                  width: 2,
                                                                                ),
                                                                                nearbyLocations1[index].rating != null
                                                                                    ? Text(
                                                                                        nearbyLocations1[index].rating.toString(),
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
                                                                      height: 2,
                                                                    ),
                                                                    Row(
                                                                      children: [
                                                                        Text(
                                                                          nearbyLocations1[index]
                                                                              .types![0],
                                                                          overflow:
                                                                              TextOverflow.ellipsis,
                                                                          style: TextStyle(
                                                                              fontSize: 12,
                                                                              color: Colors.grey[500],
                                                                              fontWeight: FontWeight.normal),
                                                                        ),
                                                                        Text(
                                                                          "",
                                                                          overflow:
                                                                              TextOverflow.ellipsis,
                                                                          style: TextStyle(
                                                                              fontSize: 11,
                                                                              color: Colors.grey[500],
                                                                              fontWeight: FontWeight.normal),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    const SizedBox(
                                                                      height: 2,
                                                                    ),
                                                                    Row(
                                                                      children: [
                                                                        Text(
                                                                          nearbyLocations1[index].businessStatus == "OPERATIONAL"
                                                                              ? "open"
                                                                              : "close",
                                                                          overflow:
                                                                              TextOverflow.ellipsis,
                                                                          style: TextStyle(
                                                                              fontSize: 12,
                                                                              color: Colors.grey[500],
                                                                              fontWeight: FontWeight.normal),
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
                                                                          height:
                                                                              35,
                                                                          child:
                                                                              TextButton(
                                                                            style:
                                                                                ButtonStyle(
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
                                                                            onPressed:
                                                                                () {},
                                                                            child:
                                                                                Row(
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
                                                                        const SizedBox(
                                                                            width:
                                                                                10),
                                                                        Container(
                                                                          height:
                                                                              36,
                                                                          decoration:
                                                                              BoxDecoration(
                                                                            borderRadius:
                                                                                BorderRadius.circular(25),
                                                                            gradient:
                                                                                const LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [
                                                                              Color.fromRGBO(31, 203, 220, 1),
                                                                              Color.fromRGBO(0, 184, 202, 1)
                                                                            ]),
                                                                          ),
                                                                          child:
                                                                              TextButton(
                                                                            style:
                                                                                TextButton.styleFrom(
                                                                              foregroundColor: Colors.white,
                                                                              padding: const EdgeInsets.only(left: 12, right: 12, top: 5.0, bottom: 5.0),
                                                                              textStyle: const TextStyle(fontSize: 13),
                                                                            ),
                                                                            onPressed:
                                                                                () async {
                                                                              pr4.show();

                                                                              SharedPreferences pre = await SharedPreferences.getInstance();
                                                                              final islogin = pre.getBool("islogin") ?? false;
                                                                              final userId = pre.getInt("userId") ?? 0;
                                                                              final struserId = userId.toString();
                                                                              final strlat = nearbyLocations1[index].geometry?.location?.lat.toString();
                                                                              final strlng = nearbyLocations1[index].geometry?.location?.lng.toString();
                                                                              final placeid = nearbyLocations1[index].placeId!;

                                                                              http.Response response = await PinPlaces().insertPinPlaces(struserId, delightId, nearbyLocations[index].types![0], placeid, strlat!, strlng!, nearbyLocations[index].name!, "", nearbyLocations[index].vicinity!, "", "", "", "", "", "", "", "", nearbyLocations[index].photos![0].photoReference!, nearbyLocations[index].rating.toString(), "");

                                                                              print(response);

                                                                              var pinResponse = jsonDecode(response.body);
                                                                              var userResponse = PinThePlace.fromJson(pinResponse);

                                                                              if (userResponse.status == "200") {
                                                                                pr4.hide();

                                                                                Fluttertoast.showToast(msg: userResponse.message!, toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.BOTTOM, timeInSecForIosWeb: 1, backgroundColor: Colors.green, textColor: Colors.white, fontSize: 16.0);
                                                                              } else {
                                                                                pr4.hide();

                                                                                Fluttertoast.showToast(msg: userResponse.message!, toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.BOTTOM, timeInSecForIosWeb: 1, backgroundColor: Colors.green, textColor: Colors.white, fontSize: 16.0);
                                                                              }
                                                                            },
                                                                            child:
                                                                                Row(
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
                      ],
                    )),
                /* Visibility(
                      visible: isTextVisible,
                      child: Center(
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          height: Dimensions.size35,
                          width: Dimensions.screenWidth,
                          margin: EdgeInsets.only(left: 30, right: 30, top: 20),
                          decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          child: Text(
                            "You might be interested in",
                            textAlign: TextAlign.center,
                            style:
                                TextStyle(fontSize: 15, fontFamily: 'Poppins'),
                          ),
                        ),
                      ),
                    ),*/
                Container(
                    height: Dimensions.size160,
                    width: Dimensions.size600,
                    margin: EdgeInsets.only(
                        left: Dimensions.size7,
                        right: Dimensions.size10,
                        bottom: Dimensions.size40),
                    child: nearbyLocations.isNotEmpty
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.end,
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              Container(
                                  height: Dimensions.size150,
                                  width: Dimensions.size600,
                                  margin: const EdgeInsets.all(5),
                                  child: ListView.builder(
                                      shrinkWrap: true,
                                      scrollDirection: Axis.horizontal,
                                      itemCount: nearbyLocations.length,
                                      itemBuilder:
                                          (context, int index) =>
                                              GestureDetector(
                                                onTap: () async {
                                                  SharedPreferences pre =
                                                      await SharedPreferences
                                                          .getInstance();
                                                  pre.setString(
                                                      "placeId",
                                                      nearbyLocations[index]
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
                                                          const EdgeInsets.all(
                                                              5),
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        gradient: const LinearGradient(
                                                            begin: Alignment(
                                                                6.123234262925839e-17,
                                                                1),
                                                            end: Alignment(-1,
                                                                6.123234262925839e-17),
                                                            colors: [
                                                              Color.fromRGBO(
                                                                  255,
                                                                  255,
                                                                  255,
                                                                  255),
                                                              Color.fromRGBO(
                                                                  255,
                                                                  255,
                                                                  255,
                                                                  255),
                                                            ]),
                                                      ),
                                                      child: Container(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                                left: 10,
                                                                right: 10),
                                                        margin: const EdgeInsets
                                                            .only(
                                                          left: 0,
                                                          right: 0,
                                                          top: 0,
                                                          bottom: 10,
                                                        ),
                                                        width: MediaQuery.of(
                                                                context)
                                                            .size
                                                            .width,
                                                        height: MediaQuery.of(
                                                                    context)
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
                                                                    .circular(
                                                                        18),
                                                          ),
                                                          child: Row(
                                                            children: [
                                                              Expanded(
                                                                  flex:
                                                                      2, // 20%
                                                                  child:
                                                                      Container(
                                                                    height: 130,
                                                                    decoration: BoxDecoration(
                                                                        color: Colors
                                                                            .white,
                                                                        borderRadius:
                                                                            BorderRadius.circular(20)),
                                                                    width: 100,
                                                                    margin: const EdgeInsets
                                                                        .only(
                                                                        top: 10,
                                                                        left:
                                                                            10,
                                                                        right:
                                                                            10,
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
                                                                        child: nearbyLocations[index].photos?[0].photoReference ==
                                                                                null
                                                                            ? Image
                                                                                .network(
                                                                                nearbyLocations[index].icon!,
                                                                                height: Dimensions.size100,
                                                                                width: Dimensions.size100,
                                                                              )
                                                                            : getImage("${nearbyLocations[index].photos?[0].photoReference}",
                                                                                "${nearbyLocations[index].photos?[0].width}") /*Image.network(nearbyLocations[index].icon!,)*/,
                                                                      ),
                                                                    ),
                                                                  )),
                                                              Expanded(
                                                                  flex:
                                                                      3, // 60%
                                                                  child:
                                                                      SingleChildScrollView(
                                                                    scrollDirection:
                                                                        Axis.vertical,
                                                                    child:
                                                                        Container(
                                                                      margin: const EdgeInsets
                                                                          .only(
                                                                          left:
                                                                              2,
                                                                          right:
                                                                              2,
                                                                          top:
                                                                              10),
                                                                      child:
                                                                          Column(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.start,
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.start,
                                                                        mainAxisSize:
                                                                            MainAxisSize.max,
                                                                        children: [
                                                                          Row(
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.spaceBetween,
                                                                            children: [
                                                                              Expanded(
                                                                                child: Text(
                                                                                  nearbyLocations[index].name!,
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
                                                                                      nearbyLocations[index].rating != null
                                                                                          ? Text(
                                                                                              nearbyLocations[index].rating.toString(),
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
                                                                                nearbyLocations[index].types![0],
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
                                                                                nearbyLocations[index].businessStatus == "OPERATIONAL" ? "open" : "close",
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
                                                                                    pr4.show();

                                                                                    SharedPreferences pre = await SharedPreferences.getInstance();
                                                                                    final islogin = pre.getBool("islogin") ?? false;
                                                                                    final userId = pre.getInt("userId") ?? 0;
                                                                                    final struserId = userId.toString();
                                                                                    final strlat = nearbyLocations[index].geometry?.location?.lat.toString();
                                                                                    final strlng = nearbyLocations[index].geometry?.location?.lng.toString();
                                                                                    final placeid = nearbyLocations[index].placeId!;

                                                                                    http.Response response = await PinPlaces().insertPinPlaces(struserId, delightId, nearbyLocations[index].types![0], placeid, strlat!, strlng!, nearbyLocations[index].name!, "", nearbyLocations[index].vicinity!, "", "", "", "", "", "", "", "", nearbyLocations[index].photos![0].photoReference!, nearbyLocations[index].rating.toString(), "");

                                                                                    print(response);

                                                                                    var pinResponse = jsonDecode(response.body);
                                                                                    var userResponse = PinThePlace.fromJson(pinResponse);

                                                                                    if (userResponse.status == "200") {
                                                                                      pr4.hide();

                                                                                      Fluttertoast.showToast(msg: userResponse.message!, toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.BOTTOM, timeInSecForIosWeb: 1, backgroundColor: Colors.green, textColor: Colors.white, fontSize: 16.0);
                                                                                    } else {
                                                                                      pr4.hide();

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
                            ],
                          )
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
                                      "$kename  List Not Found",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 23.sp,
                                          fontFamily: 'Poppins'),
                                    ),
                                  );
                                }))))
              ],
            ),
          ),
          Visibility(
            visible: isTextVisible,
            child: Container(
              margin: EdgeInsets.all(5),
              child: Align(
                alignment: Alignment.bottomRight,
                child: FloatingActionButton.extended(
                  onPressed: () {
                    _determinePosition1();
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('You might be interested in'),
                            content: setupAlertDialoadContainer(),
                          );
                        });
                  },
                  elevation: 10,
                  label: Text('Recommend'),
                  hoverColor: Colors.lightBlueAccent,
                ),
              ),
            ),
          )
        ],
      ),
    ));
  }

  Set<Marker> getmarkers() {
    //markers to place on map
    setState(() {
      markers.add(Marker(
        //add first marker
        markerId: MarkerId(_center.toString()),
        position: _center, //position of marker
        infoWindow: const InfoWindow(
          //popup info
          title: 'Marker Title First ',
          snippet: 'My Custom Subtitle',
        ),
        icon: BitmapDescriptor.defaultMarker, //Icon for Marker
      ));

      markers.add(Marker(
        //add second marker
        markerId: MarkerId(_center.toString()),
        position: const LatLng(27.7099116, 85.3132343), //position of marker
        infoWindow: const InfoWindow(
          //popup info
          title: 'Marker Title Second ',
          snippet: 'My Custom Subtitle',
        ),
        icon: BitmapDescriptor.defaultMarker, //Icon for Marker
      ));

      markers.add(Marker(
        //add third marker
        markerId: MarkerId(_center.toString()),
        position: const LatLng(27.7137735, 85.315626), //position of marker
        infoWindow: const InfoWindow(
          //popup info
          title: 'Marker Title Third ',
          snippet: 'My Custom Subtitle',
        ),
        icon: BitmapDescriptor.defaultMarker, //Icon for Marker
      ));

      //add more markers here
    });

    return markers;
  }

  Widget _buildItemForChips(int index) {
    return GestureDetector(
      onTap: () {
        // checknow(searchKeywords[index]['name']!);
        setState(() {
          curIndex = index;
          kename = elightlistName1[index].delightName!;
          delight_Id = elightlistName1[index].id!;
          delightId = delight_Id.toString();
          nearbyLocations1.clear();
          editingController.text = "";

          // _determinePosition("food",_radius2);

          //   "Family & Kids",
          //   "Music",
          // "Adventure",

          if (kename == "Restaurant") {
            _determinePosition("restaurant|food", _radius2);
            kenameType = "restaurant|food";
          } else if (kename == "Bar") {
            _determinePosition("bar|night_club", _radius2);
            kenameType = "bar";
          } else if (kename == "Shopping") {
            _determinePosition("shopping_mall", _radius2);
            kenameType = "shopping_mall";
          } else if (kename == "Museum") {
            _determinePosition("museum", _radius2);
            kenameType = "museum";
          } else if (kename == "Health & Fitness") {
            _determinePosition("health|gym|hospital|doctor", _radius2);
            kenameType = "health|gym|hospital|doctor";
          } else if (kename == "Park") {
            _determinePosition("park|amusement_park", _radius2);
            kenameType = "park|amusement_park";
          } else if (kename == "Sports") {
            _determinePosition("shoe_store|store", _radius2);
            kenameType = "shoe_store|store";
          } else if (kename == "Films") {
            _determinePosition("movie_theater", _radius2);
            kenameType = "movie_theater";
          } else if (kename == "Event") {
            _determinePosition("event", _radius2);
            kenameType = "event";
          } else if (kename == "Music") {
            _determinePosition("night_club", _radius2);
            kenameType = "night_club";
          } else if (kename == "Adventure") {
            _determinePosition(
                "aquarium|art_gallery|tourist_attraction", _radius2);
            kenameType = "aquarium|art_gallery|tourist_attraction";
          }

          //  _determinePosition(kename);

          Fluttertoast.showToast(
              msg: kename,
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.green,
              textColor: Colors.white,
              fontSize: 16.0);

          // KeyWord_formarker = KeyWord_formarker_chips;
        });
        //searchNow(searchKeywords[index]['name']!);
      },
      child: Container(
        margin: const EdgeInsets.only(
          left: 8,
          top: 3,
          right: 0,
          bottom: 8,
        ),
        decoration: BoxDecoration(
          boxShadow: [
            const BoxShadow(
              color: Color(0xD000000), //New
              blurRadius: 12.0,
            )
          ],
          gradient: curIndex == index
              ? const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFF1FCBDC),
                    Color(0xFF00B8CA),
                  ],
                )
              : const LinearGradient(
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

  String appToStringAsFixed(double number, int afterDecimal) {
    return '${number.toString().split('.')[0]}.${number.toString().split('.')[1].substring(0, afterDecimal)}';
  }

  void showBootomSheet() {
    Future<void> future = showModalBottomSheet<void>(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
        top: Radius.circular(20),
      )),
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(builder:
            (BuildContext context, void Function(void Function()) setState) {
          return Container(
            color: Colors.transparent,
            height: 300,
            child: Container(
              padding: const EdgeInsets.only(
                left: 0.0,
                right: 0.0,
                top: 10.0,
                bottom: 10.0,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                // mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding: const EdgeInsets.only(
                      left: 18.0,
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
                                size: 22.0,
                              ),
                              onPressed: () {
                                Navigator.of(context).pop();
                              }),
                        ),
                        const SizedBox(
                          width: 4,
                        ),
                        const Text(
                          'Select search radius',
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 17),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    padding: const EdgeInsets.only(
                      left: 22.0,
                      right: 22.0,
                      top: 0.0,
                      bottom: 0.0,
                    ),
                    child: const Text(
                      "We will suggest delights within this radius from your current location. ",
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF616768),
                        fontSize: 14,
                        height: 1.4,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Container(
                    padding: const EdgeInsets.only(
                      left: 0.0,
                      right: 0.0,
                      top: 0.0,
                      bottom: 0.0,
                    ),
                    margin: const EdgeInsets.all(0),
                    width: MediaQuery.of(context).size.width * 1.0,
                    child: Slider(
                      value: _radius,
                      max: 50.0,
                      divisions: 10,
                      label: _radius.round().toString(),
                      activeColor: Colors.cyan,
                      inactiveColor: Colors.grey,
                      onChanged: (double value) {
                        setState(() {
                          _radius = value;
                          _radius3 = _radius.toString();
                        });
                      },
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(
                      left: 0.0,
                      right: 0.0,
                      top: 15.0,
                      bottom: 0.0,
                    ),
                    padding: const EdgeInsets.only(
                      left: 22.0,
                      right: 22.0,
                      top: 0.0,
                      bottom: 0.0,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: Dimensions.size50,
                              width: Dimensions.size100,
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.white,
                                  ),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(13))),
                              child: Text(
                                _radius3,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontWeight: FontWeight.normal,
                                  fontSize: 16,
                                  height: 1.7,
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            const Text(
                              "mile",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontWeight: FontWeight.normal,
                                fontSize: 16,
                                color: Color(0xFF616768),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        TextButton(
                            style: ButtonStyle(
                              padding: MaterialStateProperty.all<EdgeInsets>(
                                  const EdgeInsets.only(
                                left: 50.0,
                                right: 50.0,
                                top: 12.0,
                                bottom: 12.0,
                              )),
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  const Color(0x10000000)),
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.0),
                              )),
                            ),
                            child: const Text(
                              'Done',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                  color: Colors.cyan),
                            ),
                            onPressed: () async {
                              Navigator.pop(context, _radius3);

                              var radius2 = double.parse(_radius1);
                              var radius3 = _radius * kmMiles_d;
                              var radious4 = radius3.toString();

                              print("Your kilometer $_radius");

                              SharedPreferences pre =
                                  await SharedPreferences.getInstance();
                              pre.setDouble("radiusData", _radius);

                              print("dataradius$radius3");

                              if (0 <= radius3 && radius3 <= 5) {
                                _determinePosition(kenameType, "500");
                                setRadiousData("500");
                              } else if (5 <= radius3 && radius3 <= 10) {
                                _determinePosition(kenameType, "1000");
                                setRadiousData("1000");
                              } else if (10 <= radius3 && radius3 <= 15) {
                                _determinePosition(kenameType, "1500");
                                setRadiousData("1500");
                              } else if (15 <= radius3 && radius3 <= 20) {
                                _determinePosition(kenameType, "2000");
                                setRadiousData("2000");
                              } else if (20 <= radius3 && radius3 <= 25) {
                                _determinePosition(kenameType, "2500");
                                setRadiousData("2500");
                              } else if (25 <= radius3 && radius3 <= 30) {
                                _determinePosition(kenameType, "3000");
                                setRadiousData("3000");
                              } else if (30 <= radius3 && radius3 <= 35) {
                                _determinePosition(kenameType, "3500");
                                setRadiousData("3500");
                              } else if (35 <= radius3 && radius3 <= 40) {
                                _determinePosition(kenameType, "4000");
                                setRadiousData("4000");
                              } else if (40 <= radius3 && radius3 <= 45) {
                                _determinePosition(kenameType, "4500");
                                setRadiousData("4500");
                              } else if (45 <= radius3 && radius3 <= 50) {
                                _determinePosition(kenameType, "5000");
                                setRadiousData("5000");
                              }
                            })
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
      },
    ).whenComplete(() {
      setState(() {});
    });
    future.then((void value) => _closeModal(value));
  }

  void _closeModal(void value) {
    print('modal closed');
  }

  void getNearbyPlaces(double latitude, double longitude, String radius) async {
    // var url = Uri.parse('https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=' + latitude.toString() + ',' + longitude.toString() + '&radius=' + radius + '&key=' + apikey);

    ViewDialog(context: context)
        .showLoadingIndicator("View Details Wait...", "", context);

    var url = Uri.parse(
        'https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=$latitude,$longitude&radius=$radius&key=$googleApikey');
    var response = await http.get(url);
    nearByplaces = NearByplaces.fromJson(jsonDecode(response.body));

    nearbyLocations.clear();

    if (nearByplaces.results != null) {
      for (int i = 0; i < nearByplaces.results!.length; i++) {
        nearbyLocations.add(nearByplaces.results![i]);
      }
    }

    kename = "";
    curIndex = -1;
    isVisible = true;

    ViewDialog(context: context).hideOpenDialog();

    //  totalDistance += calculateDistance(data[i]["lat"], data[i]["lng"], data[i+1]["lat"], data[i+1]["lng"]);

    //displayPrediction();

    setState(() {});

    //"https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=-33.8670522%2C151.1957362&radius=1500&type=restaurant&keyword=cruise&key=YOUR_API_KEY"
  }

  void getNearbyPlaces1(
      double latitude, double longitude, String radius, String typelist) async {
    // var url = Uri.parse('https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=' + latitude.toString() + ',' + longitude.toString() + '&radius=' + radius + '&key=' + apikey);

    var url = Uri.parse(
        'https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=$latitude,$longitude&radius=$radius&type=$typelist&keyword=$typelist&key=$googleApikey');
    var response = await http.get(url);
    nearByplaces = NearByplaces.fromJson(jsonDecode(response.body));

    nearbyLocations.clear();

    if (nearByplaces.results != null) {
      for (int i = 0; i < nearByplaces.results!.length; i++) {
        nearbyLocations.add(nearByplaces.results![i]);
      }
    }

    // displayPrediction();

    isVisible = true;
    ViewDialog(context: context).hideOpenDialog();

    setState(() {});

    // "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=-33.8670522%2C151.1957362&radius=1500&type=restaurant&keyword=cruise&key=YOUR_API_KEY"
  }

  void getNearbyPlaces2(
      double latitude, double longitude, String radius, String typelist) async {
    // var url = Uri.parse('https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=' + latitude.toString() + ',' + longitude.toString() + '&radius=' + radius + '&key=' + apikey);

    var url = Uri.parse(
        'https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=$latitude,$longitude&radius=$radius&type=$typelist&keyword=$typelist&key=$googleApikey');
    var response = await http.get(url);
    nearByplaces = NearByplaces.fromJson(jsonDecode(response.body));

    //nearbyLocations.clear();

    if (nearByplaces.results != null) {
      for (int i = 0; i < nearByplaces.results!.length; i++) {
        nearbyLocations.add(nearByplaces.results![i]);
      }
    }

    // displayPrediction();

    isVisible = true;
    // ViewDialog(context: context).hideOpenDialog();

    setState(() {});

    // "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=-33.8670522%2C151.1957362&radius=1500&type=restaurant&keyword=cruise&key=YOUR_API_KEY"
  }

  void getNearbyPlaces3(
      String value, double latitude, double longitude, String radius) async {
    // var url = Uri.parse('https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=' + latitude.toString() + ',' + longitude.toString() + '&radius=' + radius + '&key=' + apikey);

    var url = Uri.parse(
        'https://maps.googleapis.com/maps/api/place/textsearch/json?query=$value&location=$latitude,$longitude&radius=1000&key=AIzaSyAuFYxq-RX0I1boI5HU5-olArirEi2Ez8k');
    var response = await http.get(url);
    nearByplaces = NearByplaces.fromJson(jsonDecode(response.body));

    nearbyLocations1.clear();
    nearbyLocations.clear();

    if (nearByplaces.results != null) {
      for (int i = 0; i < nearByplaces.results!.length; i++) {
        // nearbyLocations.add(nearByplaces.results![i]);
        nearbyLocations1.add(nearByplaces.results![i]);
      }
    }
    isVisible = true;
    isTextVisible = true;
    setState(() {});
  }

  Widget nearByPlacesWidget(Results? result) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Container(
        width: MediaQuery.of(context).size.width,
        margin: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          boxShadow: [
            const BoxShadow(
              color: Colors.white,
              blurRadius: 10,
              spreadRadius: 10,
              offset: Offset(0, 15),
            ),
          ],
          borderRadius: BorderRadius.circular(10),
          gradient: const LinearGradient(
              begin: Alignment(6.123234262925839e-17, 1),
              end: Alignment(-1, 6.123234262925839e-17),
              colors: [
                Color.fromRGBO(255, 255, 255, 1.0),
                Color.fromRGBO(255, 255, 255, 1.0),
              ]),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height * 0.15,
              alignment: Alignment.center,
              margin: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                gradient: const LinearGradient(colors: [
                  Color.fromRGBO(255, 255, 255, 1.0),
                  Color.fromRGBO(255, 255, 255, 1.0),
                ]),
              ),
              child: getImage("${result?.photos?[0].photoReference}",
                  "${result?.photos?[0].width}") /* result!.photos?[0].photoReference == null
                  ? Image.network(result.icon!, height: 100, width: 100,)
                  : getImage("${result.photos?[0].photoReference}")*/
              ,
            ),
            Container(
              width: Dimensions.size225,
              padding: const EdgeInsets.all(5),
              margin: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                gradient: const LinearGradient(colors: [
                  Color.fromRGBO(255, 255, 255, 1.0),
                  Color.fromRGBO(255, 255, 255, 1.0),
                ]),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(1),
                    //apply padding to all four sides
                    child: Text(
                      "${result!.name!}",
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(1),
                    //apply padding to all four sides
                    child: Text(result.openingHours != null ? "open" : "close"),
                  ),
                  Padding(
                      padding: const EdgeInsets.all(1),
                      //apply padding to all four sides
                      child: result.rating == null
                          ? const Text("")
                          : Row(
                              children: [
                                RatingBarIndicator(
                                  rating:
                                      double.parse(result.rating.toString()),
                                  itemBuilder: (context, index) => const Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                  ),
                                  itemCount: 5,
                                  itemSize: 20.0,
                                  direction: Axis.horizontal,
                                ),
                                Text(
                                    "${"" + "(" + result.rating!.toString()})"),
                              ],
                            )),
                  Padding(
                    padding: const EdgeInsets.all(1),
                    //apply padding to all four sides
                    child: Text(
                      "${result.vicinity!}",
                    ),
                  ),

                  /* Padding(
                  padding: EdgeInsets.all(2), //apply padding to all four sides
                  child: Text(address),
                ),*/
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<Position> _determinePosition(String kename, String radius) async {
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

    ViewDialog(context: context)
        .showLoadingIndicator("View Details Wait...", "", context);

    Position position = await Geolocator.getCurrentPosition();

    //_getAddressFromLatLng(position);

    double latitude1 = position.latitude;
    double longitude1 = position.longitude;

    if (kename == "") {
      getNearbyPlaces(latitude1, longitude1, radius);
    } else {
      getNearbyPlaces1(latitude1, longitude1, radius, kename);
    }

    if (kDebugMode) {
      print("latitudedetails $latitude1");
      print("latitudedetails $longitude1");
    }

    if (kDebugMode) {
      print(radius + kename);
    }

    return position;
  }

  Set<Marker> displayPrediction() {
    marker.clear();

    if (nearbyLocations.isNotEmpty) {
      for (int i = 0; i < nearbyLocations.length; i++) {
        setState(() {
          marker.add(Marker(
              markerId: MarkerId(nearbyLocations[i].placeId!),
              position: LatLng(nearbyLocations[i].geometry!.location!.lat!,
                  nearbyLocations[i].geometry!.location!.lng!),
              infoWindow: InfoWindow(
                  title: nearbyLocations[i]
                      .name! /*, snippet: nearbyLocations[i].vicinity*/)));
          googleMapController.animateCamera(CameraUpdate.newLatLngZoom(
              LatLng(nearbyLocations[i].geometry!.location!.lat!,
                  nearbyLocations[i].geometry!.location!.lng!),
              14.0));
        });
      }
    } else {
      marker.clear();
    }
    return marker;
  }

  double calculateDistance(lat1, lon1, lat2, lon2) {
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 -
        c((lat2 - lat1) * p) / 2 +
        c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a));
  }

  // Future<void> _getAddressFromLatLng(Position position) async {
  //   await placemarkFromCoordinates(position.latitude, position.longitude)
  //       .then((List<Placemark> placemarks) {
  //     Placemark place = placemarks[0];
  //     setState(() {
  //       _currentAddress =
  //       '${place.street}, ${place.subLocality}, ${place.subAdministrativeArea}, ${place.postalCode}';
  //
  //       Fluttertoast.showToast(
  //           msg: _currentAddress!,
  //           toastLength: Toast.LENGTH_SHORT,
  //           gravity: ToastGravity.BOTTOM,
  //           timeInSecForIosWeb: 1,
  //           backgroundColor: Colors.green,
  //           textColor: Colors.white,
  //           fontSize: 16.0
  //       );
  //
  //     });
  //   }).catchError((e) {
  //     debugPrint(e);
  //   });
  //
  //   setState(() {});
  // }

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

  void Left_indicator_bar_Flushbar(BuildContext context, String Message) {
    Flushbar(
      message: Message,
      icon: Icon(
        Icons.info_outline,
        size: 28.0,
        color: Colors.blue[300],
      ),
      duration: const Duration(seconds: 3),
      leftBarIndicatorColor: Colors.red[300],
    )..show(context);
  }

  Future<void> setRadiousData(String Radius) async {
    String strUserid = userId.toString();

    http.Response response = await AddKMRadius().addkmRadius(strUserid, Radius);
    var jsonResponse = jsonDecode(response.body);
    var userResponse = SuccessResponseKM.fromJson(jsonResponse);

    if (userResponse.status == "success") {
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
  }

  Future<Position> _determinePosition2(String userValue) async {
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

    double latitude1 = position.latitude;
    double longitude1 = position.longitude;
    String radius = "10000";

    getNearbyPlaces3(userValue, latitude1, longitude1, radius);

    setState(() {});

    return position;
  }

  Widget setupAlertDialoadContainer() {
    return Container(
      height: 300.0, // Change as per your requirement
      width: 300.0, // Change as per your requirement
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: 5,
        itemBuilder: (BuildContext context, int index) {
          return Container(
              height: Dimensions.size160,
              width: Dimensions.size600,
              margin: EdgeInsets.only(
                  left: Dimensions.size7,
                  right: Dimensions.size10,
                  bottom: Dimensions.size40),
              child: nearbyLocations.isNotEmpty
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.end,
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        Container(
                            height: Dimensions.size150,
                            width: Dimensions.size600,
                            margin: const EdgeInsets.all(5),
                            child: ListView.builder(
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemCount: nearbyLocations.length,
                                itemBuilder:
                                    (context, int index) => GestureDetector(
                                          onTap: () async {
                                            SharedPreferences pre =
                                                await SharedPreferences
                                                    .getInstance();
                                            pre.setString(
                                                "placeId",
                                                nearbyLocations[index]
                                                    .placeId!);
                                            //save String
                                            Get.toNamed(
                                                RouteHelper.getdetailsScreen());
                                          },
                                          child: SingleChildScrollView(
                                            child: Container(
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                margin: const EdgeInsets.all(5),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  gradient: const LinearGradient(
                                                      begin: Alignment(
                                                          6.123234262925839e-17,
                                                          1),
                                                      end: Alignment(-1,
                                                          6.123234262925839e-17),
                                                      colors: [
                                                        Color.fromRGBO(
                                                            255, 255, 255, 255),
                                                        Color.fromRGBO(
                                                            255, 255, 255, 255),
                                                      ]),
                                                ),
                                                child: Container(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 10, right: 10),
                                                  margin: const EdgeInsets.only(
                                                    left: 0,
                                                    right: 0,
                                                    top: 0,
                                                    bottom: 10,
                                                  ),
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      2.5,
                                                  child: Card(
                                                    elevation: 5,
                                                    shadowColor: Colors.black12,
                                                    color: Colors.white,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              18),
                                                    ),
                                                    child: Row(
                                                      children: [
                                                        Expanded(
                                                            flex: 2, // 20%
                                                            child: Container(
                                                              height: 130,
                                                              decoration: BoxDecoration(
                                                                  color: Colors
                                                                      .white,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              20)),
                                                              width: 100,
                                                              margin:
                                                                  const EdgeInsets
                                                                      .only(
                                                                      top: 10,
                                                                      left: 10,
                                                                      right: 10,
                                                                      bottom:
                                                                          10),
                                                              child: ClipRRect(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            20),
                                                                // Image border
                                                                child: SizedBox
                                                                    .fromSize(
                                                                  size: const Size
                                                                      .fromRadius(
                                                                      48),
                                                                  // Image radius
                                                                  child: nearbyLocations[index]
                                                                              .photos?[
                                                                                  0]
                                                                              .photoReference ==
                                                                          null
                                                                      ? Image
                                                                          .network(
                                                                          nearbyLocations[index]
                                                                              .icon!,
                                                                          height:
                                                                              Dimensions.size100,
                                                                          width:
                                                                              Dimensions.size100,
                                                                        )
                                                                      : getImage(
                                                                          "${nearbyLocations[index].photos?[0].photoReference}",
                                                                          "${nearbyLocations[index].photos?[0].width}") /*Image.network(nearbyLocations[index].icon!,)*/,
                                                                ),
                                                              ),
                                                            )),
                                                        Expanded(
                                                            flex: 3, // 60%
                                                            child:
                                                                SingleChildScrollView(
                                                              scrollDirection:
                                                                  Axis.vertical,
                                                              child: Container(
                                                                margin:
                                                                    const EdgeInsets
                                                                        .only(
                                                                        left: 2,
                                                                        right:
                                                                            2,
                                                                        top:
                                                                            10),
                                                                child: Column(
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
                                                                          MainAxisAlignment
                                                                              .spaceBetween,
                                                                      children: [
                                                                        Expanded(
                                                                          child:
                                                                              Text(
                                                                            nearbyLocations[index].name!,
                                                                            style: const TextStyle(
                                                                                fontSize: 14,
                                                                                color: Colors.black,
                                                                                fontWeight: FontWeight.normal),
                                                                          ),
                                                                        ),
                                                                        Container(
                                                                          height:
                                                                              30,
                                                                          child:
                                                                              TextButton(
                                                                            style:
                                                                                ButtonStyle(
                                                                              backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                                                                            ),
                                                                            onPressed:
                                                                                () {},
                                                                            child:
                                                                                Row(
                                                                              children: <Widget>[
                                                                                SvgPicture.asset(
                                                                                  'assets/images/star.svg',
                                                                                  width: 18,
                                                                                  color: const Color(0xFFF9BF3A),
                                                                                ),
                                                                                const SizedBox(
                                                                                  width: 2,
                                                                                ),
                                                                                nearbyLocations[index].rating != null
                                                                                    ? Text(
                                                                                        nearbyLocations[index].rating.toString(),
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
                                                                      height: 2,
                                                                    ),
                                                                    Row(
                                                                      children: [
                                                                        Text(
                                                                          nearbyLocations[index]
                                                                              .types![0],
                                                                          overflow:
                                                                              TextOverflow.ellipsis,
                                                                          style: TextStyle(
                                                                              fontSize: 12,
                                                                              color: Colors.grey[500],
                                                                              fontWeight: FontWeight.normal),
                                                                        ),
                                                                        Text(
                                                                          "",
                                                                          overflow:
                                                                              TextOverflow.ellipsis,
                                                                          style: TextStyle(
                                                                              fontSize: 11,
                                                                              color: Colors.grey[500],
                                                                              fontWeight: FontWeight.normal),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    const SizedBox(
                                                                      height: 2,
                                                                    ),
                                                                    Row(
                                                                      children: [
                                                                        Text(
                                                                          nearbyLocations[index].businessStatus == "OPERATIONAL"
                                                                              ? "open"
                                                                              : "close",
                                                                          overflow:
                                                                              TextOverflow.ellipsis,
                                                                          style: TextStyle(
                                                                              fontSize: 12,
                                                                              color: Colors.grey[500],
                                                                              fontWeight: FontWeight.normal),
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
                                                                          height:
                                                                              35,
                                                                          child:
                                                                              TextButton(
                                                                            style:
                                                                                ButtonStyle(
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
                                                                            onPressed:
                                                                                () {},
                                                                            child:
                                                                                Row(
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
                                                                        const SizedBox(
                                                                            width:
                                                                                10),
                                                                        Container(
                                                                          height:
                                                                              36,
                                                                          decoration:
                                                                              BoxDecoration(
                                                                            borderRadius:
                                                                                BorderRadius.circular(25),
                                                                            gradient:
                                                                                const LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [
                                                                              Color.fromRGBO(31, 203, 220, 1),
                                                                              Color.fromRGBO(0, 184, 202, 1)
                                                                            ]),
                                                                          ),
                                                                          child:
                                                                              TextButton(
                                                                            style:
                                                                                TextButton.styleFrom(
                                                                              foregroundColor: Colors.white,
                                                                              padding: const EdgeInsets.only(left: 12, right: 12, top: 5.0, bottom: 5.0),
                                                                              textStyle: const TextStyle(fontSize: 13),
                                                                            ),
                                                                            onPressed:
                                                                                () async {
                                                                              ViewDialog(context: context).showLoadingIndicator("Pin Your Location Wait...", "", context);

                                                                              SharedPreferences pre = await SharedPreferences.getInstance();
                                                                              final islogin = pre.getBool("islogin") ?? false;
                                                                              final userId = pre.getInt("userId") ?? 0;
                                                                              final struserId = userId.toString();
                                                                              final strlat = nearbyLocations[index].geometry?.location?.lat.toString();
                                                                              final strlng = nearbyLocations[index].geometry?.location?.lng.toString();
                                                                              final placeid = nearbyLocations[index].placeId!;

                                                                              http.Response response = await PinPlaces().insertPinPlaces(struserId, delightId, nearbyLocations[index].types![0], placeid, strlat!, strlng!, nearbyLocations[index].name!, "", nearbyLocations[index].vicinity!, "", "", "", "", "", "", "", "", nearbyLocations[index].photos![0].photoReference!, nearbyLocations[index].rating.toString(), "");

                                                                              print(response);

                                                                              var pinResponse = jsonDecode(response.body);
                                                                              var userResponse = PinThePlace.fromJson(pinResponse);

                                                                              if (userResponse.status == "200") {
                                                                                ViewDialog(context: context).hideOpenDialog();

                                                                                Fluttertoast.showToast(msg: userResponse.message!, toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.BOTTOM, timeInSecForIosWeb: 1, backgroundColor: Colors.green, textColor: Colors.white, fontSize: 16.0);
                                                                              } else {
                                                                                ViewDialog(context: context).hideOpenDialog();

                                                                                Fluttertoast.showToast(msg: userResponse.message!, toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.BOTTOM, timeInSecForIosWeb: 1, backgroundColor: Colors.green, textColor: Colors.white, fontSize: 16.0);
                                                                              }
                                                                            },
                                                                            child:
                                                                                Row(
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
                      ],
                    )
                  : Visibility(
                      visible: isVisible,
                      child: Align(
                          alignment: Alignment.bottomCenter,
                          child: ResponsiveSizer(
                              builder: (context, orientation, screenType) {
                            return Container(
                              padding: const EdgeInsets.all(10),
                              height: 25.h,
                              width: 100.w,
                              margin: EdgeInsets.all(0.5.dp),
                              decoration: const BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              child: Text(
                                "$kename  List Not Found",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 23.sp, fontFamily: 'Poppins'),
                              ),
                            );
                          }))));
        },
      ),
    );
  }
}
