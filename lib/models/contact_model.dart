import 'dart:io';

import 'package:contact_app/models/lat_lng_model.dart';

class ContactModel {
  String name;
  String phoneNumber;
  String image;
  LatLngModel position;

  ContactModel(
      {required this.name,
      required this.phoneNumber,
      required this.image,
      required this.position});
}
