import 'package:Wanderer/Services/Utility/CustomColor.dart';
import 'package:flutter/material.dart';
import 'package:Wanderer/Services/Utility/DateService.dart';

class OrganizedEventDetailHeader extends StatefulWidget {
  final String _imagePath;
  final Size _screenSize;
  final String _name;
  final String _city;
  final ScrollController _scrollController;
  final DateTime _date;
  OrganizedEventDetailHeader({
    @required String imagePath,
    @required Size screenSize,
    @required String centerName,
    @required String city,
    @required ScrollController controller,
    @required DateTime date,
  })  : this._imagePath = imagePath,
        this._screenSize = screenSize,
        this._name = centerName,
        this._city = city,
        this._scrollController = controller,
        this._date = date;

  @override
  _OrganizedEventDetailHeaderState createState() =>
      _OrganizedEventDetailHeaderState();
}

class _OrganizedEventDetailHeaderState
    extends State<OrganizedEventDetailHeader> {
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
    if (widget._scrollController != null)
      widget._scrollController.addListener(_setScroll);
  }

  void _setScroll() {
    double offset = widget._scrollController.offset;
    if (offset > quarterWidth) offset = quarterWidth;
    if (scrollOffset != offset) {
      setState(() {
        scrollOffset = offset;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: -scrollOffset,
      child: Stack(
        children: [
          Container(
            width: fullWidth,
            height: halfWidth + fullWidth * 0.15,
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
            height: halfWidth,
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
            height: halfWidth,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(quarterWidth)),
                gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.center,
                    colors: [
                      Colors.black.withOpacity(0.5),
                      Colors.transparent
                    ])),
          ),
          Container(
            padding: EdgeInsets.only(left: fullWidth * 0.17, right: 20),
            width: fullWidth,
            height: halfWidth + fullWidth * 0.17,
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
                        padding: EdgeInsets.only(bottom: fullWidth * 0.048),
                        child: Text(
                          widget._date.humanReadableDate(),
                          style: TextStyle(color: CustomColor.secondaryText),
                        )),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
