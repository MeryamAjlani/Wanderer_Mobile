import 'package:Wanderer/Modules/OrganizedEvent.dart';
import 'package:Wanderer/Services/Utility/CustomColor.dart';

import 'package:Wanderer/widgets/Organization/EventItemOrgProfile.dart';
import 'package:flutter/widgets.dart';

class EventsList extends StatelessWidget {
  const EventsList({
    Key key,
    @required ScrollController scrollController,
    @required this.litems,
    @required String text,
  })  : _scrollController = scrollController,
        _text = text,
        super(key: key);

  final ScrollController _scrollController;
  final List<OrganizedEvent> litems;
  final String _text;

  @override
  Widget build(BuildContext context) {
    return new ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        controller: _scrollController,
        itemCount: litems.length,
        itemBuilder: (BuildContext ctxt, int index) {
          return Padding(
            padding: const EdgeInsets.fromLTRB(0, 2, 0, 16),
            child: Stack(
              children: [
                EventItemOrgProfile(
                    item: litems[index],
                    height: 0.43,
                    featured: litems[index].featured),
                Positioned(
                    top: 0,
                    right: 34,
                    child: Container(
                      padding: EdgeInsets.fromLTRB(10, 4, 10, 4),
                      child: Text(
                        _text,
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      decoration: BoxDecoration(
                          color: litems[index].featured
                              ? Color(0xffffd700)
                              : CustomColor.interactableAccent,
                          borderRadius: BorderRadius.circular(10)),
                    ))
              ],
            ),
          );
        });
  }
}
