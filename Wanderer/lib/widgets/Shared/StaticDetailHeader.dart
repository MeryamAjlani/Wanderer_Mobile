import 'package:Wanderer/Services/Utility/CustomColor.dart';
import 'package:flutter/material.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class StaticDetailHeader extends StatefulWidget {
  final String _imagePath;
  final Size _screenSize;
  final String _name;
  final String _city;
  final double _rating;
  final double _heighFactor;
  StaticDetailHeader(
      {@required String imagePath,
      @required Size screenSize,
      @required String centerName,
      @required String city,
      @required double rating,
      double heightFactor = 0.75})
      : this._imagePath = imagePath,
        this._screenSize = screenSize,
        this._name = centerName,
        this._city = city,
        this._rating = rating,
        this._heighFactor = heightFactor;

  @override
  _StaticDetailHeaderState createState() => _StaticDetailHeaderState();
}

class _StaticDetailHeaderState extends State<StaticDetailHeader> {
  double scrollOffset = 0.0;
  double halfWidth;
  double quarterWidth;
  double fifthWidth;
  double fullWidth;
  @override
  void initState() {
    super.initState();
    fullWidth = widget._screenSize.width;
    halfWidth = fullWidth * 0.5;
    quarterWidth = halfWidth * 0.5;
    fifthWidth = fullWidth * 0.2;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: fullWidth,
          height: fullWidth * widget._heighFactor + fullWidth * 0.15,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(fifthWidth),
            ),
            color: CustomColor.lightBackground,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withAlpha(100),
                blurRadius: 10,
              )
            ],
          ),
        ),
        Container(
          width: fullWidth,
          height: fullWidth * widget._heighFactor,
          decoration: BoxDecoration(
            borderRadius:
                BorderRadius.only(bottomLeft: Radius.circular(quarterWidth)),
            image: DecorationImage(
                image: NetworkImage(widget._imagePath),
                alignment: Alignment.bottomCenter,
                fit: BoxFit.cover),
          ),
        ),
        Container(
          width: fullWidth,
          height: fullWidth * widget._heighFactor,
          decoration: BoxDecoration(
              borderRadius:
                  BorderRadius.only(bottomLeft: Radius.circular(quarterWidth)),
              gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.center,
                  colors: [Colors.black.withOpacity(0.5), Colors.transparent])),
        ),
        Container(
          padding: EdgeInsets.only(left: fullWidth * 0.17, right: 20),
          width: fullWidth,
          height: fullWidth * widget._heighFactor + fullWidth * 0.17,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(bottom: fullWidth * 0.08),
                child: Text(
                  widget._name,
                  style: TextStyle(
                      color: CustomColor.highlightText,
                      fontWeight: FontWeight.w400,
                      fontSize: 30),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.only(bottom: fullWidth * 0.05),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.map_outlined,
                          size: 22,
                          color: CustomColor.primaryText,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Container(
                          child: Text(
                            widget._city,
                            style: TextStyle(
                                color: CustomColor.primaryText, fontSize: 17),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(bottom: fullWidth * 0.06),
                    child: SmoothStarRating(
                      isReadOnly: true,
                      allowHalfRating: true,
                      borderColor: CustomColor.secondaryText,
                      rating: widget._rating,
                      size: fullWidth * 0.07,
                      color: CustomColor.primaryText,
                    ),
                  ),
                ],
              )
            ],
          ),
        )
      ],
    );
  }
}
