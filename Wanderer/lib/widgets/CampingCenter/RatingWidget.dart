import 'package:Wanderer/Modules/RatingModule.dart';
import 'package:Wanderer/Services/Utility/CustomColor.dart';
import 'package:Wanderer/widgets/Shared/ClippingStyled.dart';

import 'package:flutter/material.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter_placeholder_textlines/flutter_placeholder_textlines.dart';

import 'ReadMoreText.dart';

class RatingWidget extends StatelessWidget {
  final RatingModule _ratingModule;
  final bool _isLastItem;
  final bool _loading;
  RatingWidget(this._ratingModule, {bool isLastItem: false})
      : this._isLastItem = isLastItem,
        this._loading = false;
  RatingWidget.loading({RatingSpecial ratingSpecial})
      : this._ratingModule = RatingModule(
            special: ratingSpecial,
            rating: null,
            content: null,
            date: null,
            userName: null),
        _isLastItem = false,
        _loading = true;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: _isLastItem ? 0 : 40),
      child: Stack(
        children: [
          Column(
            children: [
              SizedBox(
                height: 17,
              ),
              ClippingStyled(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  decoration: BoxDecoration(
                    color: CustomColor.lightBackground,
                  ),
                  child: Column(
                    children: [
                      !_loading
                          ? ReadMoreText(
                              text: _ratingModule.content,
                              style: TextStyle(color: CustomColor.primaryText),
                            )
                          : PlaceholderLines(
                              count: 3,
                              animate: true,
                              color: Colors.grey,
                            ),
                      Container(
                        padding: EdgeInsets.only(top: 7.5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Icon(
                              Icons.format_quote,
                              color: CustomColor.secondaryText,
                            ),
                            Expanded(
                              child: !_loading
                                  ? Text(
                                      _ratingModule.userName,
                                      style: TextStyle(
                                          color: CustomColor.secondaryText,
                                          fontSize: 17),
                                      overflow: TextOverflow.clip,
                                      maxLines: 1,
                                    )
                                  : PlaceholderLines(
                                      count: 1,
                                      animate: true,
                                      color: Colors.grey,
                                    ),
                            ),
                            !_loading
                                ? Text(
                                    formatDate(_ratingModule.date,
                                        [dd, '-', mm, '-', yyyy]),
                                    style: TextStyle(
                                        color: CustomColor.secondaryText),
                                  )
                                : Container(
                                    width: 100,
                                    child: PlaceholderLines(
                                      count: 1,
                                      animate: true,
                                      color: Colors.grey,
                                    ),
                                  ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                radius: 30,
              ),
            ],
          ),
          Container(
            alignment: Alignment.center,
            child: SmoothStarRating(
              allowHalfRating: true,
              isReadOnly: true,
              borderColor: CustomColor.secondaryHighlight,
              size: 30,
              color: CustomColor.secondaryHighlight,
              rating: !_loading ? _ratingModule.rating : 5,
            ),
          ),
          Container(
            child: (_ratingModule.special != RatingSpecial.Normal)
                ? Positioned(
                    top: 6,
                    child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 3),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                            border: Border.all(
                                color: _ratingModule.specialColor(), width: 1),
                            color: CustomColor.backgroundColor),
                        child: Text(
                          _ratingModule.specialText(),
                          style: TextStyle(color: _ratingModule.specialColor()),
                        )),
                  )
                : null,
          )
        ],
      ),
    );
  }
}
