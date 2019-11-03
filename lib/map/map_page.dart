import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_devfest/config/config_bloc.dart';
import 'package:flutter_devfest/config/devfest_event.dart';
import 'package:flutter_devfest/universal/dev_scaffold.dart';
import 'package:flutter_devfest/utils/app_localizations.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class MapPage extends StatefulWidget {
  static const String routeName = "/map";

  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  DevFestEvent get _devFestEvent => ConfigBloc().devFestEvent;

  GoogleMapController _controller;
  bool isMapCreated = false;
  static final LatLng myLocation = LatLng(
    ConfigBloc().devFestEvent.location.lat,
    ConfigBloc().devFestEvent.location.lng,
  );

  @override
  void initState() {
    super.initState();
  }

  final CameraPosition _kGooglePlex = CameraPosition(
    target: myLocation,
    zoom: 14.4746,
  );

  Set<Marker> _createMarker() {
    return <Marker>[
      Marker(
          markerId: MarkerId("marker_1"),
          position: myLocation,
          icon: BitmapDescriptor.defaultMarkerWithHue(
            BitmapDescriptor.hueOrange,
          )),
    ].toSet();
  }

  changeMapMode() {
    if (ConfigBloc().darkModeOn) {
      getJsonFile("assets/nightmode.json").then(setMapStyle);
    } else {
      getJsonFile("assets/daymode.json").then(setMapStyle);
    }
  }

  Future<String> getJsonFile(String path) async {
    return await rootBundle.loadString(path);
  }

  void setMapStyle(String mapStyle) {
    _controller.setMapStyle(mapStyle);
  }

  @override
  Widget build(BuildContext context) {
    if (isMapCreated) {
      changeMapMode();
    }
    return DevScaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 1.0),
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            GoogleMap(
              mapType: MapType.normal,
              zoomGesturesEnabled: true,
              myLocationButtonEnabled: true,
              myLocationEnabled: true,
              markers: _createMarker(),
              initialCameraPosition: _kGooglePlex,
              onMapCreated: (GoogleMapController controller) {
                _controller = controller;
                isMapCreated = true;
                changeMapMode();
                setState(() {});
              },
            ),
            IgnorePointer(
              child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                        text: "${_devFestEvent.location.mapTitle}\n",
                        style: Theme.of(context).textTheme.title.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                        children: [
                          TextSpan(
                              text: "${_devFestEvent.location.mapSubTitle}",
                              style: Theme.of(context).textTheme.subtitle,
                              children: []),
                        ]),
                  )),
            ),
            Align(
              alignment: Alignment(0.0, 0.9),
              child: FloatingActionButton.extended(
                onPressed: () async {
                  final lat = ConfigBloc().devFestEvent.location.lat,
                      lng = ConfigBloc().devFestEvent.location.lng;
                  String googleiOSUrl = 'comgooglemaps://?daddr=$lat,$lng';
                  String appleUrl = 'https://maps.apple.com/?sll=$lat,$lng';
                  //String android = 'geo:$lat,$lng';
                  String androidApp = 'google.navigation:q=$lat,$lng';
                  if (await canLaunch(androidApp)) {
                    await launch(androidApp);
                  } else if (await canLaunch(googleiOSUrl)) {
                    await launch(googleiOSUrl);
                  } else if (await canLaunch(appleUrl)) {
                    await launch(appleUrl);
                  } else {
                    throw 'Could not launch url';
                  }
                },
                label: Text(
                  AppLocalizations.of(context).navigate,
                  style: TextStyle(color: Colors.white),
                ),
                icon: Icon(
                  Icons.navigation,
                  color: Colors.white,
                ),
                backgroundColor: Colors.blue,
              ),
            )
          ],
        ),
      ),
      title: AppLocalizations.of(context).map,
    );
  }
}
