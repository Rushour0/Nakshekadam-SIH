import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomBottomSheet extends StatelessWidget {
  const CustomBottomSheet({Key? key, required this.routeName})
      : super(key: key);
  final String routeName;

  @override
  Widget build(BuildContext context) {
    String title = routeName.replaceAll('_', ' ').toUpperCase();
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    return BottomSheet(
      onClosing: () {},
      builder: (builder) {
        return Container(
          decoration: BoxDecoration(
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
            children: [
              commonBottomSheetTitle(
                title: title,
                screenWidth: screenWidth,
              ),
            ],
          ),
        );
      },
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

  return Container(
    child: Text(
      title,
      style: titleStyle,
    ),
  );
}
