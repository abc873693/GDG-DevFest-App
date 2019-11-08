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
            leading: SponsorImage(
              imgUrl: sponsors[index].image,
            ),
            title: Text(sponsors[index].name),
            subtitle: Text(sponsors[index].desc),
            onTap: () {
              launch(sponsors[index].url);
            },
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return SizedBox(
            height: 30,
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

  const SponsorImage({Key key, this.imgUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0.0,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: (kIsWeb)
            ? NetworkImage(imgUrl)
            : CachedNetworkImage(
                imageUrl: imgUrl,
                height: 50.0,
                width: 50.0,
                fit: BoxFit.contain,
              ),
      ),
    );
  }
}
