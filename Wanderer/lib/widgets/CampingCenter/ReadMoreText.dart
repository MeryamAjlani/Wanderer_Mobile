import 'package:Wanderer/Services/Utility/CustomColor.dart';
import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';

class ReadMoreText extends StatefulWidget {
  final String _text;
  final TextStyle _style;
  ReadMoreText({@required String text, TextStyle style})
      : this._text = text,
        this._style = style;

  @override
  _ReadMoreTextState createState() => _ReadMoreTextState();
}

class _ReadMoreTextState extends State<ReadMoreText> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: AutoSizeText(
        widget._text,
        presetFontSizes: [15],
        style: (widget._style == null)
            ? TextStyle(color: CustomColor.secondaryText)
            : widget._style,
        overflowReplacement: Column(
          children: [
            AutoSizeText(
              widget._text,
              maxLines: _expanded ? null : 3,
              overflowReplacement: null,
              presetFontSizes: [15],
              style: (widget._style == null)
                  ? TextStyle(color: CustomColor.secondaryText)
                  : widget._style,
            ),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                style: TextButton.styleFrom(
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    minimumSize: Size(0, 0),
                    padding:
                        EdgeInsets.symmetric(horizontal: 30, vertical: 7.5)),
                child: Text(
                  _expanded ? "Show less" : "Read more",
                  style: TextStyle(
                      color: CustomColor.interactable,
                      fontWeight: FontWeight.normal),
                ),
                onPressed: () {
                  setState(() {
                    _expanded = !_expanded;
                  });
                },
              ),
            ),
          ],
        ),
        maxLines: 3,
      ),
    );
  }
}
