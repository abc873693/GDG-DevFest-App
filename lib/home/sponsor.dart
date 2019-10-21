class SponsorsData {
  List<Sponsor> sponsors;

  SponsorsData({this.sponsors});

  SponsorsData.fromJson(Map<String, dynamic> json) {
    if (json['sponsors'] != null) {
      sponsors = new List<Sponsor>();
      json['sponsors'].forEach((v) {
        sponsors.add(Sponsor.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.sponsors != null) {
      data['sponsors'] = this.sponsors.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Sponsor {
  String name;
  String image;
  String desc;
  String url;
  String logo;

  Sponsor({this.name, this.image, this.desc, this.url, this.logo});

  Sponsor.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    image = json['image'];
    desc = json['desc'];
    url = json['url'];
    logo = json['logo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['image'] = this.image;
    data['desc'] = this.desc;
    data['url'] = this.url;
    data['logo'] = this.logo;
    return data;
  }
}

List<Sponsor> sponsors = [
  Sponsor(
    name: "GDG Kolkata",
    image: "https://devfest.gdgkolkata.org/assets/img/logos/gd.png",
    desc: "Organizer",
    url: "https://devfest.gdgkolkata.org/",
    logo: "",
  ),
  Sponsor(
    name: "Jetbrains",
    image: "https://devfest.gdgkolkata.org/assets/img/jetbrains.png",
    desc: "Slivers Sponsors",
    url: "https://devfest.gdgkolkata.org/",
    logo: "",
  ),
  Sponsor(
    name: "Kotlin",
    image:
        "https://upload.wikimedia.org/wikipedia/commons/thumb/7/74/Kotlin-logo.svg/220px-Kotlin-logo.svg.png",
    desc: "Slivers Sponsors",
    url: "https://devfest.gdgkolkata.org/",
    logo: "",
  ),
  Sponsor(
    name: "Firebase",
    image:
        "https://images.g2crowd.com/uploads/product/image/large_detail/large_detail_0016c93c710cf35990b999cba3a59bae/firebase.png",
    desc: "Slivers Sponsors",
    url: "https://devfest.gdgkolkata.org/",
    logo: "",
  ),
];
