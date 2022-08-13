import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nakshekadam/globals.dart';
import 'package:nakshekadam/screens/main/tabs/home_page/components/bottom_sheet/infographics.dart';
import 'package:nakshekadam/strings.dart';

class CustomBottomSheet extends StatelessWidget {
  const CustomBottomSheet({Key? key, required this.routeName})
      : super(key: key);
  final String routeName;

  @override
  Widget build(BuildContext context) {
    String title = routeName.replaceAll('_', ' ').toUpperCase();
    final List<double> tempDimensions = [MediaQuery.of(context).size.width,MediaQuery.of(context).size.height];
    final double screenHeight = tempDimensions[0] > tempDimensions[1] ? tempDimensions[0] : tempDimensions[1];
    final double screenWidth = tempDimensions[0] > tempDimensions[1] ? tempDimensions[1] : tempDimensions[0];
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(
            screenWidth / 20,
          ),
          topRight: Radius.circular(
            screenWidth / 20,
          ),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          commonBottomSheetTitle(
            title: title,
            screenWidth: screenWidth,
          ),
          SizedBox(
            height: screenHeight * 0.65,
            child: Stack(
              children: [
                Container(
                  alignment: Alignment.topCenter,
                  padding: EdgeInsets.only(
                    top: screenWidth * 0.1,
                  ),
                  width: screenWidth,
                  height: screenWidth * 0.8,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                        'assets/images/concentricCirlces.png',
                      ),
                      fit: BoxFit.fitWidth,
                      alignment: FractionalOffset.bottomCenter,
                    ),
                  ),
                ),
                NotificationListener<OverscrollIndicatorNotification>(
                  onNotification: (overScroll) {
                    overScroll.disallowIndicator();
                    return false;
                  },
                  child: SingleChildScrollView(
                    child: Wrap(
                      runAlignment: WrapAlignment.start,
                      alignment: WrapAlignment.center,
                      spacing: screenWidth * 0.05,
                      runSpacing: screenHeight * 0.02,
                      children: [
                        infographicsAndText(
                          screenWidth: screenWidth,
                          screenHeight: screenHeight,
                          routeName: routeName,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

commonBottomSheetTitle({required title, required screenWidth}) {
  TextStyle titleStyle = TextStyle(
    color: Colors.white,
    fontFamily: "DM Sans",
    fontSize: screenWidth * 0.07,
    fontWeight: FontWeight.bold,
  );

  return Column(
    children: [
      Padding(
        padding: EdgeInsets.symmetric(
          horizontal: screenWidth / 2.75,
          vertical: screenWidth * 0.05,
        ),
        child: Container(
          width: screenWidth,
          height: screenWidth * 0.02,
          decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.circular(
              screenWidth / 30,
            ),
          ),
        ),
      ),
      Container(
        color: COLOR_THEME['primary'],
        width: screenWidth,
        height: screenWidth * 0.14,
        child: Center(
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: titleStyle,
          ),
        ),
      ),
    ],
  );
}
