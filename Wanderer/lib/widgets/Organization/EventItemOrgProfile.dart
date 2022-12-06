import 'package:Wanderer/Modules/OrganizedEvent.dart';
import 'package:Wanderer/Screens/Organization/OrganizationRole/UpdateEventDetails.dart';
import 'package:Wanderer/Services/Utility/CustomColor.dart';
import 'package:Wanderer/Services/Utility/DateService.dart';
import 'package:flutter/material.dart';

class EventItemOrgProfile extends StatelessWidget {
  EventItemOrgProfile({@required item, @required height, @required featured})
      : this._item = item,
        this._height = height,
        this._featured = featured;

  final OrganizedEvent _item;
  final double _height;
  final bool _featured;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, UpdateEventDetails.routeName,
            arguments: _item);
      },
      child: Container(
        height: MediaQuery.of(context).size.width * _height,
        width: double.infinity,
        margin: new EdgeInsets.fromLTRB(30, 10, 30, 0),
        decoration: BoxDecoration(
          border:
              _featured ? Border.all(color: Color(0xffffd700), width: 3) : null,
          image: DecorationImage(
            image: NetworkImage(_item.previewPicture),
            fit: BoxFit.cover,
          ),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Stack(
          children: [
            Container(
              padding: EdgeInsets.all(0),
              alignment: Alignment.bottomCenter,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: <Color>[
                    Colors.black,
                    Colors.black45,
                    Colors.black.withAlpha(1),
                  ],
                ),
              ),
            ),
            Container(
              padding: new EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(_item.name,
                      style: TextStyle(
                        //fontWeight: FontWeight.bold,
                        color: CustomColor.highlightText,
                        fontSize: 21,
                      )),
                  SizedBox(
                    height: 3,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Icon(Icons.location_pin,
                                size: 20,
                                color: CustomColor.interactableAccent
                                    .withAlpha(220)),
                            Text(
                              _item.startCity,
                              style: TextStyle(
                                  fontSize: 15,
                                  color: CustomColor.interactableAccent
                                      .withAlpha(220)),
                            ),
                          ],
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              _item.date.humanReadableDate(),
                              style: TextStyle(
                                  fontSize: 15,
                                  color: CustomColor.interactableAccent
                                      .withAlpha(220)),
                            ),
                            /*Text(' (${_item.numbRating})',
                                style: TextStyle(
                                    color: Color(0xffe7accf).withAlpha(210)))*/
                          ],
                        ),
                      ],
                    ),
                  )
                  /*RichText(
                    text: TextSpan(
                      children: [
                        WidgetSpan(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 2.0),
                            child: Icon(Icons.location_pin,
                                color: Color(0xffe7accf)),
                          ),
                        ),
                        TextSpan(text: _item.city),
                      ],
                    ),
                  )*/
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
