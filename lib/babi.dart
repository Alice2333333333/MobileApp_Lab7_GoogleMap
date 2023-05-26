// import 'dart:collection';

// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';

// class GMap extends StatefulWidget {
//   const GMap({super.key});

//   @override
//   State<GMap> createState() => _GMapState();
// }

// class _GMapState extends State<GMap> {
//   final Set<Marker> _markers = HashSet<Marker>();
//   final Set<Polygon> _polygons = HashSet<Polygon>();
//   final Set<Polyline> _polylines = HashSet<Polyline>();
//   final Set<Circle> _circles = HashSet<Circle>();

//   GoogleMapController? _mapController;
//   BitmapDescriptor? _markerIcon;

//   @override
//   void initState() {
//     super.initState();
//     _setMarkerIcon();
//     _setPolygons();
//     _setCircles();
//   }

//   void _setMarkerIcon() async {
//     _markerIcon = await BitmapDescriptor.fromAssetImage(
//         ImageConfiguration(), 'assets/noodle_icon.png');
//   }

//   void _setPolygons() {
//     List<LatLng> polygonLatLongs = List<LatLong>();
//     polygonLatLongs.add(LatLng(37.78493, -122.42932));
//     polygonLatLongs.add(LatLng(37.78693, -122.41942));
//     polygonLatLongs.add(LatLng(37.78923, -122.41542));
//     polygonLatLongs.add(LatLng(37.78923, -122.42582));

//     _polygons.add(Polygon(
//       polygonId: PolygonId("0"),
//       points: polygonLatLongs,
//       fillColor: Colors.white,
//       strokeWidth: 1,
//     ));
//   }

//   void _setPolylines() {
//     List<LatLng> polylineLatLongs = List<LatLng>();
//     polylineLatLongs.add(LatLng(37.74493, -122.42932));
//     polylineLatLongs.add(LatLng(37.74693, -122.41942));
//     polylineLatLongs.add(LatLng(37.74923, -122.41542));
//     polylineLatLongs.add(LatLng(37.74923, -122.42582));
//     polylineLatLongs.add(LatLng(37.74493, -122.42923));

//     _polylines.add(
//       Polyline(
//         polylineId: PolylineId("0"),
//         points: polylineLatLongs,
//         color: Colors.purple,
//         width: 1,
//       ),
//     );
//   }

//   void _setCircles() {
//     _circles.add(
//       const Circle(
//           circleId: CircleId("0"),
//           center: LatLng(37.76493, -122.42432),
//           radius: 1000,
//           strokeWidth: 2,
//           fillColor: Color.fromRGBO(102, 51, 153, .5)),
//     );
//   }

//   void _onMapCreated(GoogleMapController controller) {
//     _mapController = controller;

//     setState(() {
//       _markers.add(
//         Marker(
//             markerId: const MarkerId("0"),
//             position: const LatLng(37.77483, -122.41942),
//             infoWindow: const InfoWindow(
//               title: "San Francisco",
//               snippet: "An interesting city",
//             ),
//             icon: _markerIcon),
//       );
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Map'),
//       ),
//       body: Stack(
//         children: <Widget>[
//           GoogleMap(
//             onMapCreated: _onMapCreated,
//             initialCameraPosition: const CameraPosition(
//               target: LatLng(37.77483, -122.41942),
//               zoom: 12,
//             ),
//             markers: _markers,
//             polygons: _polygons,
//             polylines: _polylines,
//             circles: _circles,
//             myLocationButtonEnabled: true,
//           ),
//           Container(
//             alignment: Alignment.bottomCenter,
//             child: Text("Coding with Curry"),
//             padding: EdgeInsets.fromLTRB(0, 0, 0, 32),
//           ),
//         ],
//       ),
//     );
//   }
// }
