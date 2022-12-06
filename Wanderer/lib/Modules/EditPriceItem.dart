import 'package:flutter/material.dart';

import 'PriceItem.dart';

class EditPriceItem {
  TextEditingController labelController;
  TextEditingController priceController;
  TextEditingController descrController;
  TextEditingController stockController;
  bool isEdited;
  PriceItem priceItem;
  PriceItem initialItem;
  bool isAccess;
  bool newItem;
  bool deleted;
  final bool startInEditMode;

  EditPriceItem(
      {PriceItem priceItem,
      bool isAccess = false,
      bool newItem = false,
      bool deleted = false,
      bool startInEditMode = false})
      : this.priceItem = priceItem,
        this.newItem = newItem,
        this.deleted = deleted,
        this.isAccess = isAccess,
        this.startInEditMode = startInEditMode {
    initialItem = PriceItem(
        price: priceItem.price,
        currency: priceItem.currency,
        description: priceItem.description,
        label: priceItem.label,
        totalStock: priceItem.totalStock);
    labelController = TextEditingController();
    labelController.text = priceItem.label;
    priceController = TextEditingController();
    priceController.text = priceItem.price.toString();
    descrController = TextEditingController();
    descrController.text = priceItem.description;
    stockController = TextEditingController();
    stockController.text = priceItem.totalStock.toString();
    isEdited = false;
  }

  Color getPriceColor() {
    if (num.tryParse(priceController.text) != null &&
        initialItem.price != double.parse(priceController.text))
      return Colors.white;
    else
      return Colors.white60;
  }

  Color getLabelColor() {
    if (initialItem.label != labelController.text)
      return Colors.white;
    else
      return Colors.white60;
  }

  Color getDescrColor() {
    if (initialItem.description != descrController.text)
      return Colors.white;
    else
      return Colors.white60;
  }

  Color getStockColor() {
    if (int.tryParse(stockController.text) != null &&
        initialItem.totalStock != int.parse(stockController.text))
      return Colors.white;
    else
      return Colors.white60;
  }
}
