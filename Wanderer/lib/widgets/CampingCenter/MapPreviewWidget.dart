import 'package:Wanderer/Services/Utility/CustomColor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import "package:latlong/latlong.dart";

class MapPreviewWidget extends StatefulWidget {
  final Size _screenSize;
  final String _street;
  final double _latitude;
  final double _longitude;
  final double _heightRatio;
  MapPreviewWidget(
      {@required Size screenSize,
      @required String street,
      @required double latitude,
      @required double longitude})
      : this._screenSize = screenSize,
        this._street = street,
        this._latitude = latitude,
        this._longitude = longitude,
        this._heightRatio = 0.5;
  MapPreviewWidget.small(
      {@required Size screenSize,
      @required String street,
      @required double latitude,
      @required double longitude})
      : this._screenSize = screenSize,
        this._street = street,
        this._latitude = latitude,
        this._longitude = longitude,
        this._heightRatio = 0.4;

  @override
  _MapPreviewWidgetState createState() => _MapPreviewWidgetState();
}

class _MapPreviewWidgetState extends State<MapPreviewWidget> {
  MapController mapController;
  final double maxZoom = 18;
  final double minZoom = 5;
  @override
  void initState() {
    super.initState();
    mapController = MapController();
  }

  void zoomIn() {
    double zoom = mapController.zoom;
    zoom += 0.6;
    if (zoom > maxZoom) zoom = maxZoom;
    if (mapController.zoom != zoom)
      mapController.move(mapController.center, zoom);
  }

  void zoomOut() {
    double zoom = mapController.zoom;
    zoom -= 0.6;
    if (zoom < minZoom) zoom = minZoom;
    if (mapController.zoom != zoom)
      mapController.move(mapController.center, zoom);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            Container(
              height: widget._screenSize.width * widget._heightRatio,
              child: IgnorePointer(
                child: FlutterMap(
                  mapController: mapController,
                  options: MapOptions(
                    interactive: false,
                    center: LatLng(widget._latitude, widget._longitude),
                    zoom: 7.6,
                  ),
                  layers: [
                    TileLayerOptions(
                        backgroundColor: Colors.grey,
                        urlTemplate:
                            "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                        subdomains: ['a', 'b', 'c']),
                    MarkerLayerOptions(
                      markers: [
                        Marker(
                          width: 80.0,
                          height: 80.0,
                          point: LatLng(widget._latitude, widget._longitude),
                          builder: (ctx) => Container(
                              child: Icon(Icons.location_on_rounded,
                                  color: Colors.red)),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(20),
              height: widget._screenSize.width * widget._heightRatio,
              child: Align(
                alignment: Alignment.centerRight,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                        padding: EdgeInsets.all(10),
                        color: CustomColor.interactable,
                        icon: Icon(
                          Icons.zoom_in,
                          color: CustomColor.interactable,
                          size: 50,
                        ),
                        onPressed: () {
                          zoomIn();
                        }),
                    IconButton(
                        padding: EdgeInsets.all(10),
                        color: CustomColor.interactable,
                        icon: Icon(
                          Icons.zoom_out,
                          color: CustomColor.interactable,
                          size: 50,
                        ),
                        onPressed: () {
                          zoomOut();
                        })
                  ],
                ),
              ),
            ),
          ],
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          decoration: BoxDecoration(color: CustomColor.lightBackground),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                widget._street,
                style: TextStyle(color: CustomColor.secondaryText),
              )
            ],
          ),
        ),
      ],
    );
  }
}
