import 'dart:ffi';

class OrganizationModel {
  String id;
  String email;
  String name;
  String description;
  String city;
  int phone;
  String doc;
  String img;
  int tents;
  int sleepingBags;
  double rating;

  OrganizationModel(
      {String id,
      String email,
      String name,
      String description,
      String city,
      int phone,
      String doc,
      String img,
      int tents,
      int sleepingBags,
      double rating})
      : this.id = id,
        this.email = email,
        this.name = name,
        this.description = description,
        this.city = city,
        this.phone = phone,
        this.doc = doc,
        this.img = img,
        this.tents = tents,
        this.sleepingBags = sleepingBags,
        this.rating = rating;
  OrganizationModel.init(String email) {
    this.email = email;
  }
  factory OrganizationModel.fromJson(dynamic json) {
    OrganizationModel org = OrganizationModel(
        id: json['_id'],
        email: json['email'],
        name: json['fullname'],
        description: (json['profile'][0]['description'] != null)
            ? json['profile'][0]['description']
            : 'none',
        city: (json['profile'][0]['city'] != null)
            ? json['profile'][0]['city']
            : 'city',
        phone: (json['profile'][0]['phoneNumber'] != null)
            ? json['profile'][0]['phoneNumber']
            : 216,
        doc: (json['profile'][0]['dateOfCreation'] != null)
            ? json['profile'][0]['dateOfCreation']
            : '2001-01-01',
        img: (json['profile'][0]['img'] != null)
            ? json['profile'][0]['img']
            : 'profileImagePlaceholder',
        tents: (json['profile'][0]['tents'] != null)
            ? json['profile'][0]['tents']
            : 0,
        sleepingBags: (json['profile'][0]['sleepingBags'] != null)
            ? json['profile'][0]['sleepingBags']
            : 0,
        rating: (json['profile'][0]['rating'] != null)
            ? json['profile'][0]['rating'] + 0.0
            : 0.0);

    return (org);
  }
  factory OrganizationModel.UpdateProfilefromJson(
      OrganizationModel old, dynamic json) {
    OrganizationModel org = OrganizationModel(
        id: old.id,
        email: old.email,
        name: old.name,
        description:
            (json['description'] != null) ? json['description'] : 'none',
        city: (json['city'] != null) ? json['city'] : 'city',
        doc: (json['dateOfCreation'] != null)
            ? json['dateOfCreation']
            : '2001-01-01',
        img: (json['img'] != null) ? json['img'] : 'profileImagePlaceholder',
        tents: (json['tents'] != null) ? json['tents'] : 0,
        sleepingBags: (json['sleepingBags'] != null) ? json['sleepingBags'] : 0,
        rating: (json['rating'] != null) ? json['rating'] + 0.0 : 0.0);

    return (org);
  }
  OrganizationModel copy() {
    return OrganizationModel(
        id: id,
        email: email,
        name: name,
        description: description,
        city: city,
        phone: phone,
        doc: doc,
        img: img,
        tents: tents,
        sleepingBags: sleepingBags,
        rating: rating);
  }
}
