import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_devfest/config/config_bloc.dart';
import 'package:flutter_devfest/config/config_state.dart';
import 'package:flutter_devfest/home/home_page.dart';
import 'package:flutter_devfest/universal/dev_scaffold.dart';
import 'package:flutter_devfest/utils/app_localizations.dart';
import 'package:flutter_devfest/utils/devfest.dart';
import 'package:flutter_devfest/utils/tools.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';

class FindDevFestPage extends StatelessWidget {
  static const String routeName = "/find";

  @override
  Widget build(BuildContext context) {
    // var _homeBloc = HomeBloc();
    return DevScaffold(
      body: _body(context),
      title: AppLocalizations.of(context).events,
    );
  }

  _body(BuildContext context) {
    var _configBloc = ConfigBloc();
    if (_configBloc.currentState is InConfigState) {
      final events = _configBloc.devFestEventsData.devFestEvents;
      final format = DateFormat('yyyy-MM-DD', _configBloc.languageCode);
      return ListView.builder(
        itemBuilder: (_, index) {
          final event = events[index];
          final date = format.parse(event.date);
          return InkWell(
            onTap: event.isActive
                ? () {
                    ConfigBloc().devFestEvent = events[index];
                    Navigator.pushNamed(context, HomePage.routeName);
                  }
                : null,
            child: Row(
              children: <Widget>[
                SizedBox(width: 8.0),
                Expanded(
                  flex: 1,
                  child: Text(
                    event.isActive
                        ? AppLocalizations.of(context).active
                        : AppLocalizations.of(context).comingSoon,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16.0,
                      color: event.isActive ? Colors.green : Colors.red,
                    ),
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      vertical: 12.0,
                      horizontal: 12.0,
                    ),
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.fitWidth,
                        colorFilter: ColorFilter.mode(
                            Colors.black.withOpacity(0.3), BlendMode.dstATop),
                        image: AssetImage(event.isActive
                            ? event.imageAsset
                            : Devfest.banner_devFest_default),
                      ),
                      color: Colors.black87,
                      borderRadius: BorderRadiusDirectional.circular(24),
                    ),
                    margin: EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Text(
                          event.name,
                          style: TextStyle(
                            fontSize: 24.0,
                            color: Colors.white,
                          ),
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              DateFormat.d().format(date),
                              style: TextStyle(
                                fontSize: 40.0,
                                color: Tools.multiColors[Random().nextInt(4)],
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Row(
                              children: <Widget>[
                                Image.asset(
                                  Devfest.gdg,
                                  width: 30.0,
                                  height: 30.0,
                                ),
                                SizedBox(width: 8.0),
                                Text(
                                  event.host,
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              DateFormat.MMMM(_configBloc.languageCode)
                                  .format(date),
                              style: TextStyle(
                                fontSize: 16.0,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              event.location.name,
                              style: TextStyle(
                                fontSize: 16.0,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 8.0),
              ],
            ),
          );
        },
        itemCount: _configBloc.devFestEventsData.devFestEvents.length,
      );
    } else {
      return Center(
        child: SpinKitChasingDots(
          color: Tools.multiColors[Random().nextInt(3)],
        ),
      );
    }
  }
}
