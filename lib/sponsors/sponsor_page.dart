import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_devfest/home/home_bloc.dart';
import 'package:flutter_devfest/home/home_state.dart';
import 'package:flutter_devfest/universal/dev_scaffold.dart';
import 'package:flutter_devfest/utils/app_localizations.dart';
import 'package:url_launcher/url_launcher.dart';

class SponsorPage extends StatelessWidget {
  static const String routeName = "/sponsor";

  @override
  Widget build(BuildContext context) {
    var _homeBloc = HomeBloc();
    var state = _homeBloc.currentState as InHomeState;
    var sponsors = state.sponsorsData.sponsors;
    return DevScaffold(
      body: ListView.separated(
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Column(
              children: <Widget>[
                if (sponsors[index].image != null &&
                    sponsors[index].image.isNotEmpty)
                  SponsorImage(
                    imgUrl: sponsors[index].image,
                    level: sponsors[index].level,
                  ),
                SizedBox(height: 8),
                Text(sponsors[index].name),
              ],
            ),
            subtitle: Center(
              child: Text(sponsors[index].desc),
            ),
            onTap: () {
              launch(sponsors[index].url);
            },
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return SizedBox(
            height: 20,
          );
        },
        itemCount: sponsors.length,
      ),
      title: AppLocalizations.of(context).sponsor,
    );
  }
}

class SponsorImage extends StatelessWidget {
  final String imgUrl;
  final String level;

  const SponsorImage({Key key, this.imgUrl, this.level}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double size = 50;
    switch (this.level) {
      case "1":
        size = 200;
        break;
      case "2":
        size = 150;
        break;
      case "3":
        size = 100;
        break;
      default:
        size = 50;
        break;
    }
    return Card(
      elevation: 0.0,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: (kIsWeb)
            ? NetworkImage(imgUrl)
            : CachedNetworkImage(
                imageUrl: imgUrl,
                height: size,
                width: size,
                fit: BoxFit.contain,
                errorWidget: (_, __, ___) {
                  return SizedBox(height: 0);
                },
              ),
      ),
    );
  }
}
