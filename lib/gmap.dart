import 'dart:collection';
import 'dart:ui' as ui;
// import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GMap extends StatefulWidget {
  const GMap({super.key});

  @override
  State<GMap> createState() => _GMapState();
}

class _GMapState extends State<GMap> {
  static const LatLng _kMapCenter = LatLng(37.77483, -122.41942);
  GoogleMapController? _mapController;
  BitmapDescriptor? _markerIcon;

  final Set<Marker> _markers = HashSet<Marker>();
  final Set<Polygon> _polygons = HashSet<Polygon>();
  final Set<Polyline> _polylines = HashSet<Polyline>();
  final Set<Circle> _circles = HashSet<Circle>();

  @override
  void initState() {
    super.initState();
    // _createMarkerImageFromAsset(context);
    getBytesFromAsset('assets/noodle_icon.png', 150).then((onValue) {
      _markerIcon = BitmapDescriptor.fromBytes(onValue);
    });
    setState(() {});
  }

  Marker _createMarker() {
    if (_markerIcon != null) {
      return Marker(
        markerId: const MarkerId('0'),
        position: _kMapCenter,
        icon: _markerIcon!,
        infoWindow: const InfoWindow(
          title: "San Francisco",
          snippet: "An interesting city",
        ),
      );
    } else {
      return const Marker(
        markerId: MarkerId('0'),
        position: _kMapCenter,
      );
    }
  }

  static Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

   void _onMapCreated(GoogleMapController controller) {
    setState(() {
      _mapController = controller;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Map'),
      ),
      body: Stack(
        children: <Widget>[
          GoogleMap(
            onMapCreated: _onMapCreated,
            initialCameraPosition: const CameraPosition(
              target: _kMapCenter,
              zoom: 12,
            ),
            markers: <Marker>{_createMarker()},
            polygons: _polygons,
            polylines: _polylines,
            circles: _circles,
            myLocationButtonEnabled: true,
          ),
          Container(
            alignment: Alignment.bottomCenter,
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 32),
            child: const Text("Coding with Curry"),
          ),
        ],
      ),
    );
  }

  // Future<void> _createMarkerImageFromAsset(BuildContext context) async {
  //   // if (_markerIcon == null) {
  //   //   final ImageConfiguration imageConfiguration =
  //   //       createLocalImageConfiguration(context, size: const Size.square(48));
  //   //   BitmapDescriptor.fromAssetImage(
  //   //           imageConfiguration, 'assets/red_square.png')
  //   //       .then(_updateBitmap);
  //   // }
  //   setState(() {
  //     getBytesFromAsset('assets/red_square.png', 64).then((onValue) {
  //       _markerIcon = BitmapDescriptor.fromBytes(onValue);
  //     });
  //   });
  // }

  // void _updateBitmap(BitmapDescriptor bitmap) {
  //   setState(() {
  //     _markerIcon = bitmap;
  //   });
  // }
}
