import 'package:flutter/material.dart';
import 'package:nakshekadam/classes/language.dart';
import 'package:nakshekadam/globals.dart';

class LanguageDropDown extends StatefulWidget {
  const LanguageDropDown({Key? key, required this.parentSet}) : super(key: key);
  final Function(Function()) parentSet;

  @override
  State<LanguageDropDown> createState() => LanguageDropDownState();
}

class LanguageDropDownState extends State<LanguageDropDown> {
  Language language = Language();

  @override
  Widget build(BuildContext context) {
    final List<double> tempDimensions = [MediaQuery.of(context).size.width,MediaQuery.of(context).size.height];
    final double screenHeight = tempDimensions[0] > tempDimensions[1] ? tempDimensions[0] : tempDimensions[1];
    final double screenWidth = tempDimensions[0] > tempDimensions[1] ? tempDimensions[1] : tempDimensions[0];

    return Card(
      borderOnForeground: true,
      shadowColor: COLOR_THEME['languageDropDownBackground'],
      surfaceTintColor: COLOR_THEME['secondary'],
      color: COLOR_THEME['languageDropDownBackground'],
      elevation: 0,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(screenWidth / 30)),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: screenWidth / 50,
          // vertical: screenHeight / 50,
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            style: TextStyle(
              color: COLOR_THEME['languageDropDownText'],
              fontFamily: 'DM Sans',
            ),
            alignment: AlignmentDirectional.center,
            elevation: 0,
            value: language.language,
            borderRadius: BorderRadius.circular(screenWidth / 20),
            items: language.languages
                .map(
                  (e) => DropdownMenuItem<String>(
                    alignment: Alignment.center,
                    value: e,
                    child: Text(
                      e,
                    ),
                  ),
                )
                .toList(),
            onChanged: (item) {
              if (language.language != item) {
                print(item);
                language.setLanguage = item;

                setState(() {});
              }
            },
          ),
        ),
      ),
    );
  }
}
