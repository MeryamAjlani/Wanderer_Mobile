import 'package:Wanderer/Services/Utility/ImageService.dart';
import 'package:flutter/material.dart';

import 'package:carousel_slider/carousel_slider.dart';

class Carousel extends StatefulWidget {
  Carousel({Key key, @required this.rawPictures})
      : this.smallPictures = rawPictures.map((rawPic) {
          return ImageService.imageUrl(rawPic, height: 256);
        }).toList(),
        this.largePictures = rawPictures.map((rawPic) {
          return ImageService.imageUrl(rawPic);
        }).toList(),
        picIndex = Iterable<int>.generate(rawPictures.length).toList(),
        super(key: key);

  final List rawPictures;
  final List smallPictures;
  final List largePictures;
  final List<int> picIndex;

  @override
  _CarouselState createState() => _CarouselState();
}

class _CarouselState extends State<Carousel> {
  List largePictures;

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
        items: widget.picIndex.map((index) {
          return InkWell(
            onTap: () {
              ImageService.previewPicture(context, widget.largePictures[index]);
            },
            child: new Container(
              width: MediaQuery.of(context).size.width,
              decoration: new BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(widget.smallPictures[index]))),
            ),
            //  onTap: () => {
            //   ImageDisplayer(
            //   galleryItems: itemModule.pictures)
            // },
          );
        }).toList(),
        options: CarouselOptions(
          height: 200.0,
          enlargeCenterPage: true,
          autoPlay: true,
          aspectRatio: 16 / 9,
          autoPlayCurve: Curves.fastOutSlowIn,
          enableInfiniteScroll: true,
          autoPlayAnimationDuration: Duration(milliseconds: 800),
          viewportFraction: 0.8,
        ));
  }
}
