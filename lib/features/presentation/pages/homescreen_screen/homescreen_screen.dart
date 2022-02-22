import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:supdup/core/common_widget/custom_spacer_widget.dart';
import 'package:supdup/core/config/db_provider.dart';
import 'package:supdup/core/config/navigation.dart';
import 'package:supdup/core/utils/routes.dart';

import 'argument/argument.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<List?>? data;
  String? image;
  Position? position;
  Uint8List? _bytesImage;
   LatLng currentPostion=LatLng(0.0, 0.0);
  LocationPermission permission = LocationPermission.denied;


  double? lat;
  double? long;
  @override
  void initState() {
    //checkPermission();
    _getLocation();
    super.initState();
  }

  Completer<GoogleMapController> _controller = Completer();
  Argument? argument;

  _getLocation()async {
    print("hii");
    position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    setState(() {
      currentPostion =new LatLng(position!.latitude, position!.longitude);
      lat=currentPostion.latitude;
      long=currentPostion.longitude;
    });
  }





  @override
  Widget build(BuildContext context) {
    argument =ModalRoute.of(context)!.settings.arguments as Argument;
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            // leading: Container(
            //  child: Image.file(File(argument!.image)),
            // ),
            title: Text(argument!.name),
          ),
          body:_getBody(),
        )
    );
  }

 Widget _getBody() {
    return SingleChildScrollView(
      child: Container(
        child: Column(
          children: <Widget>[
            _getGoogleMap(),
            CustomSpacerWidget(height: 20.0,),
            _getApiButton()
          ],
        ),
      )
    );
 }

  _getGoogleMap() {
    return Container(
       height: 500,
      // width: 200,
      child: GoogleMap(
        compassEnabled: true,
        tiltGesturesEnabled: false,
        myLocationEnabled: true,
        myLocationButtonEnabled: true,
        markers: Set<Marker>.of(
          <Marker>[
            Marker(
              draggable: true,
              markerId: MarkerId("1"),
              position: LatLng(currentPostion.latitude, currentPostion.longitude),
              icon: BitmapDescriptor.defaultMarker,
              infoWindow: const InfoWindow(),
            )
          ],
        ),
        mapType: MapType.normal,
        initialCameraPosition: CameraPosition(target: currentPostion,zoom: 14.4746),
        onMapCreated: (GoogleMapController controller) {
          if (!_controller.isCompleted) {
            _controller.complete(controller);
          }
        },
      ),
    );
  }


 Widget _getApiButton() {
    return GestureDetector(
      onTap: (){
        Navigation.intent(context, AppRoutes.second_screen);
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
          color: Colors.green
        ),
        padding: EdgeInsets.only(left: 10.0,right: 10.0,top: 5.0,bottom: 5.0),
        child:Text("Go to next screen") ,
      ),
    );
 }

  //checkPersion before initialize the map
   checkPermission() async{
     LocationPermission permission;
     permission = await Geolocator.checkPermission();
     if (permission == LocationPermission.denied) {
       permission = await Geolocator.requestPermission();
       if (permission == LocationPermission.deniedForever) {
         return Future.error('Location Not Available');
       }
     } else {
       throw Exception('Error');
     }
     return await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  }

}
