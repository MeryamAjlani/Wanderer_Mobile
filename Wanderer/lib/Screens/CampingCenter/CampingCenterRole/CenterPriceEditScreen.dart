import 'package:Wanderer/Services/Utility/CustomColor.dart';
import 'package:Wanderer/widgets/CampingCenter/CampingCenterEditable/PriceItemEditList.dart';
import 'package:Wanderer/widgets/CampingCenter/DrawerCenter.dart';
import 'package:flutter/material.dart';

class CenterPriceEditScreen extends StatefulWidget {
  const CenterPriceEditScreen();
  static final String routeName = "/profile/center/editPrices";
  @override
  _CenterPriceEditScreenState createState() => _CenterPriceEditScreenState();
}

class _CenterPriceEditScreenState extends State<CenterPriceEditScreen> {
  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> arguments =
        ModalRoute.of(context).settings.arguments as Map<String, dynamic>;
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      drawer: DrawerCenterWidget(),
      backgroundColor: CustomColor.backgroundColor,
      body: SingleChildScrollView(
        child: Container(
            margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
            child: PriceItemEditList(
              refreshPricesCallback:
                  arguments['refreshPricesCallback'] as Function,
              centerID: arguments['centerID'],
              pricesList: arguments['pricesList'],
              screenSize: screenSize,
              cancelChangesCallback: () {
                Navigator.of(context).pop();
              },
            )),
      ),
    );
  }
}
