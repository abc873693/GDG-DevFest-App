class DevFestEventsData {
  List<DevFestEvent> devFestEvents;

  DevFestEventsData({this.devFestEvents});

  DevFestEventsData.fromJson(Map<String, dynamic> json) {
    if (json['devFestEvents'] != null) {
      devFestEvents = new List<DevFestEvent>();
      json['devFestEvents'].forEach((v) {
        devFestEvents.add(new DevFestEvent.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.devFestEvents != null) {
      data['devFestEvents'] =
          this.devFestEvents.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DevFestEvent {
  String tag;
  bool isActive;
  bool hasLocalization;
  String name;
  String host;
  String date;
  bool useImageAsset;
  String image;
  String imageAsset;
  String welcomeText;
  String descText;
  Location location;
  Links links;

  DevFestEvent(
      {this.tag,
      this.isActive,
      this.hasLocalization,
      this.name,
      this.host,
      this.date,
      this.useImageAsset,
      this.image,
      this.imageAsset,
      this.welcomeText,
      this.descText,
      this.location,
      this.links});

  DevFestEvent.fromJson(Map<String, dynamic> json) {
    tag = json['tag'];
    isActive = json['isActive'];
    hasLocalization = json['hasLocalization'];
    name = json['name'];
    host = json['host'];
    date = json['date'];
    useImageAsset = json['useImageAsset'];
    image = json['image'];
    imageAsset = json['imageAsset'];
    welcomeText = json['welcomeText'];
    descText = json['descText'];
    location = json['location'] != null
        ? new Location.fromJson(json['location'])
        : null;
    links = json['links'] != null ? new Links.fromJson(json['links']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['tag'] = this.tag;
    data['isActive'] = this.isActive;
    data['hasLocalization'] = this.hasLocalization;
    data['name'] = this.name;
    data['host'] = this.host;
    data['date'] = this.date;
    data['useImageAsset'] = this.useImageAsset;
    data['image'] = this.image;
    data['imageAsset'] = this.imageAsset;
    data['welcomeText'] = this.welcomeText;
    data['descText'] = this.descText;
    if (this.location != null) {
      data['location'] = this.location.toJson();
    }
    if (this.links != null) {
      data['links'] = this.links.toJson();
    }
    return data;
  }
}

class Location {
  String name;
  String mapTitle;
  String mapSubTitle;
  double lat;
  double lng;

  Location({this.name, this.mapTitle, this.mapSubTitle, this.lat, this.lng});

  Location.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    mapTitle = json['mapTitle'];
    mapSubTitle = json['mapSubTitle'];
    lat = json['lat'];
    lng = json['lng'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['mapTitle'] = this.mapTitle;
    data['mapSubTitle'] = this.mapSubTitle;
    data['lat'] = this.lat;
    data['lng'] = this.lng;
    return data;
  }
}

class Links {
  String facebook;
  String twitter;
  String linkedinIn;
  String youtube;
  String meetup;
  String emailUrl;
  String telegram;
  String registration;

  Links(
      {this.facebook,
      this.twitter,
      this.linkedinIn,
      this.youtube,
      this.meetup,
      this.emailUrl,
      this.telegram});

  Links.fromJson(Map<String, dynamic> json) {
    facebook = json['facebook'];
    twitter = json['twitter'];
    linkedinIn = json['linkedinIn'];
    youtube = json['youtube'];
    meetup = json['meetup'];
    emailUrl = json['emailUrl'];
    telegram = json['telegram'];
    registration = json['registration'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['facebook'] = this.facebook;
    data['twitter'] = this.twitter;
    data['linkedinIn'] = this.linkedinIn;
    data['youtube'] = this.youtube;
    data['meetup'] = this.meetup;
    data['emailUrl'] = this.emailUrl;
    data['telegram'] = this.telegram;
    data['registration'] = this.registration;
    return data;
  }
}

DevFestEvent devFestEvent = DevFestEvent(
  tag: "gdg",
  name: "DevFest",
  date: "2019/10/19",
  image: "https://jamaicandevelopers.com/p/devfest-2019/@@images/image",
  welcomeText: "Welcome to GDG DevFest",
  descText:
      "''DevFests are community-led, developer events hosted by GDG chapters around the globe focused on community building & learning about Google’s technologies. Each DevFest is inspired by and uniquely tailored to the needs of the developer community and region that hosts it.''",
  location: Location(
    name: "Your Location",
    mapTitle: "Google Office",
    mapSubTitle: "Shoreline Amphitheatre, Mountain View, CA",
    lat: 37.42796133580664,
    lng: -122.085749655962,
  ),
  links: Links(
    facebook: "https://facebook.com/imthepk",
    twitter: "https://twitter.com/imthepk",
    linkedinIn: "https://linkedin.com/in/imthepk",
    youtube: "https://youtube.com/mtechviral",
    meetup: "https://meetup.com/",
    emailUrl:
        "''mailto:mtechviral@gmail.com?subject=Support Needed For DevFest App&body={Name: Pawan Kumar},Email: pawan221b@gmail.com}''",
  ),
);
