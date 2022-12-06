import 'package:Wanderer/Modules/EditPriceItem.dart';
import 'package:Wanderer/Modules/PriceItem.dart';
import 'package:Wanderer/Services/CampingCenterService.dart';

import 'package:Wanderer/Services/Utility/CustomColor.dart';

import 'package:flutter/material.dart';

import 'AccessPriceEditWidget.dart';
import 'PriceEditableWidget.dart';

class PriceItemEditList extends StatefulWidget {
  final List<EditPriceItem> _pricesList;
  final Size _screenSize;
  final Function cancelChangesCallback;
  final Function refreshPricesCallback;
  final String centerID;
  PriceItemEditList(
      {@required List<EditPriceItem> pricesList,
      @required screenSize,
      @required Function cancelChangesCallback,
      @required String centerID,
      @required Function refreshPricesCallback})
      : this.cancelChangesCallback = cancelChangesCallback,
        this._pricesList = pricesList,
        this._screenSize = screenSize,
        this.centerID = centerID,
        this.refreshPricesCallback = refreshPricesCallback {
    print(pricesList);
  }

  @override
  _PriceItemEditListState createState() => _PriceItemEditListState();
}

class _PriceItemEditListState extends State<PriceItemEditList> {
  void _deleteFromList(EditPriceItem item) {
    setState(() {
      widget._pricesList.remove(item);
    });
  }

  dynamic generateJsonObject() {
    bool firstItem = true;
    var result = {
      'accessPrice': widget._pricesList[0].priceController.text,
      'newItems': [],
      'modItems': [],
      'delItems': []
    };
    for (var item in widget._pricesList) {
      if (!firstItem) {
        var jsonObject = {
          "price": item.priceController.text,
          "label": item.labelController.text,
          "description": item.descrController.text,
          "_id": item.priceItem.priceId,
          "center": widget.centerID,
          "totalStock": item.stockController.text
        };
        if (item.newItem)
          (result['newItems'] as List).add(jsonObject);
        else if (item.deleted)
          (result['delItems'] as List).add(jsonObject);
        else if (item.isEdited) (result['modItems'] as List).add(jsonObject);
      } else {
        firstItem = false;
      }
    }
    return result;
  }

  bool validateInputs() {
    bool firstItem = true;
    var first = widget._pricesList[0];
    if (!(first.priceController.text.isNotEmpty &&
        num.tryParse(first.priceController.text) != null &&
        double.parse(first.priceController.text) != 0)) return false;
    for (var item in widget._pricesList) {
      if (!firstItem &&
          !(item.labelController.text.isNotEmpty &&
              item.priceController.text.isNotEmpty &&
              num.tryParse(item.priceController.text) != null &&
              double.parse(item.priceController.text) > 0 &&
              item.stockController.text.isNotEmpty &&
              int.tryParse(item.stockController.text) != null &&
              int.parse(item.stockController.text) > 0)) return false;
      firstItem = false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            child: Container(
              decoration: BoxDecoration(color: CustomColor.lightBackground),
              child: Column(
                children: [
                  ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.all(0),
                      shrinkWrap: true,
                      itemCount: widget._pricesList.length,
                      itemBuilder: (BuildContext ctxt, int index) {
                        bool isAccess = widget._pricesList[index].isAccess;
                        return Container(
                            child: isAccess
                                ? AccessPriceEditWidget(
                                    widget._pricesList[index])
                                : PriceEditableWidget(
                                    widget._pricesList[index],
                                    isLastItem:
                                        index == widget._pricesList.length - 1,
                                    screenSize: widget._screenSize,
                                    deleteCallback: _deleteFromList,
                                  ));
                      }),
                ],
              ),
            ),
          ),
        ),
        Container(
          width: widget._screenSize.width * 0.6,
          decoration: BoxDecoration(),
          child: Row(
            children: [
              Expanded(
                flex: 4,
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: CustomColor.interactable),
                      borderRadius:
                          BorderRadius.only(bottomLeft: Radius.circular(30))),
                  child: IconButton(
                    onPressed: () {
                      setState(() {
                        widget.cancelChangesCallback();
                      });
                    },
                    icon: Icon(
                      Icons.close,
                      color: CustomColor.interactable,
                      size: 30,
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 8,
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: CustomColor.interactable),
                  ),
                  child: IconButton(
                    onPressed: () {
                      setState(() {
                        widget._pricesList.add(EditPriceItem(
                            priceItem: PriceItem(),
                            startInEditMode: true,
                            newItem: true));
                      });
                    },
                    icon: Icon(
                      Icons.add,
                      color: CustomColor.interactable,
                      size: 30,
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 4,
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: CustomColor.interactable),
                      borderRadius:
                          BorderRadius.only(bottomRight: Radius.circular(30))),
                  child: IconButton(
                    onPressed: () {
                      setState(() {
                        if (validateInputs()) {
                          print("valid inputs");
                          CampingCenterService.updatePrices(
                                  generateJsonObject())
                              .then((_) {
                            widget.refreshPricesCallback(double.parse(
                                widget._pricesList[0].priceController.text));
                            Navigator.of(context).pop();
                          });
                        } else {
                          print("invalid items");
                        }
                      });
                    },
                    icon: Icon(
                      Icons.check,
                      color: CustomColor.interactable,
                      size: 30,
                    ),
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
