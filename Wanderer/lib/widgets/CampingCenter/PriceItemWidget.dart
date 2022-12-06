import 'package:Wanderer/Modules/PriceItem.dart';

import 'package:Wanderer/Services/Utility/CustomColor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_placeholder_textlines/flutter_placeholder_textlines.dart';

class PriceItemWidget extends StatelessWidget {
  final PriceItem _priceItem;
  final bool _isLastItem;
  final Size _screenSize;
  final bool _isHighlighted;
  final bool _loading;
  final bool _withStock;

  PriceItemWidget(this._priceItem,
      {bool isLastItem = false,
      @required Size screenSize,
      bool isHighlighted = false,
      bool withStock = false})
      : this._screenSize = screenSize,
        this._isHighlighted = isHighlighted,
        this._isLastItem = isLastItem,
        this._loading = false,
        this._withStock = withStock;
  PriceItemWidget.loading({@required Size screenSize, bool isLastItem = false})
      : this._screenSize = screenSize,
        this._isHighlighted = false,
        this._isLastItem = isLastItem,
        this._loading = true,
        this._priceItem = null,
        this._withStock = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: _isHighlighted
            ? CustomColor.secondaryHighlight.withAlpha(70)
            : null,
        border: (!_isLastItem)
            ? Border(
                bottom:
                    BorderSide(color: CustomColor.backgroundColor, width: 2))
            : null,
      ),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12.5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Container(
                    child: !_loading
                        ? Text(
                            _priceItem.label,
                            style: TextStyle(
                                fontSize: 16,
                                color: CustomColor.highlightText
                                    .withAlpha(_isHighlighted ? 220 : 180)),
                          )
                        : PlaceholderLines(
                            count: 1,
                            animate: true,
                            lineHeight: 16,
                            color: Colors.grey,
                          )),
              ),
              Container(
                width: _screenSize.width * 0.2,
                child: !_loading
                    ? Row(
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            _priceItem.price.toString(),
                            style: TextStyle(
                                fontSize: 16,
                                color: CustomColor.highlightText
                                    .withAlpha(_isHighlighted ? 220 : 180)),
                          ),
                          Text(
                            " " + _priceItem.currency,
                            style: TextStyle(
                                fontSize: 12,
                                color: CustomColor.highlightText
                                    .withAlpha(_isHighlighted ? 180 : 150)),
                          )
                        ],
                      )
                    : PlaceholderLines(
                        count: 1,
                        animate: true,
                        lineHeight: 16,
                        color: Colors.grey,
                      ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Container(
                    margin: EdgeInsets.only(top: 3),
                    child: !_loading
                        ? Container(
                            child: (_priceItem.description != null &&
                                    _priceItem.description.isNotEmpty)
                                ? Text(
                                    _priceItem.description,
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: CustomColor.highlightText
                                            .withAlpha(
                                                _isHighlighted ? 180 : 150)),
                                  )
                                : null)
                        : Container(
                            margin: EdgeInsets.only(top: 5),
                            child: PlaceholderLines(
                              count: 1,
                              animate: true,
                              color: Colors.grey,
                              maxOpacity: 0.5,
                            ))),
              ),
              _withStock
                  ? Container(
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                            "${_priceItem.reservedStock} reserved out of ${_priceItem.totalStock}",
                            style: TextStyle(
                                fontSize: 12,
                                color:
                                    CustomColor.highlightText.withAlpha(180))),
                      ),
                    )
                  : Container(),
            ],
          ),
        ],
      ),
    );
  }
}
