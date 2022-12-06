import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class ImageDisplayer extends StatefulWidget {
   static final String routeName = "/Viewer";
  final List galleryItems;
  const ImageDisplayer({Key key,this.galleryItems}) : super(key: key);

  @override
  _ImageDisplayerState createState() => _ImageDisplayerState();
}

class _ImageDisplayerState extends State<ImageDisplayer> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: PhotoViewGallery.builder(
      scrollPhysics: const BouncingScrollPhysics(),
      builder: (BuildContext context, int index) {
        return PhotoViewGalleryPageOptions(
          imageProvider: AssetImage(widget.galleryItems[index].image),
          initialScale: PhotoViewComputedScale.contained * 0.8,
          heroAttributes: PhotoViewHeroAttributes(tag: widget.galleryItems[index].id),
        );
      },
      itemCount: widget.galleryItems.length,
      loadingBuilder: (context, event) => Center(
        child: Container(
          width: 20.0,
          height: 20.0,
          child: CircularProgressIndicator(
            value: event == null
                ? 0
                : event.cumulativeBytesLoaded / event.expectedTotalBytes,
          ),
        ),
      ),
      //backgroundDecoration: widget.backgroundDecoration,
      //pageController: widget.pageController,
      //onPageChanged: onPageChanged,
    ));
  }
}
