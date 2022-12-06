import 'package:Wanderer/Modules/EditPriceItem.dart';
import 'package:Wanderer/Services/Utility/CustomColor.dart';

import 'package:flutter/material.dart';

class AccessPriceEditWidget extends StatefulWidget {
  final EditPriceItem _editItem;
  AccessPriceEditWidget(this._editItem);

  @override
  _AccessPriceEditWidgetState createState() => _AccessPriceEditWidgetState();
}

class _AccessPriceEditWidgetState extends State<AccessPriceEditWidget> {
  String priceError;
  void updatePriceError() {
    if (widget._editItem.priceController.text == null ||
        widget._editItem.priceController.text.isEmpty)
      priceError = "Please fill this field";
    else if (num.tryParse(widget._editItem.priceController.text) == null)
      priceError = "Please enter a valid value";
    else if (double.parse(widget._editItem.priceController.text) == 0)
      priceError = "Price can't be zero";
    else
      priceError = null;
  }

  @override
  Widget build(BuildContext context) {
    updatePriceError();
    return Container(
      decoration: BoxDecoration(
          color: CustomColor.secondaryHighlight.withAlpha(65),
          border: Border(
              bottom:
                  BorderSide(color: CustomColor.backgroundColor, width: 2))),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12.5),
      child: TextFormField(
        controller: widget._editItem.priceController,
        onChanged: (value) {
          setState(() {
            widget._editItem.isEdited = true;
            updatePriceError();
          });
        },
        keyboardType:
            TextInputType.numberWithOptions(decimal: true, signed: false),
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
            errorText: priceError,
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: widget._editItem.getPriceColor()),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.blueGrey),
            ),
            helperText: 'Access fee to the camping grounds',
            helperStyle: TextStyle(color: CustomColor.secondaryText),
            labelText: 'Access Price',
            labelStyle: TextStyle(color: widget._editItem.getPriceColor())),
      ),
    );
  }
}
