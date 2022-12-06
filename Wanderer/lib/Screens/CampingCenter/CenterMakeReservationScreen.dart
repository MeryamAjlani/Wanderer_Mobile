import 'package:Wanderer/Modules/PriceItem.dart';
import 'package:Wanderer/Services/Utility/CustomColor.dart';
import 'package:Wanderer/widgets/CampingCenter/PriceItemSelectionWidget.dart';
import 'package:Wanderer/widgets/Profile/DrawerWidget.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CenterMakeReservationScreen extends StatefulWidget {
  static final String routeName = "/center/makeReservation";
  const CenterMakeReservationScreen();

  @override
  _CenterMakeReservationScreenState createState() =>
      _CenterMakeReservationScreenState();
}

class _CenterMakeReservationScreenState
    extends State<CenterMakeReservationScreen> {
  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> arguments =
        ModalRoute.of(context).settings.arguments as Map<String, dynamic>;
    List<PriceItem> priceItems = arguments['priceItems'];
    double acessPrice = arguments['acessPrice'] + 0.0;
    return Scaffold(
      drawer: DrawerWidget(),
      backgroundColor: CustomColor.backgroundColor,
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top, bottom: 50),
          child: Column(
            //mainAxisSize: MainAxisSize.min,
            children: [
              PriceItemSelectionWidget(
                unitName: "person",
                minUnits: 1,
                priceItem: PriceItem(
                  label: "Reservation:",
                  price: acessPrice,
                  /*description: 'Access fee to the camping grounds'*/
                ),
              ),
              ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: priceItems.length,
                itemBuilder: (context, index) {
                  return PriceItemSelectionWidget(
                    priceItem: priceItems[index],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
