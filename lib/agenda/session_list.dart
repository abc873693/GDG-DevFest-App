import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_devfest/agenda/session_detail.dart';
import 'package:flutter_devfest/home/session.dart';
import 'package:flutter_devfest/utils/app_localizations.dart';
import 'package:flutter_devfest/utils/tools.dart';
import 'package:intl/intl.dart';

class SessionList extends StatelessWidget {
  final List<Session> allSessions;

  const SessionList({Key key, @required this.allSessions}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final format = DateFormat('yyyy-MM-DD HH:mm:ss');
    return ListView.builder(
      shrinkWrap: false,
      itemCount: allSessions.length,
      itemBuilder: (c, i) {
        // return Text("sdd");
        return Card(
          elevation: 0.0,
          child: ListTile(
            onTap: allSessions[i].sessionDesc != null &&
                    allSessions[i].sessionDesc != ""
                ? () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SessionDetail(
                          session: allSessions[i],
                        ),
                      ),
                    );
                  }
                : null,
            // dense: true,
            isThreeLine: allSessions[i].tags.length != 0,
            trailing: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                text: "${allSessions[i].sessionTotalTime}"
                    "${AppLocalizations.of(context).minutes}\n",
                style: Theme.of(context)
                    .textTheme
                    .title
                    .copyWith(fontSize: 14, fontWeight: FontWeight.bold),
                children: [
                  TextSpan(
                    text: DateFormat.Hm()
                        .format(format.parse(allSessions[i].sessionStartTime)),
                    style: Theme.of(context).textTheme.subtitle.copyWith(
                          fontSize: 12,
                        ),
                  ),
                ],
              ),
            ),
            leading: Hero(
              tag: allSessions[i].hashCode,
              child: CircleAvatar(
                radius: 30,
                backgroundColor: Colors.transparent,
                backgroundImage: allSessions[i].speaker?.speakerImage != null &&
                        allSessions[i].speaker.speakerImage.isNotEmpty
                    ? CachedNetworkImageProvider(
                        allSessions[i].speaker.speakerImage,
                      )
                    : null,
              ),
            ),
            title: RichText(
              text: TextSpan(
                text: "${allSessions[i].sessionTitle}\n",
                style: Theme.of(context).textTheme.title.copyWith(fontSize: 16),
                children: [
                  TextSpan(
                      text: allSessions[i].speaker?.speakerName ?? '',
                      style: Theme.of(context).textTheme.subtitle.copyWith(
                            fontSize: 14,
                            color: Tools.multiColors[Random().nextInt(4)],
                          ),
                      children: []),
                ],
              ),
            ),
            subtitle: Wrap(
              children: <Widget>[
                for (var j = 0; j < allSessions[i].tags.length; j++) ...[
                  Chip(
                    backgroundColor: Tools.tagToColor(allSessions[i].tags[j]),
                    label: Text(
                      Tools.tagToName(allSessions[i].tags[j]),
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  if (j != allSessions[i].tags.length - 1) SizedBox(width: 8)
                ]
              ],
            ),
          ),
        );
      },
    );
  }
}
