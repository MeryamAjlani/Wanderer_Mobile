import 'package:Wanderer/Modules/PriceItem.dart';

import 'package:Wanderer/Services/Utility/CustomColor.dart';

import 'package:Wanderer/widgets/Shared/ClippingStyled.dart';
import 'package:flutter/material.dart';

import 'PriceItemWidget.dart';

class PriceItemList extends StatelessWidget {
  final List<PriceItem> _pricesList;
  final Size _screenSize;
  final bool _withStock;
  PriceItemList(
      {@required double accessPrice,
      @required List<PriceItem> pricesList,
      @required screenSize,
      bool withStock: false,
      String customLabel: 'Access Price :',
      String customDiscription: 'Access fee to the camping grounds',
      bool highlighted})
      : this._pricesList = [
          PriceItem(
              label: customLabel,
              price: accessPrice,
              description: customDiscription),
          ...pricesList
        ],
        this._withStock = withStock,
        this._screenSize = screenSize;
  PriceItemList.loading({@required double accessPrice, @required screenSize})
      : this._pricesList = [
          PriceItem(
            label: 'Access Price :',
            price: accessPrice,
            description: "Access fee to the camping grounds",
          ),
          null,
          null,
          null
        ],
        this._withStock = false,
        this._screenSize = screenSize;

  @override
  Widget build(BuildContext context) {
    return ClippingStyled(
        child: Container(
          decoration: BoxDecoration(
            color: CustomColor.lightBackground,
          ),
          child: ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              padding: EdgeInsets.all(0),
              shrinkWrap: true,
              itemCount: _pricesList.length,
              itemBuilder: (BuildContext ctxt, int index) {
                return Container(
                  child: (_pricesList[index] != null)
                      ? PriceItemWidget(
                          _pricesList[index],
                          withStock: _withStock && index != 0,
                          isHighlighted: index == 0,
                          isLastItem: index == _pricesList.length - 1,
                          screenSize: _screenSize,
                        )
                      : PriceItemWidget.loading(
                          screenSize: _screenSize,
                          isLastItem: index == _pricesList.length - 1,
                        ),
                );
              }),
        ),
        radius: 30);
  }
}
