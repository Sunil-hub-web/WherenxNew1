import 'dart:async';

import 'package:flutter/material.dart';
import 'package:custom_info_window/custom_info_window.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:wherenxnew1/Dimension.dart';
import 'package:flutter_google_places_hoc081098/flutter_google_places_hoc081098.dart';
import 'package:google_api_headers/google_api_headers.dart';
import 'package:google_maps_webservice/places.dart';

import '../Routes/RouteHelper.dart';

class ExploreOnScreen extends StatefulWidget {
  const ExploreOnScreen({Key? key}) : super(key: key);

  @override
  State<ExploreOnScreen> createState() => _ExploreOnScreenState();
}

class _ExploreOnScreenState extends State<ExploreOnScreen> {
  CustomInfoWindowController _customInfoWindowController =
      CustomInfoWindowController();
  final Set<Marker> markers = Set(); //markers for google map
  String style =
      '  [{"elementType":"geometry","stylers":[{"color":"#f5f5f5"}]},{"elementType":"labels.icon","stylers":[{"visibility":"off"}]},{"elementType":"labels.text.fill","stylers":[{"color":"#616161"}]},{"elementType":"labels.text.stroke","stylers":[{"color":"#f5f5f5"}]},{"featureType":"administrative.land_parcel","elementType":"labels.text.fill","stylers":[{"color":"#bdbdbd"}]},{"featureType":"poi","elementType":"geometry","stylers":[{"color":"#eeeeee"}]},{"featureType":"poi","elementType":"labels.text.fill","stylers":[{"color":"#757575"}]},{"featureType":"poi.park","elementType":"geometry","stylers":[{"color":"#e5e5e5"}]},{"featureType":"poi.park","elementType":"labels.text.fill","stylers":[{"color":"#9e9e9e"}]},{"featureType":"road","elementType":"geometry","stylers":[{"color":"#ffffff"}]},{"featureType":"road.arterial","elementType":"labels.text.fill","stylers":[{"color":"#757575"}]},{"featureType":"road.highway","elementType":"geometry","stylers":[{"color":"#dadada"}]},{"featureType":"road.highway","elementType":"labels.text.fill","stylers":[{"color":"#616161"}]},{"featureType":"road.local","elementType":"labels.text.fill","stylers":[{"color":"#9e9e9e"}]},{"featureType":"transit.line","elementType":"geometry","stylers":[{"color":"#e5e5e5"}]},{"featureType":"transit.station","elementType":"geometry","stylers":[{"color":"#eeeeee"}]},{"featureType":"water","elementType":"geometry","stylers":[{"color":"#c9c9c9"}]},{"featureType":"water","elementType":"labels.text.fill","stylers":[{"color":"#9e9e9e"}]}]   ';
  List<Marker> _markers = <Marker>[];
  late final List<LatLng> _latlang = <LatLng>[
    const LatLng(37.8040512, -122.2731983),
    const LatLng(37.8034709, -122.2795151),
    const LatLng(37.8034709, -122.2795151),
    const LatLng(37.8018137, -122.2827713),
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
  bool tap = false;
  double _radius = 0;
  int curIndex = 0;
  String googleApikey = "AIzaSyAuFYxq-RX0I1boI5HU5-olArirEi2Ez8k";
//  String googleApikey = "AIzaSyAoollgblF-CE65JzcVrjS_aFuJnC3XPF0";
  String locationString = "Search delights";

  //late BitmapDescriptor mapMarker;
  // void setCustomMarker() async{
  //   mapMarker = await BitmapDescriptor.fromAssetImage(ImageConfiguration(),'assets/images/ic_map_pin_me.png');
  // }

  loaddata() async {
    BitmapDescriptor mapMarker;
    mapMarker = await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(),
        tap ? 'assets/images/kitchen-150.png' : 'assets/images/kitchen-50.png');

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
              // Get.toNamed(RouteHelper.getotpScreenpage());

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
              //       //       decoration: const BoxDecoration(
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

  @override
  void initState() {
    super.initState();
    loaddata();
  }

  Completer<GoogleMapController> _controller = Completer();

  static const LatLng _center = const LatLng(37.8024085, -122.2751843);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ));
    return Scaffold(
      body: Container(
        height: Dimensions.screenHeight,
        width: Dimensions.screenWidth,
        child: Stack(
          children: [
            GoogleMap(
              zoomControlsEnabled: false,
              mapToolbarEnabled: false,
              // mapType: controller,
              onMapCreated: (GoogleMapController controller) {
                controller.setMapStyle(style);
              },
              initialCameraPosition: const CameraPosition(
                target: _center,
                zoom: 14.0,
              ),
              markers: Set.of(_markers),
            ),
            Container(
              height: Dimensions.screenHeight,
              width: Dimensions.screenWidth,
              margin: const EdgeInsets.only(top: 40),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children: <Widget>[
                      Container(
                        height: 200,
                        margin: const EdgeInsets.only(
                            top: 0, left: 10, right: 10, bottom: 0),
                        width: Dimensions.screenWidth,
                        child: Column(
                          children: [
                            Row(
                              // mainAxisAlignment: MainAxisAlignment.start,
                              //crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  flex: 3,
                                  child: Container(
                                    height: 55,
                                    // width: Dimensions.screenWidth * 0.45,
                                    child: InkWell(
                                      onTap: () async {
                                        var place = await PlacesAutocomplete.show(
                                            context: context,
                                            apiKey: googleApikey,
                                            mode: Mode.overlay,
                                            types: [],
                                            strictbounds: false,
                                            // components: [Component(Component.country, 'us')],
                                            //google_map_webservice package
                                            onError: (err) {
                                              print(err);
                                            });

                                        if (place != null) {
                                          setState(() {
                                            // location = place.description.toString();
                                          });

                                          //form google_maps_webservice package
                                          final plist = GoogleMapsPlaces(
                                            apiKey: googleApikey,
                                            apiHeaders:
                                                await const GoogleApiHeaders()
                                                    .getHeaders(),
                                            //from google_api_headers package
                                          );
                                          String placeid = place.placeId ?? "0";
                                          final detail = await plist
                                              .getDetailsByPlaceId(placeid);
                                          final geometry =
                                              detail.result.geometry!;
                                          final lat = geometry.location.lat;
                                          final lang = geometry.location.lng;
                                          var newlatlang = LatLng(lat, lang);

                                          //  _markers.add(Marker(markerId: MarkerId('Home'),
                                          // icon: mapMarker,
                                          // position: LatLng(lat, lang)));

                                          // _controller?.animateCamera(CameraUpdate.newCameraPosition(new CameraPosition(
                                          //   target: LatLng(lat,lang),
                                          //   zoom: 17,
                                          // )));
                                          setState(() {
                                            // getLatitude= lat;
                                            // getLongitude = lang;

                                            _markers.add(Marker(
                                                markerId:
                                                    const MarkerId('Home'),
                                                // icon: mapMarker,
                                                position: LatLng(lat, lang)));
                                          });
                                        }
                                      },
                                      child: Card(
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                              Dimensions.size20),
                                        ),
                                        child: Container(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Icon(
                                                      Icons.arrow_back_outlined,
                                                      size: 30,
                                                      color: Colors.grey[800],
                                                    ),
                                                    const Text(
                                                      "Search delights",
                                                      style: TextStyle(
                                                          fontSize: 12,
                                                          fontWeight: FontWeight
                                                              .normal),
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  children: const [
                                                    Icon(
                                                      Icons
                                                          .location_on_outlined,
                                                      color: Colors.grey,
                                                    ),
                                                    Text(
                                                      "near me",
                                                      style: TextStyle(
                                                          fontSize: 12,
                                                          color: Colors.grey),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
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
                                      // width: Dimensions.screenWidth * 0.25,
                                      height: 55,
                                      child: Card(
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                              Dimensions.size20),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                width: 25,
                                                height: 25,
                                                child: const Image(
                                                  image: AssetImage(
                                                      "assets/images/radius.png"),
                                                ),
                                              ),
                                              Text(
                                                _radius1 + "km",
                                                style: const TextStyle(
                                                    fontSize: 10,
                                                    color: Colors.grey),
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
                            Container(
                              // margin: EdgeInsets.only(left: Dimensions.size5, top: 0, right: Dimensions.size10, bottom: 0),
                              height: Dimensions.size50,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: searchKeywords.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return _buildItemForChips(index);
                                },
                              ),
                            ),
                          ],
                        ),
                      ),

                      //Chips
                    ],
                  ),

                  // Container(
                  //         margin: EdgeInsets.only(left: Dimensions.size5, top: Dimensions.size60, right: Dimensions.size10, bottom: 0),
                  //         height: Dimensions.size100,
                  //         child: ListView.builder(
                  //           scrollDirection: Axis.horizontal,
                  //           itemCount: searchKeywords.length,
                  //           itemBuilder: (BuildContext context, int index) {
                  //             return _buildItemForChips(index);
                  //           },
                  //
                  //         ),
                  //       ),

                  Container(
                      margin: const EdgeInsets.symmetric(vertical: 10.0),
                      height: Dimensions.size140,
                      child:
                          ListView(scrollDirection: Axis.horizontal, children: <
                              Widget>[
                        GestureDetector(
                          onTap: () {
                            Get.toNamed(RouteHelper.getdetailsScreen());
                          },
                          child: Container(
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            width: Dimensions.screenWidth,
                            height: 150,
                            child: Card(
                              elevation: 2,
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(Dimensions.size20),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    width: 128,
                                    height: 129,
                                    margin: const EdgeInsets.only(
                                        top: 10,
                                        left: 10,
                                        right: 10,
                                        bottom: 10),
                                    decoration: BoxDecoration(
                                        color: Colors.red,
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(Dimensions.size20),
                                        ),
                                        image: const DecorationImage(
                                          image: AssetImage(
                                              "assets/images/food-image.png"),
                                          fit: BoxFit.cover,
                                        )),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(
                                        left: 5, right: 5, top: 20),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: const [
                                            Text(
                                              "Burger Palace",
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.black,
                                                  fontWeight:
                                                      FontWeight.normal),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              "Restaurant",
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.grey[700],
                                                  fontWeight:
                                                      FontWeight.normal),
                                            ),
                                            Text(
                                              "." + "6 km",
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  fontSize: 10,
                                                  color: Colors.grey[700],
                                                  fontWeight:
                                                      FontWeight.normal),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              "Closes at 10pm",
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  fontSize: 10,
                                                  color: Colors.grey[700],
                                                  fontWeight:
                                                      FontWeight.normal),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            ElevatedButton(
                                              onPressed: () {},
                                              style: ElevatedButton.styleFrom(
                                                elevation: 0, backgroundColor: Colors.white,
                                                // minimumSize: Size( 40),
                                                shape: RoundedRectangleBorder(
                                                  side: const BorderSide(
                                                      color: Colors.cyan),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20), // <-- Radius
                                                ),
                                              ),
                                              child: Row(
                                                children: [
                                                  Container(
                                                      width: 20,
                                                      height: 20,
                                                      child: Image.asset(
                                                        'assets/images/direction-s.png',
                                                      )),
                                                  const SizedBox(
                                                    width: 3,
                                                  ),
                                                  const Text(
                                                    "Directions",
                                                    style: TextStyle(
                                                        color: Colors.cyan,
                                                        fontSize: 10),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            ElevatedButton(
                                              onPressed: () {},
                                              style: ElevatedButton.styleFrom(
                                                elevation: 0, backgroundColor: Colors.cyan,
                                                // minimumSize: Size( 40),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20), // <-- Radius
                                                ),
                                              ),
                                              child: Row(
                                                children: [
                                                  Container(
                                                      width: 20,
                                                      height: 20,
                                                      child: Image.asset(
                                                        'assets/images/Pin-w.png',
                                                      )),
                                                  const SizedBox(
                                                    width: 3,
                                                  ),
                                                  const Text(
                                                    "Pinned",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 10),
                                                  ),
                                                ],
                                              ),
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
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.toNamed(RouteHelper.getdetailsScreen());
                          },
                          child: Container(
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            width: Dimensions.screenWidth,
                            height: 150,
                            child: Card(
                              elevation: 2,
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(Dimensions.size20),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    width: 128,
                                    height: 129,
                                    margin: const EdgeInsets.only(
                                        top: 10,
                                        left: 10,
                                        right: 10,
                                        bottom: 10),
                                    decoration: BoxDecoration(
                                        color: Colors.red,
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(Dimensions.size20),
                                        ),
                                        image: const DecorationImage(
                                          image: AssetImage(
                                              "assets/images/food-image.png"),
                                          fit: BoxFit.cover,
                                        )),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(
                                        left: 5, right: 5, top: 20),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: const [
                                            Text(
                                              "Burger Palace",
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.black,
                                                  fontWeight:
                                                      FontWeight.normal),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              "Restaurant",
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.grey[700],
                                                  fontWeight:
                                                      FontWeight.normal),
                                            ),
                                            Text(
                                              "." + "6 km",
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  fontSize: 10,
                                                  color: Colors.grey[700],
                                                  fontWeight:
                                                      FontWeight.normal),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              "Closes at 10pm",
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  fontSize: 10,
                                                  color: Colors.grey[700],
                                                  fontWeight:
                                                      FontWeight.normal),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            ElevatedButton(
                                              onPressed: () {},
                                              style: ElevatedButton.styleFrom(
                                                elevation: 0, backgroundColor: Colors.white,
                                                // minimumSize: Size( 40),
                                                shape: RoundedRectangleBorder(
                                                  side: const BorderSide(
                                                      color: Colors.cyan),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20), // <-- Radius
                                                ),
                                              ),
                                              child: Row(
                                                children: [
                                                  Container(
                                                      width: 20,
                                                      height: 20,
                                                      child: Image.asset(
                                                        'assets/images/direction-s.png',
                                                      )),
                                                  const SizedBox(
                                                    width: 3,
                                                  ),
                                                  const Text(
                                                    "Directions",
                                                    style: TextStyle(
                                                        color: Colors.cyan,
                                                        fontSize: 10),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            ElevatedButton(
                                              onPressed: () {},
                                              style: ElevatedButton.styleFrom(
                                                elevation: 0, backgroundColor: Colors.cyan,
                                                // minimumSize: Size( 40),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20), // <-- Radius
                                                ),
                                              ),
                                              child: Row(
                                                children: [
                                                  Container(
                                                      width: 20,
                                                      height: 20,
                                                      child: Image.asset(
                                                        'assets/images/Pin-w.png',
                                                      )),
                                                  const SizedBox(
                                                    width: 3,
                                                  ),
                                                  const Text(
                                                    "Pinned",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 10),
                                                  ),
                                                ],
                                              ),
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
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.toNamed(RouteHelper.getdetailsScreen());
                          },
                          child: Container(
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            width: Dimensions.screenWidth,
                            height: 150,
                            child: Card(
                              elevation: 2,
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(Dimensions.size20),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    width: 128,
                                    height: 129,
                                    margin: const EdgeInsets.only(
                                        top: 10,
                                        left: 10,
                                        right: 10,
                                        bottom: 10),
                                    decoration: BoxDecoration(
                                        color: Colors.red,
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(Dimensions.size20),
                                        ),
                                        image: const DecorationImage(
                                          image: AssetImage(
                                              "assets/images/food-image.png"),
                                          fit: BoxFit.cover,
                                        )),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(
                                        left: 5, right: 5, top: 20),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: const [
                                            Text(
                                              "Burger Palace",
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.black,
                                                  fontWeight:
                                                      FontWeight.normal),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              "Restaurant",
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.grey[700],
                                                  fontWeight:
                                                      FontWeight.normal),
                                            ),
                                            Text(
                                              "." + "6 km",
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  fontSize: 10,
                                                  color: Colors.grey[700],
                                                  fontWeight:
                                                      FontWeight.normal),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              "Closes at 10pm",
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  fontSize: 10,
                                                  color: Colors.grey[700],
                                                  fontWeight:
                                                      FontWeight.normal),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            ElevatedButton(
                                              onPressed: () {},
                                              style: ElevatedButton.styleFrom(
                                                elevation: 0, backgroundColor: Colors.white,
                                                // minimumSize: Size( 40),
                                                shape: RoundedRectangleBorder(
                                                  side: const BorderSide(
                                                      color: Colors.cyan),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20), // <-- Radius
                                                ),
                                              ),
                                              child: Row(
                                                children: [
                                                  Container(
                                                      width: 20,
                                                      height: 20,
                                                      child: Image.asset(
                                                        'assets/images/direction-s.png',
                                                      )),
                                                  const SizedBox(
                                                    width: 3,
                                                  ),
                                                  const Text(
                                                    "Directions",
                                                    style: TextStyle(
                                                        color: Colors.cyan,
                                                        fontSize: 10),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            ElevatedButton(
                                              onPressed: () {},
                                              style: ElevatedButton.styleFrom(
                                                elevation: 0, backgroundColor: Colors.cyan,
                                                // minimumSize: Size( 40),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20), // <-- Radius
                                                ),
                                              ),
                                              child: Row(
                                                children: [
                                                  Container(
                                                      width: 20,
                                                      height: 20,
                                                      child: Image.asset(
                                                        'assets/images/Pin-w.png',
                                                      )),
                                                  const SizedBox(
                                                    width: 3,
                                                  ),
                                                  const Text(
                                                    "Pinned",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 10),
                                                  ),
                                                ],
                                              ),
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
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.toNamed(RouteHelper.getdetailsScreen());
                          },
                          child: Container(
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            width: Dimensions.screenWidth,
                            height: 150,
                            child: Card(
                              elevation: 2,
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(Dimensions.size20),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    width: 128,
                                    height: 129,
                                    margin: const EdgeInsets.only(
                                        top: 10,
                                        left: 10,
                                        right: 10,
                                        bottom: 10),
                                    decoration: BoxDecoration(
                                        color: Colors.red,
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(Dimensions.size20),
                                        ),
                                        image: const DecorationImage(
                                          image: AssetImage(
                                              "assets/images/food-image.png"),
                                          fit: BoxFit.cover,
                                        )),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(
                                        left: 5, right: 5, top: 20),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: const [
                                            Text(
                                              "Burger Palace",
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.black,
                                                  fontWeight:
                                                      FontWeight.normal),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              "Restaurant",
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.grey[700],
                                                  fontWeight:
                                                      FontWeight.normal),
                                            ),
                                            Text(
                                              "." + "6 km",
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  fontSize: 10,
                                                  color: Colors.grey[700],
                                                  fontWeight:
                                                      FontWeight.normal),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              "Closes at 10pm",
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  fontSize: 10,
                                                  color: Colors.grey[700],
                                                  fontWeight:
                                                      FontWeight.normal),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            ElevatedButton(
                                              onPressed: () {},
                                              style: ElevatedButton.styleFrom(
                                                elevation: 0, backgroundColor: Colors.white,
                                                // minimumSize: Size( 40),
                                                shape: RoundedRectangleBorder(
                                                  side: const BorderSide(
                                                      color: Colors.cyan),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20), // <-- Radius
                                                ),
                                              ),
                                              child: Row(
                                                children: [
                                                  Container(
                                                      width: 20,
                                                      height: 20,
                                                      child: Image.asset(
                                                        'assets/images/direction-s.png',
                                                      )),
                                                  const SizedBox(
                                                    width: 3,
                                                  ),
                                                  const Text(
                                                    "Directions",
                                                    style: TextStyle(
                                                        color: Colors.cyan,
                                                        fontSize: 10),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            ElevatedButton(
                                              onPressed: () {},
                                              style: ElevatedButton.styleFrom(
                                                elevation: 0, backgroundColor: Colors.cyan,
                                                // minimumSize: Size( 40),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20), // <-- Radius
                                                ),
                                              ),
                                              child: Row(
                                                children: [
                                                  Container(
                                                      width: 20,
                                                      height: 20,
                                                      child: Image.asset(
                                                        'assets/images/Pin-w.png',
                                                      )),
                                                  const SizedBox(
                                                    width: 3,
                                                  ),
                                                  const Text(
                                                    "Pinned",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 10),
                                                  ),
                                                ],
                                              ),
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
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.toNamed(RouteHelper.getdetailsScreen());
                          },
                          child: Container(
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            width: Dimensions.screenWidth,
                            height: 150,
                            child: Card(
                              elevation: 2,
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(Dimensions.size20),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    width: 128,
                                    height: 129,
                                    margin: const EdgeInsets.only(
                                        top: 10,
                                        left: 10,
                                        right: 10,
                                        bottom: 10),
                                    decoration: BoxDecoration(
                                        color: Colors.red,
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(Dimensions.size20),
                                        ),
                                        image: const DecorationImage(
                                          image: AssetImage(
                                              "assets/images/food-image.png"),
                                          fit: BoxFit.cover,
                                        )),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(
                                        left: 5, right: 5, top: 20),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: const [
                                            Text(
                                              "Burger Palace",
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.black,
                                                  fontWeight:
                                                      FontWeight.normal),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              "Restaurant",
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.grey[700],
                                                  fontWeight:
                                                      FontWeight.normal),
                                            ),
                                            Text(
                                              "." + "6 km",
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  fontSize: 10,
                                                  color: Colors.grey[700],
                                                  fontWeight:
                                                      FontWeight.normal),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              "Closes at 10pm",
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  fontSize: 10,
                                                  color: Colors.grey[700],
                                                  fontWeight:
                                                      FontWeight.normal),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            ElevatedButton(
                                              onPressed: () {},
                                              style: ElevatedButton.styleFrom(
                                                elevation: 0, backgroundColor: Colors.white,
                                                // minimumSize: Size( 40),
                                                shape: RoundedRectangleBorder(
                                                  side: const BorderSide(
                                                      color: Colors.cyan),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20), // <-- Radius
                                                ),
                                              ),
                                              child: Row(
                                                children: [
                                                  Container(
                                                      width: 20,
                                                      height: 20,
                                                      child: Image.asset(
                                                        'assets/images/direction-s.png',
                                                      )),
                                                  const SizedBox(
                                                    width: 3,
                                                  ),
                                                  const Text(
                                                    "Directions",
                                                    style: TextStyle(
                                                        color: Colors.cyan,
                                                        fontSize: 10),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            ElevatedButton(
                                              onPressed: () {},
                                              style: ElevatedButton.styleFrom(
                                                elevation: 0, backgroundColor: Colors.cyan,
                                                // minimumSize: Size( 40),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20), // <-- Radius
                                                ),
                                              ),
                                              child: Row(
                                                children: [
                                                  Container(
                                                      width: 20,
                                                      height: 20,
                                                      child: Image.asset(
                                                        'assets/images/Pin-w.png',
                                                      )),
                                                  const SizedBox(
                                                    width: 3,
                                                  ),
                                                  const Text(
                                                    "Pinned",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 10),
                                                  ),
                                                ],
                                              ),
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
                        ),
                      ])),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildItemForChips(int index) {
    return GestureDetector(
      onTap: () {
        // checknow(searchKeywords[index]['name']!);
        setState(() {
          searchKeywords[index]['active'] = "yes";
          searchKeywords[curIndex]['active'] = "no";
          curIndex = index;
          // KeyWord_formarker_chips = searchKeywords[index]['name']!;
          // KeyWord_formarker = KeyWord_formarker_chips;
        });

        //searchNow(searchKeywords[index]['name']!);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: Dimensions.size5),
        child: Chip(
          elevation: 2,
          padding: EdgeInsets.all(Dimensions.size8),
          avatar: CircleAvatar(
            backgroundColor: searchKeywords[index]['active'] == "yes"
                ? Colors.cyan
                : Colors.white,
            radius: 10,
            // child: Image.asset('assets/images/drink-g.png'),
            child: searchKeywords[index]['active'] == "yes"
                ? Image.asset(icon_white[index])
                : Image.asset(icon_black[index]),
          ),
          label: Text(
            searchKeywords[index]['name']!,
            style: TextStyle(
                color: searchKeywords[index]['active'] == "yes"
                    ? Colors.white
                    : Colors.grey,
                fontSize: Dimensions.size16),
          ),
          backgroundColor: searchKeywords[index]['active'] == "yes"
              ? Colors.cyan
              : Colors.white,
        ),
      ),
    );
  }

  void showBootomSheet() {
    showModalBottomSheet<void>(
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
              padding: const EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                // mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: const [
                      Icon(
                        Icons.arrow_back_outlined,
                        color: Colors.black,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Select search radius',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    child: Text(
                      "We will suggest delights within this radius from your current location. ",
                      style: TextStyle(
                          fontWeight: FontWeight.normal,
                          color: Colors.grey[800],
                          fontSize: 15),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Slider(
                    value: _radius,
                    max: 50.0,
                    divisions: 10,
                    label: _radius.round().toString(),
                    activeColor: Colors.cyan,
                    inactiveColor: Colors.grey,
                    onChanged: (double value) {
                      setState(() {
                        _radius = value;
                        _radius1 = _radius.toString();
                      });
                    },
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 10, right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: 50,
                              width: 100,
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.grey,
                                  ),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(10))),
                              child: Text(
                                _radius1,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    fontWeight: FontWeight.normal,
                                    fontSize: 18),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            const Text(
                              "km",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontWeight: FontWeight.normal, fontSize: 18),
                            ),
                          ],
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        TextButton(
                            child: const Text(
                              'Done',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                  color: Colors.cyan),
                            ),
                            onPressed: () {
                              Navigator.pop(context, _radius1);
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
  }

  Widget horizontalList1 = Container(
      margin: const EdgeInsets.symmetric(vertical: 20.0),
      height: 200.0,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          Container(
            width: 160.0,
            color: Colors.red,
          ),
          Container(
            width: 160.0,
            color: Colors.orange,
          ),
          Container(
            width: 160.0,
            color: Colors.pink,
          ),
          Container(
            width: 160.0,
            color: Colors.yellow,
          ),
        ],
      ));
}
