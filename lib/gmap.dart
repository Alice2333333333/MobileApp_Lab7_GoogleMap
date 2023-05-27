import 'dart:collection';
import 'dart:ui' as ui;
import 'package:location/location.dart';
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
  GoogleMapController? _controller;
  BitmapDescriptor? _markerIcon;

  final Set<Marker> _markers = HashSet<Marker>();
  final Set<Polygon> _polygons = HashSet<Polygon>();
  final Set<Polyline> _polylines = HashSet<Polyline>();
  final Set<Circle> _circles = HashSet<Circle>();

  @override
  void initState() {
    super.initState();
    getBytesFromAsset('assets/noodle_icon.png', 150).then((onValue) {
      _markerIcon = BitmapDescriptor.fromBytes(onValue);
    });
    _setPolygons();
    _setPolylines();
    _setCircles();
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

  void _setPolygons() {
    List<LatLng> polygonLatLongs = [];
    polygonLatLongs.add(const LatLng(37.78493, -122.42932));
    polygonLatLongs.add(const LatLng(37.78693, -122.41942));
    polygonLatLongs.add(const LatLng(37.78923, -122.41542));
    polygonLatLongs.add(const LatLng(37.78923, -122.42582));

    _polygons.add(Polygon(
      polygonId: const PolygonId("0"),
      points: polygonLatLongs,
      fillColor: Colors.white,
      strokeWidth: 1,
    ));
  }

  void _setPolylines() {
    List<LatLng> polylineLatLongs = [];
    polylineLatLongs.add(const LatLng(37.74493, -122.42932));
    polylineLatLongs.add(const LatLng(37.74693, -122.41942));
    polylineLatLongs.add(const LatLng(37.74923, -122.41542));
    polylineLatLongs.add(const LatLng(37.74923, -122.42582));
    polylineLatLongs.add(const LatLng(37.74493, -122.42923));

    _polylines.add(
      Polyline(
        polylineId: const PolylineId("0"),
        points: polylineLatLongs,
        color: Colors.purple,
        width: 1,
      ),
    );
  }

  void _setCircles() {
    _circles.add(
      const Circle(
          circleId: CircleId("0"),
          center: LatLng(37.76493, -122.42432),
          radius: 1000,
          strokeWidth: 2,
          fillColor: Color.fromRGBO(102, 51, 153, .5)),
    );
  }

  Future <void> _onMapCreated(GoogleMapController controller) async {
    setState(() {
      _controller = controller;
    });
    String value = await DefaultAssetBundle.of(context)
        .loadString('assets/map_style.json');
    _controller?.setMapStyle(value);
  }

  void _currentLocation() async {
    LocationData? currentLocation;
    var location = Location();
    try {
      currentLocation = await location.getLocation();
    } on Exception {
      currentLocation = null;
    }

    _controller?.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(
        bearing: 0,
        target: LatLng(currentLocation!.latitude!, currentLocation.longitude!),
        zoom: 17.0,
      ),
    ));
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
            mapType: MapType.normal,
            myLocationEnabled: true,
            onMapCreated: _onMapCreated,
            initialCameraPosition: const CameraPosition(
              target: _kMapCenter,
              zoom: 12,
            ),
            markers: <Marker>{_createMarker()},
            polygons: _polygons,
            polylines: _polylines,
            circles: _circles,
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
}
