import 'package:Wanderer/Modules/EditPriceItem.dart';
import 'package:Wanderer/Services/Utility/CustomColor.dart';

import 'package:flutter/material.dart';

class PriceItemEditWidget extends StatefulWidget {
  final EditPriceItem _editItem;
  PriceItemEditWidget(this._editItem);

  @override
  _PriceItemEditWidgetState createState() => _PriceItemEditWidgetState();
}

class _PriceItemEditWidgetState extends State<PriceItemEditWidget> {
  String labelError;
  String priceError;
  String stockError;

  void updateLabelError() {
    if (widget._editItem.labelController.text == null ||
        widget._editItem.labelController.text.isEmpty)
      labelError = "Please fill this field";
    else
      labelError = null;
  }

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

  void updateStockError() {
    if (widget._editItem.stockController.text == null ||
        widget._editItem.stockController.text.isEmpty)
      stockError = "Please fill this field";
    else if (int.tryParse(widget._editItem.stockController.text) == null)
      stockError = "Please enter a valid value";
    else if (int.parse(widget._editItem.stockController.text) == 0)
      stockError = "Stock can't be zero";
    else if (int.parse(widget._editItem.stockController.text) < 0)
      stockError = "Stock can't be negative";
    else
      stockError = null;
  }

  @override
  Widget build(BuildContext context) {
    updateLabelError();
    updatePriceError();
    updateStockError();
    return Container(
      child: Column(
        children: [
          TextFormField(
            controller: widget._editItem.labelController,
            onChanged: (value) {
              setState(() {
                widget._editItem.isEdited = true;
                updateLabelError();
              });
            },
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
                errorText: labelError,
                enabledBorder: UnderlineInputBorder(
                  borderSide:
                      BorderSide(color: widget._editItem.getLabelColor()),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.blueGrey),
                ),
                helperStyle: TextStyle(color: CustomColor.secondaryText),
                labelText: 'Label',
                labelStyle: TextStyle(color: widget._editItem.getLabelColor())),
          ),
          TextFormField(
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
                  borderSide:
                      BorderSide(color: widget._editItem.getPriceColor()),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.blueGrey),
                ),
                helperStyle: TextStyle(color: CustomColor.secondaryText),
                labelText: 'Price',
                labelStyle: TextStyle(color: widget._editItem.getPriceColor())),
          ),
          TextFormField(
            controller: widget._editItem.stockController,
            onChanged: (value) {
              setState(() {
                widget._editItem.isEdited = true;
                updateStockError();
              });
            },
            keyboardType:
                TextInputType.numberWithOptions(decimal: true, signed: false),
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
                errorText: stockError,
                enabledBorder: UnderlineInputBorder(
                  borderSide:
                      BorderSide(color: widget._editItem.getStockColor()),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.blueGrey),
                ),
                helperStyle: TextStyle(color: CustomColor.secondaryText),
                labelText: 'Total Stock',
                labelStyle: TextStyle(color: widget._editItem.getPriceColor())),
          ),
          TextFormField(
            controller: widget._editItem.descrController,
            onChanged: (value) {
              setState(() {
                widget._editItem.isEdited = true;
              });
            },
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(
                  borderSide:
                      BorderSide(color: widget._editItem.getDescrColor()),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.blueGrey),
                ),
                helperStyle: TextStyle(color: CustomColor.secondaryText),
                labelText: 'Description (optional)',
                labelStyle: TextStyle(color: widget._editItem.getDescrColor())),
          ),
        ],
      ),
    );
  }
}
