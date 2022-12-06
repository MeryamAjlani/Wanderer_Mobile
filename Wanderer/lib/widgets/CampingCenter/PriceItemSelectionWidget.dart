import 'package:Wanderer/Modules/PriceItem.dart';
import 'package:Wanderer/Services/Utility/CustomColor.dart';

import 'package:flutter/material.dart';
import 'package:scroll_snap_list/scroll_snap_list.dart';

class PriceItemSelectionWidget extends StatefulWidget {
  const PriceItemSelectionWidget(
      {@required PriceItem priceItem,
      this.minUnits: 0,
      this.maxUnits: 50,
      this.unitName: "unit"})
      : this._priceItem = priceItem;
  final PriceItem _priceItem;
  final int minUnits;
  final int maxUnits;
  final String unitName;
  @override
  _PriceItemSelectionWidgetState createState() =>
      _PriceItemSelectionWidgetState();
}

class _PriceItemSelectionWidgetState extends State<PriceItemSelectionWidget> {
  int selectedIndex = 0;
  int selectedValue;

  @override
  Widget build(BuildContext context) {
    selectedValue = widget.minUnits + selectedIndex;
    Size screenSize = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: 5,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        child: Container(
          color: CustomColor.lightBackground,
          padding: EdgeInsets.only(top: 20, right: 20, left: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    flex: 6,
                    child: Text(
                      widget._priceItem.label,
                      style: TextStyle(
                          fontSize: 20,
                          color: CustomColor.highlightText.withAlpha(180)),
                    ),
                  ),
                  Expanded(
                      flex: 3,
                      child: FittedBox(
                        fit: BoxFit.fitWidth,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.baseline,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              widget._priceItem.price.toString(),
                              style: TextStyle(
                                  fontSize: 20,
                                  color:
                                      CustomColor.highlightText.withAlpha(180)),
                            ),
                            Text(
                              " " +
                                  widget._priceItem.currency +
                                  " per " +
                                  widget.unitName,
                              style: TextStyle(
                                  fontSize: 15,
                                  color:
                                      CustomColor.highlightText.withAlpha(150)),
                            )
                          ],
                        ),
                      ))
                ],
              ),
              Container(
                  child: (widget._priceItem.description != null &&
                          widget._priceItem.description.isNotEmpty)
                      ? Text(
                          widget._priceItem.description,
                          style: TextStyle(
                              fontSize: 12,
                              color: CustomColor.highlightText.withAlpha(150)),
                        )
                      : null),
              Stack(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 10),
                    width: screenSize.width,
                    height: 50,
                    child: Align(
                      alignment: Alignment.center,
                      child: ScrollSnapList(
                        dynamicItemSize: true,
                        itemCount: widget.maxUnits - widget.minUnits,
                        itemSize: 64,
                        onItemFocus: (index) {
                          setState(() {
                            selectedIndex = index;
                          });
                        },
                        itemBuilder: (context, index) {
                          return Container(
                            margin: EdgeInsets.symmetric(horizontal: 5),
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: CustomColor.interactable, width: 2),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5))),
                            child: Container(
                              child: SizedBox(
                                height: 50,
                                width: 50,
                                child: Center(
                                    child: Text(
                                  (index + widget.minUnits).toString(),
                                  style: TextStyle(
                                      color: CustomColor.interactable,
                                      fontSize: 30),
                                )),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  IgnorePointer(
                    ignoring: true,
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 6),
                          child: Center(
                            child: Container(
                              width: 62,
                              height: 58,
                              margin: EdgeInsets.symmetric(horizontal: 5),
                              decoration: BoxDecoration(
                                  border:
                                      Border.all(color: Colors.amber, width: 2),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8))),
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Container(),
                            ),
                            Icon(
                              Icons.arrow_drop_up,
                              color: Colors.amber,
                              size: 30,
                            ),
                            Expanded(
                              child: selectedValue != 0
                                  ? Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.baseline,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          (selectedValue *
                                                  widget._priceItem.price)
                                              .toString(),
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: CustomColor.highlightText
                                                  .withAlpha(180)),
                                        ),
                                        Text(
                                          " " + widget._priceItem.currency,
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: CustomColor.highlightText
                                                  .withAlpha(150)),
                                        )
                                      ],
                                    )
                                  : Container(),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
