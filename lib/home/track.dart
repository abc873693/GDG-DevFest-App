class TracksData {
  List<Track> tracks;

  TracksData({this.tracks});

  TracksData.fromJson(Map<String, dynamic> json) {
    if (json['tracks'] != null) {
      tracks = new List<Track>();
      json['tracks'].forEach((v) {
        tracks.add(Track.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.tracks != null) {
      data['tracks'] = this.tracks.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Track {
  String id;
  String title;

  Track({
    this.id,
    this.title,
  });

  Track.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    return data;
  }
}

//*  Tracks hardcoded data
final desc = "The async/await feature allows you to write the asynchronous code in a straightforward way," +
    "without a long list of callbacks. Used in C# for quite a while already, it has proven to be extremely useful.In Kotlin you have async and await as library functions implemented using coroutines." +
    "A coroutine is a light-weight thread that can be suspended and resumed later." +
    "Very precise definition, but might be confusing at first. What 'light-weight thread' means?" +
    "How does suspension work? This talk uncovers the magic. We'll discuss the concept of coroutines," +
    "the power of async/await, and how you can benefit from defining your asynchronous computations using suspend function." +
    " The content of this video was not produced or created by Google.";

//* Tracks can be mobile, web and cloud (Make it web by default or if the track type is not clear.)

List<Track> tracks = [
  Track(
    id: "1",
    title: "Cloud",
  ),
  Track(
    id: "2",
    title: "Mobile",
  ),
  Track(
    id: "3",
    title: "Web & More",
  ),
];
