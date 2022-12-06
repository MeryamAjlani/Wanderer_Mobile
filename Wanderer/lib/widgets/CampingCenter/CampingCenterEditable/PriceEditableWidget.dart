import 'package:Wanderer/Modules/EditPriceItem.dart';

import 'package:Wanderer/Services/Utility/CustomColor.dart';

import 'package:flutter/material.dart';
import 'package:flutter_placeholder_textlines/flutter_placeholder_textlines.dart';

import 'PriceItemEditWidget.dart';

class PriceEditableWidget extends StatefulWidget {
  final EditPriceItem _priceItem;
  final bool _isLastItem;
  final Size _screenSize;
  final bool _loading;
  final Function deleteCallback;

  PriceEditableWidget(this._priceItem,
      {bool isLastItem = false,
      Function deleteCallback,
      @required Size screenSize,
      bool editMode = false})
      : this._screenSize = screenSize,
        this._isLastItem = isLastItem,
        this._loading = false,
        this.deleteCallback = deleteCallback;

  @override
  _PriceEditableWidgetState createState() => _PriceEditableWidgetState();
}

class _PriceEditableWidgetState extends State<PriceEditableWidget> {
  bool hasError = false;
  bool _isEditMode = false;
  bool _initMode = true;
  @override
  Widget build(BuildContext context) {
    if (_initMode) {
      _isEditMode = widget._priceItem.startInEditMode;
      _initMode = false;
    }
    bool isNew = widget._priceItem.newItem;
    bool isDeleted = widget._priceItem.deleted;
    return Container(
      child: Container(
        child: _isEditMode
            ? Container(
                padding: EdgeInsets.symmetric(
                    horizontal: 20, vertical: isDeleted ? 5 : 12.5),
                decoration: BoxDecoration(
                  color: isDeleted
                      ? Colors.red.withAlpha(50)
                      : isNew ? Colors.blue.withAlpha(5) : Colors.transparent,
                  border: (!widget._isLastItem)
                      ? Border(
                          bottom: BorderSide(
                              color: CustomColor.backgroundColor, width: 2))
                      : null,
                ),
                child: isDeleted
                    ? TextButton(
                        onPressed: () {
                          setState(() {
                            widget._priceItem.deleted = false;
                          });
                        },
                        child: Text(
                          "Restore",
                          style: TextStyle(color: Colors.white),
                        ))
                    : Column(
                        children: [
                          PriceItemEditWidget(widget._priceItem),
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Container(),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: RaisedButton.icon(
                                      color: CustomColor.interactable,
                                      onPressed: () {
                                        setState(() {
                                          if (widget._priceItem.newItem)
                                            widget.deleteCallback(
                                                widget._priceItem);
                                          else
                                            widget._priceItem.deleted = true;
                                        });
                                      },
                                      icon: Icon(
                                        Icons.delete,
                                        color: Colors.white,
                                      ),
                                      label: Text(
                                        "Delete",
                                        style: TextStyle(color: Colors.white),
                                      )),
                                ),
                                Expanded(
                                  child: Align(
                                      alignment: Alignment.centerRight,
                                      child: IconButton(
                                        onPressed: () {
                                          setState(() {
                                            _isEditMode = false;
                                            hasError = !(widget
                                                    ._priceItem
                                                    .labelController
                                                    .text
                                                    .isNotEmpty &&
                                                widget
                                                    ._priceItem
                                                    .priceController
                                                    .text
                                                    .isNotEmpty &&
                                                num.tryParse(widget
                                                        ._priceItem
                                                        .priceController
                                                        .text) !=
                                                    null &&
                                                double.parse(widget
                                                        ._priceItem
                                                        .priceController
                                                        .text) !=
                                                    0 &&
                                                widget
                                                    ._priceItem
                                                    .stockController
                                                    .text
                                                    .isNotEmpty &&
                                                int.tryParse(
                                                        widget._priceItem.stockController.text) !=
                                                    null &&
                                                int.parse(widget._priceItem.stockController.text) > 0);
                                          });
                                        },
                                        icon: Icon(
                                          Icons.arrow_drop_up_sharp,
                                          size: 50,
                                          color: CustomColor.interactable,
                                        ),
                                      )),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ))
            : Container(
                decoration: BoxDecoration(
                  border: (!widget._isLastItem)
                      ? Border(
                          bottom: BorderSide(
                              color: CustomColor.backgroundColor, width: 2))
                      : null,
                  color: hasError
                      ? Colors.red.withAlpha(75)
                      : isNew ? Colors.blue.withAlpha(5) : Colors.transparent,
                ),
                padding: EdgeInsets.only(left: 20, top: 12.5, bottom: 12.5),
                child: Row(
                  children: [
                    Expanded(
                      flex: 7,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Container(
                                    child: !widget._loading
                                        ? Text(
                                            widget._priceItem.labelController
                                                .text,
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: widget._priceItem
                                                    .getLabelColor()),
                                          )
                                        : PlaceholderLines(
                                            count: 1,
                                            animate: true,
                                            lineHeight: 16,
                                            color: Colors.grey,
                                          )),
                              ),
                              Container(
                                width: widget._screenSize.width * 0.2,
                                child: !widget._loading
                                    ? Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.baseline,
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Text(
                                            widget
                                                ._priceItem.priceController.text
                                                .toString(),
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: widget._priceItem
                                                    .getPriceColor()),
                                          ),
                                          Text(
                                            " " +
                                                widget._priceItem.priceItem
                                                    .currency,
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: widget._priceItem
                                                    .getPriceColor()),
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
                                    child: !widget._loading
                                        ? Container(
                                            child: (widget
                                                            ._priceItem
                                                            .descrController
                                                            .text !=
                                                        null &&
                                                    widget
                                                        ._priceItem
                                                        .descrController
                                                        .text
                                                        .isNotEmpty)
                                                ? Text(
                                                    widget._priceItem
                                                        .descrController.text,
                                                    style: TextStyle(
                                                        fontSize: 12,
                                                        color: widget._priceItem
                                                            .getDescrColor()),
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
                              Container(
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                      "Total Stock ${widget._priceItem.stockController.text}",
                                      style: TextStyle(
                                          fontSize: 12,
                                          color: widget._priceItem
                                              .getStockColor())),
                                ),
                              ),
                            ],
                          ),
                          /*
                          Container(
                              margin: EdgeInsets.only(top: 3),
                              child: !widget._loading
                                  ? Container(
                                      child: (widget._priceItem.descrController
                                                  .text !=
                                              null)
                                          ? Text(
                                              widget._priceItem.descrController
                                                  .text,
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color: widget._priceItem
                                                      .getDescrColor()),
                                            )
                                          : null)
                                  : Container(
                                      margin: EdgeInsets.only(top: 5),
                                      child: PlaceholderLines(
                                        count: 1,
                                        animate: true,
                                        color: Colors.grey,
                                        maxOpacity: 0.5,
                                      ))),*/
                        ],
                      ),
                    ),
                    Expanded(
                        flex: 2,
                        child: Align(
                            alignment: Alignment.center,
                            child: IconButton(
                              icon: Icon(Icons.edit,
                                  color: CustomColor.interactable),
                              onPressed: () {
                                setState(() {
                                  _isEditMode = true;
                                });
                              },
                            )))
                  ],
                ),
              ),
      ),
    );
  }
}
