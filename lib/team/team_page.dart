import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_devfest/home/index.dart';
import 'package:flutter_devfest/home/speaker.dart';
import 'package:flutter_devfest/home/team.dart';
import 'package:flutter_devfest/universal/dev_scaffold.dart';
import 'package:flutter_devfest/utils/app_localizations.dart';
import 'package:flutter_devfest/utils/tools.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class TeamPage extends StatelessWidget {
  static const String routeName = "/team";

  Widget socialActions(context, Team team) => FittedBox(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            if (team.fbUrl != null && team.fbUrl.isNotEmpty)
              IconButton(
                icon: Icon(
                  FontAwesomeIcons.facebookF,
                  size: 15,
                ),
                onPressed: () {
                  launch(team.fbUrl);
                },
              ),
            if (team.twitterUrl != null && team.twitterUrl.isNotEmpty)
              IconButton(
                icon: Icon(
                  FontAwesomeIcons.twitter,
                  size: 15,
                ),
                onPressed: () {
                  launch(team.twitterUrl);
                },
              ),
            if (team.linkedinUrl != null && team.linkedinUrl.isNotEmpty)
              IconButton(
                icon: Icon(
                  FontAwesomeIcons.linkedinIn,
                  size: 15,
                ),
                onPressed: () {
                  launch(team.linkedinUrl);
                },
              ),
            if (team.githubUrl != null && team.githubUrl.isNotEmpty)
              IconButton(
                icon: Icon(
                  FontAwesomeIcons.github,
                  size: 15,
                ),
                onPressed: () {
                  launch(team.githubUrl);
                },
              ),
            IconButton(
              icon: Icon(
                FontAwesomeIcons.github,
                size: 0,
              ),
              onPressed: null,
            )
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    var _homeBloc = HomeBloc();
    var state = _homeBloc.currentState as InHomeState;
    var teams = state.teamsData.teams;
    return DevScaffold(
      body: ListView.builder(
        shrinkWrap: true,
        itemBuilder: (c, i) {
          return Card(
            elevation: 0.0,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ConstrainedBox(
                    constraints: BoxConstraints.expand(
                      height: MediaQuery.of(context).size.height * 0.2,
                      width: MediaQuery.of(context).size.width * 0.3,
                    ),
                    child: (kIsWeb)
                        ? Image.network(teams[i].image)
                        : CachedNetworkImage(
                            fit: BoxFit.cover,
                            imageUrl: teams[i].image,
                            placeholder: (context, url) {
                              return Center(
                                child: SpinKitChasingDots(
                                  color: Tools.multiColors[Random().nextInt(3)],
                                ),
                              );
                            },
                          ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Text(
                              teams[i].name,
                              style: Theme.of(context).textTheme.title,
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            AnimatedContainer(
                              duration: Duration(seconds: 1),
                              width: MediaQuery.of(context).size.width * 0.2,
                              height: 5,
                              color: Tools.multiColors[Random().nextInt(4)],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          teams[i].desc,
                          style: Theme.of(context).textTheme.subtitle,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          teams[i].contribution,
                          style: Theme.of(context).textTheme.caption,
                        ),
                        socialActions(context, teams[i]),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        },
        itemCount: teams.length,
      ),
      title: AppLocalizations.of(context).team,
    );
  }
}
