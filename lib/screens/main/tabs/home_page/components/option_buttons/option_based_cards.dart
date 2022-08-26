import 'package:flutter/material.dart';
import 'package:nakshekadam/globals.dart';
import 'package:nakshekadam/screens/main/tabs/home_page/components/bottom_sheet/bottom_sheet.dart';
import 'package:nakshekadam/screens/main/tabs/home_page/components/option_buttons/components/career_options_buttons/career_option_bottom_sheet.dart';

class CareerOptionsCard extends StatefulWidget {
  CareerOptionsCard({
    Key? key,
    required this.title,
    required this.routeName,
    required this.summary,
    required this.side,
  }) : super(key: key);
  final String title;
  final String summary;
  final double side;
  final String routeName;

  @override
  State<CareerOptionsCard> createState() => _CareerOptionsCardState();
}

class _CareerOptionsCardState extends State<CareerOptionsCard> {
  @override
  Widget build(BuildContext context) {
    final List<double> tempDimensions = [
      MediaQuery.of(context).size.width,
      MediaQuery.of(context).size.height
    ];
    final double screenHeight = tempDimensions[0] > tempDimensions[1]
        ? tempDimensions[0]
        : tempDimensions[1];
    final double screenWidth = tempDimensions[0] > tempDimensions[1]
        ? tempDimensions[1]
        : tempDimensions[0];
    final String icon = widget.title
        .replaceAll('&', '')
        .replaceAll('  ', '_')
        .replaceAll(' ', '_')
        .toLowerCase();

    ImageIcon _icon = ImageIcon(
      AssetImage('$CAREER_OPTIONS_BOTTOM_SHEET_ICON_DIRECTORY/$icon.png'),
      color: COLOR_THEME['secondary'],
    );
    TextStyle titleStyle = TextStyle(
      color: Colors.black,
      fontFamily: "DM Sans",
      fontSize: widget.side * 0.085,
      fontWeight: FontWeight.bold,
    );

    TextStyle summaryStyle = TextStyle(
      color: Colors.black,
      fontFamily: "DM Sans",
      fontSize: widget.side * 0.07,
    );
    return GestureDetector(
      onTap: () async {
        await showModalBottomSheet(
            constraints: BoxConstraints(
              maxHeight: screenHeight * 0.95,
            ),
            isScrollControlled: true,
            isDismissible: false,
            // enableDrag: false,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                screenWidth,
              ),
            ),
            backgroundColor: Colors.transparent,
            context: context,
            builder: (builder) {
              return CareerOptionBottomSheet(
                  title: widget.title, optionCardName: widget.routeName);
            });
      },
      child: Container(
        height: widget.side,
        width: widget.side,
        decoration: BoxDecoration(
          color: COLOR_THEME['careerTile'] ?? Color(0xFFFFC04C),
          border: Border.all(
            width: widget.side * 0.03,
            color: COLOR_THEME['careerTile'] ?? Color(0xFFFFC04C),
          ),
          borderRadius: BorderRadius.circular(widget.side * 0.15),
        ),
        child: Container(
          height: widget.side,
          width: widget.side,
          padding: EdgeInsets.only(
            top: widget.side * 0.05,
            right: widget.side * 0.05,
            left: widget.side * 0.05,
          ),
          decoration: BoxDecoration(
            color: COLOR_THEME['careerTile'] ?? Color(0xFFFFC04C),
            border: Border.all(
              width: widget.side * 0.03,
              color: Colors.white,
            ),
            borderRadius: BorderRadius.circular(widget.side * 0.15),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _icon,
              Padding(
                padding: EdgeInsets.symmetric(vertical: widget.side * 0.02),
                child: Text(
                  widget.title,
                  style: titleStyle,
                ),
              ),
              Text(
                widget.summary,
                style: summaryStyle,
              )
            ],
          ),
        ),
      ),
    );
  }
}
