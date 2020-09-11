import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart';

class MapaPage extends StatefulWidget {
  MapaPage({Key key}) : super(key: key);

  @override
  _MapaPageState createState() => _MapaPageState();
}

class _MapaPageState extends State<MapaPage> {
  GoogleMapController mapController;
  Set<Marker> markers = Set<Marker>();
  // LatLng jiparanaPosition = const LatLng(-10.881672, -61.940875);
  LatLng jiparanaPosition = const LatLng(-10.8866222, -61.9501367);
  String searchAddr;
  var distancia = {"text": "1 m", "value": 0};
  Dio dio = Dio();

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            onMapCreated: _onMapCreated,
            // onCameraMove: (data) {
            //   print(data);
            // },
            onTap: (position) {
              print(position);
              move(position);
              marcar(position);
            },
            initialCameraPosition: CameraPosition(
              target: jiparanaPosition,
              zoom: 15,
            ),
            markers: markers,
          ),
          Positioned(
              top: 29,
              right: 14,
              left: 14,
              child: Container(
                height: 49,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(9.0),
                  color: Colors.white,
                ),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "Insira endereço",
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.only(left: 14, top: 15),
                    suffix: IconButton(
                      icon: const Icon(Icons.search),
                      onPressed: () async {
                        refreshAddress();
                      },
                      iconSize: 29,
                    ),
                  ),
                  onChanged: (val) {
                    setState(() {
                      searchAddr = val;
                    });
                  },
                  onSubmitted: (val) async {
                    searchAddr = val;
                    await refreshAddress();
                  },
                ),
              )),
          Positioned(
              top: 80,
              right: 14,
              left: 14,
              child: Text(
                distancia["text"].toString(),
                style: const TextStyle(fontSize: 20),
              ))
        ],
      ),
    );
  }

  Future<void> refreshAddress() async {
    final LatLng position = await searchandNavigate();
    marcar(position);
    move(position);
  }

  Future<LatLng> searchandNavigate() async {
    final List<Location> locations =
        await locationFromAddress("$searchAddr Ji-paraná Rondônia");

    return LatLng(locations[0].latitude, locations[0].longitude);
  }

  void move(LatLng position) {
    // LatLng position = LatLng(lat, long);
    mapController.moveCamera(CameraUpdate.newLatLng(position));
  }

  void marcar(LatLng position) {
    final Marker marker = Marker(
        markerId: MarkerId("123456"),
        position: position,
        infoWindow: InfoWindow(
          title: searchAddr,
          // snippet: searchAddr ?? "",
        ));
    setState(() {
      markers.add(marker);
    });
  }
}
