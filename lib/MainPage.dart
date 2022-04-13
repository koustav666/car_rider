import 'dart:ui';

import 'package:car_rider/brand_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';
import 'Widgets/BrandDivider.dart';

class MainPage extends StatefulWidget {
  static const String id="Mainpage";
  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  //double searchSheetHeight=300;
  double mapPadding=300;
  GlobalKey<ScaffoldState> scaffoldkey= new GlobalKey<ScaffoldState>();
  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );
  var geoLocator= Geolocator();
  late Position currentPosition;
  void setupPositionLocator()async{
    await Geolocator.requestPermission();
    Position position=await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.bestForNavigation);
    currentPosition=position;
    LatLng Pos=LatLng(position.latitude, position.longitude);
    CameraPosition cp=new CameraPosition(target: Pos,zoom: 14);
    mapController.animateCamera(CameraUpdate.newCameraPosition(cp)) ;
  }
  Completer<GoogleMapController> _controller = Completer();
  late GoogleMapController mapController;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldkey,
      drawer: Container(
          width: 200,
          color: Colors.white,
          child: Drawer(
              child: ListView(
                padding: EdgeInsets.all(0),
                children:<Widget> [
                  Container(
                      child: DrawerHeader(
                          decoration:BoxDecoration(
                            color: Colors.white
                          ),
                          child: Row(
                            children: <Widget>[
                              Image.asset('images/user_icon.png',height: 40,width: 40,),
                              SizedBox(width: 15,),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children:<Widget> [
                                  SizedBox(width: 15,),
                                  Text('Koustav',style:TextStyle(fontFamily: 'Brand-Regular',fontSize: 25),textAlign:TextAlign.start,),
                                  SizedBox(width: 15,),
                                  Text('View Profile',style:TextStyle(fontFamily: 'Brand-Regular',fontSize: 13),textAlign:TextAlign.start),
                                ],
                              ),
                            ],
                          )
                      )
                  ),
                  BrandDivider(),
                  SizedBox(height: 15,),
                  ListTile(
                    leading: Icon(Icons.card_giftcard_outlined),
                    title: Text('Free Rides',style: TextStyle(fontSize: 16),),
                  )
                ],
              ),
          )
      ),
      body: Stack(
        children: <Widget>[
          GoogleMap(
            padding: EdgeInsets.only(bottom:mapPadding),
            mapType: MapType.normal,
            myLocationButtonEnabled: true,
            myLocationEnabled: true,
            zoomGesturesEnabled: true,
            zoomControlsEnabled: true,
            initialCameraPosition: _kGooglePlex,
            onMapCreated: (GoogleMapController controller) async {
              //LocationPermission permission;

              _controller.complete(controller);
              mapController=controller;
              setupPositionLocator();
            },

          ),
          Positioned(
            top:40,
            left: 22,


            child: GestureDetector(
              onTap: (){
                scaffoldkey.currentState?.openDrawer();
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 5.0,
                      spreadRadius: 0.5,
                      offset:Offset(0.7,0.7),
                    )
                  ],

                ),
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  radius:20,
                  child: Icon(
                    Icons.menu,color: Colors.black26,size:20
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              height: 245,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(topLeft:Radius.circular(15),topRight:Radius.circular(15)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 15,
                    spreadRadius: 0.5,
                    offset: Offset(
                      0.7,
                      0.7
                    )
                  )
                ]
              ),
              child:Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24,vertical: 18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(height: 5,),
                    Text('Hi! Nice to see you again',style: TextStyle(fontSize: 12,fontFamily: "Brand-Regular",)),
                    SizedBox(height: 5,),
                    Text('Where would you like to go today',style: TextStyle(fontSize: 20,fontFamily: "Brand-Bold")),
                    SizedBox(height: 10,),
                    Container(
                      height: 40,
                      decoration:BoxDecoration(
                        color:Colors.white,
                        borderRadius: BorderRadius.circular(4),
                        boxShadow: [BoxShadow(
                          color: Colors.black12,
                          blurRadius:5.0,
                          spreadRadius: 0.5,
                          offset: Offset(0.7,0.7)
                        )]
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: <Widget>[
                            Icon(Icons.search,color:Colors.blueAccent,),
                            SizedBox(width: 10,),
                            Text('Search Location',style: TextStyle(fontSize: 12,fontFamily: "Brand-Regular"),)
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 12,),
                    Row(
                      children: <Widget>[
                        Icon(Icons.home,color: BrandColors.colorDimText,),
                        SizedBox(width: 5,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text('Add Home'),
                            SizedBox(height: 3,),
                            Text('Your Home Address',style: TextStyle(fontSize: 11,color: BrandColors.colorDimText),)
                          ],
                        )
                        ],
                      ),
                    SizedBox(height: 12,),
                    BrandDivider(),
                    SizedBox(height: 12,),
                    Row(
                      children: <Widget>[
                        Icon(Icons.work,color: BrandColors.colorDimText,),
                        SizedBox(width: 5,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text('Add Work'),
                            SizedBox(height: 3,),
                            Text('Your Office Address',style: TextStyle(fontSize: 11,color: BrandColors.colorDimText),)
                          ],
                        )
                      ],
                    ),
                  ],
                  )
                ),
              )
            ),
        ],
      ),
    );
  }
}
