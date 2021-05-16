import 'dart:io';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';


class MapPage extends StatefulWidget {
  const MapPage({ Key key }) : super(key: key);

  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {

   @override
  void initState() {
    super.initState();
    // Enable hybrid composition.
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(title:
      Text('Campus Locate Me',)),
      body: WebView(
        initialUrl: 'https://www.google.com/maps/@-19.5177852,29.8356438,17z',
        javascriptMode: JavascriptMode.unrestricted
      ),
    );
  }
}