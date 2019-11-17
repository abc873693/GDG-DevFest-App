import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_devfest/home/session.dart';
import 'package:flutter_devfest/home/speaker.dart';
import 'package:flutter_devfest/universal/dev_scaffold.dart';
import 'package:flutter_devfest/utils/tools.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class SessionDetail extends StatelessWidget {
  static const String routeName = "/session_detail";
  final Session session;

  SessionDetail({Key key, this.session}) : super(key: key);

  Widget socialActions(context, Speaker speaker) => FittedBox(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            IconButton(
              icon: Icon(
                FontAwesomeIcons.github,
                size: 0,
              ),
              onPressed: null,
            ),
            if (speaker?.fbUrl != null && speaker.fbUrl.isNotEmpty)
              IconButton(
                icon: Icon(
                  FontAwesomeIcons.facebookF,
                  size: 15,
                ),
                onPressed: () {
                  launch(speaker?.fbUrl);
                },
              ),
            if (speaker?.twitterUrl != null && speaker.twitterUrl.isNotEmpty)
              IconButton(
                icon: Icon(
                  FontAwesomeIcons.twitter,
                  size: 15,
                ),
                onPressed: () {
                  launch(speaker?.twitterUrl);
                },
              ),
            if (speaker?.linkedinUrl != null && speaker.linkedinUrl.isNotEmpty)
              IconButton(
                icon: Icon(
                  FontAwesomeIcons.linkedinIn,
                  size: 15,
                ),
                onPressed: () {
                  launch(speaker?.linkedinUrl);
                },
              ),
            if (speaker?.githubUrl != null && speaker.githubUrl.isNotEmpty)
              IconButton(
                icon: Icon(
                  FontAwesomeIcons.github,
                  size: 15,
                ),
                onPressed: () {
                  launch(speaker?.githubUrl);
                },
              ),
            IconButton(
              icon: Icon(
                FontAwesomeIcons.github,
                size: 0,
              ),
              onPressed: null,
            ),
          ],
        ),
      );

  Widget linksActions(context, Links links) => FittedBox(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            IconButton(
              icon: Icon(
                FontAwesomeIcons.github,
                size: 0,
              ),
              onPressed: null,
            ),
            if (links?.presentation != null && links.presentation.isNotEmpty)
              IconButton(
                icon: Icon(
                  FontAwesomeIcons.filePowerpoint,
                  size: 15,
                ),
                onPressed: () {
                  launch(links?.presentation);
                },
              ),
            if (links?.video != null && links.video.isNotEmpty)
              IconButton(
                icon: Icon(
                  FontAwesomeIcons.video,
                  size: 15,
                ),
                onPressed: () {
                  launch(links?.video);
                },
              ),
            if (links?.hackmd != null && links.hackmd.isNotEmpty)
              IconButton(
                icon: Icon(
                  Icons.speaker_notes,
                  size: 15,
                ),
                onPressed: () {
                  launch(links?.hackmd);
                },
              ),
            IconButton(
              icon: Icon(
                FontAwesomeIcons.github,
                size: 0,
              ),
              onPressed: null,
            ),
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    // var _homeBloc = HomeBloc();
    Session session = ModalRoute.of(context).settings.arguments;
    if (this.session != null) {
      session = this.session;
    }
    return DevScaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Center(
                child: Hero(
                  tag: session.hashCode,
                  child: CircleAvatar(
                    radius: 100.0,
                    backgroundColor: Colors.transparent,
                    backgroundImage: session.speaker?.speakerImage != null &&
                            session.speaker.speakerImage.isNotEmpty
                        ? ((kIsWeb)
                            ? NetworkImage(session.speaker.speakerImage)
                            : CachedNetworkImageProvider(
                                session.speaker.speakerImage,
                              ))
                        : null,
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "${session.speaker?.speakerDesc ?? ''}",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.title.copyWith(
                      fontSize: 14,
                      color: Tools.multiColors[Random().nextInt(4)],
                    ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "${session.sessionTitle}",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.title.copyWith(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                session.sessionDesc,
                textAlign: TextAlign.center,
                style:
                    Theme.of(context).textTheme.caption.copyWith(fontSize: 13),
              ),
              SizedBox(
                height: 20,
              ),
              Wrap(
                children: <Widget>[
                  for (var i = 0; i < session.tags.length; i++) ...[
                    Chip(
                      backgroundColor: Tools.tagToColor(session.tags[i]),
                      label: Text(
                        Tools.tagToName(session.tags[i]),
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    if (i != session.tags.length - 1) SizedBox(width: 8)
                  ]
                ],
              ),
              SizedBox(
                height: 20,
              ),
              socialActions(context, session.speaker),
              linksActions(context, session.links),
            ],
          ),
        ),
      ),
      title: session.speaker?.speakerName ?? '',
    );
  }
}
