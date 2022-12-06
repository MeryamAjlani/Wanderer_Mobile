import 'package:flutter/material.dart';

class PreviewPicture {
  final List previewPicture;
  final int category;
  PreviewPicture({@required List previewPicture, @required int category})
      : this.previewPicture = previewPicture,
        this.category = category;

  factory PreviewPicture.fromJson(dynamic json) {
    return PreviewPicture(previewPicture: json['previewPictures'],
    category: json['category']
    );
  }
}
