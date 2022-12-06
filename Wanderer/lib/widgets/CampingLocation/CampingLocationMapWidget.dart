import 'package:Wanderer/Modules/CampingLocation.dart';
import 'package:Wanderer/Services/Utility/CustomColor.dart';

import 'package:Wanderer/widgets/CampingLocation/BottomSheetLocationModal.dart';
import 'package:Wanderer/widgets/CampingLocation/CampingLocationMarker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import "package:latlong/latlong.dart";
import 'package:Wanderer/Services/CampingLocationService.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';

class CampingLocationMapWidget extends StatefulWidget {
  @override
  _CampingLocationMapWidgetState createState() =>
      _CampingLocationMapWidgetState();
}

class _CampingLocationMapWidgetState extends State<CampingLocationMapWidget> {
  MapController mapController;
  List<CampingLocation> locationList = List<CampingLocation>();
  //final double maxZoom = 18;
  //final double minZoom = 5;
  @override
  void initState() {
    super.initState();
    mapController = MapController();
    fetch();
  }

  void fetch() async {
    var result = await CampingLocationService.getList();
    if (result != null)
      setState(() {
        locationList = result;
      });
  }

  void moveSmoothly(
      LatLng start, LatLng target, double zoomStart, double zoomTarget) async {
    int i = 1;
    int maxDef = 20;
    while (i <= maxDef) {
      await Future.delayed(Duration(milliseconds: 3));
      double screenToMapHeight =
          (mapController.bounds.north - mapController.bounds.south);
      print(screenToMapHeight);
      mapController.move(
          LatLng(
              doubleLerp(start.latitude,
                  target.latitude - screenToMapHeight * 0.3, i / maxDef),
              doubleLerp(start.longitude, target.longitude, i / maxDef)),
          doubleLerp(zoomStart, zoomTarget, i / maxDef));
      i++;
    }
  }

  double doubleLerp(double start, double end, double t) {
    return start - (start - end) * t;
  }

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      mapController: mapController,
      options: MapOptions(
        interactiveFlags: InteractiveFlag.drag +
            InteractiveFlag.doubleTapZoom +
            InteractiveFlag.pinchMove +
            InteractiveFlag.pinchZoom,
        bounds: LatLngBounds(LatLng(37.547459301915055, 7.386724113072322),
            LatLng(29.97711908436393, 11.869145796004075)),
        plugins: [
          MarkerClusterPlugin(),
        ],
        //zoom: 7,
      ),
      layers: [
        TileLayerOptions(
            backgroundColor: Colors.grey,
            urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
            subdomains: ['a', 'b', 'c']),
        /*MarkerLayerOptions(
          markers: [
            ...locationList.map((location) {
              print(location.name);
              return Marker(
                width: 45,
                height: 45,
                point: LatLng(location.coordLat, location.coordLon),
                builder: (ctx) => CampingLocationMarker(location),
              );
            }).toList()
          ],
        ),*/
        MarkerClusterLayerOptions(
          centerMarkerOnClick: false,
          onClusterTap: (_) {
            print("cluster tapped");
          },
          onMarkerTap: (marker) {
            print("marker tapped");
            CampingLocation location =
                (marker.builder(context) as CampingLocationMarker).getInfo();
            double zoom = mapController.zoom;
            if (zoom < 10) zoom = 10;
            /*mapController.move(
                LatLng(
                    location.coordLat - 0.25 * (), location.coordLon),
                zoom);*/
            print(zoom);
            moveSmoothly(
                mapController.center,
                LatLng(location.coordLat, location.coordLon),
                mapController.zoom,
                zoom);
            BottomSheetLocationModal.show(context, location);
          },
          maxClusterRadius: 120,
          size: Size(60, 60),
          fitBoundsOptions: FitBoundsOptions(
            padding: EdgeInsets.all(20),
          ),
          markers: [
            ...locationList.map((location) {
              print(location.name);
              return Marker(
                width: 45,
                height: 45,
                point: LatLng(location.coordLat, location.coordLon),
                builder: (ctx) => CampingLocationMarker(location),
              );
            }).toList()
          ],
          polygonOptions: PolygonOptions(
              borderColor: CustomColor.interactable,
              color: CustomColor.interactable.withAlpha(100),
              borderStrokeWidth: 3),
          builder: (context, markers) {
            return Stack(
              clipBehavior: Clip.none,
              children: [
                (markers.length > 2)
                    ? Positioned(
                        top: 7,
                        left: 7,
                        child: CircleAvatar(
                            backgroundColor: CustomColor.interactable,
                            child: Container(
                              margin: EdgeInsets.all(2),
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle, color: Colors.black),
                            )))
                    : Container(),
                Positioned(
                    top: 3.5,
                    left: 3.5,
                    child: CircleAvatar(
                      backgroundColor: CustomColor.interactable,
                      child: Container(
                        margin: EdgeInsets.all(2),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle, color: Colors.black),
                      ),
                    )),
                markers[0].builder(context),
                /*Container(
                  margin: EdgeInsets.all(2),
                  decoration: BoxDecoration(
                      color: Colors.black38, shape: BoxShape.circle),
                ),
                Center(
                    child: Text(
                  markers.length.toString(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ))*/
              ],
            );
          },
        ),
      ],
    );
  }
}
