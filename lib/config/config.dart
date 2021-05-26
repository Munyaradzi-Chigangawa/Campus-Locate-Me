

import 'package:google_maps_flutter/google_maps_flutter.dart';

class Config {
  final String appName = 'Campus Locate Me';
  final String mapAPIKey = 'AIzaSyAWX6KZ2aSWWBMt3T_juIkN2Pw0PLXNEvE';
  final String splashIcon = 'assets/images/splash.png';
  final String supportEmail = 'munyaradzichigangawa6@gmail.com';


  final CameraPosition initialCameraPosition = CameraPosition(
    target: LatLng(-19.517825284097267, 29.83768898665423),
    zoom: 10,
  );

  
  //google maps marker icons
  final String drivingMarkerIcon = 'assets/images/driving_pin.png';
  final String destinationMarkerIcon = 'assets/images/destination_map_marker.png';

  
  
  //Intro images
  final String introImage1 = 'assets/images/travel6.png';
  final String introImage2 = 'assets/images/travel1.png';
  final String introImage3 = 'assets/images/travel5.png';

  
}