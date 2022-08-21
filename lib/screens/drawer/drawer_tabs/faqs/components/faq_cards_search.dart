import 'package:flutter/material.dart';
import 'package:nakshekadam/screens/drawer/drawer_tabs/faqs/components/faq_controller.dart';
import 'package:provider/provider.dart';

// import '../../../models/faq_model.dart';

class FAQsScreen extends StatelessWidget {
  FAQsScreen({Key? key}) : super(key: key);
  // final faqs = FAQModel().faqs;

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
    // List<FAQTopics> selectedfaqs = f6aqs;
    return Material(
      color: Colors.white,
      child: Consumer<FAQsController>(
        builder: (context, model, child) {
          return Column(
            children: <Widget>[
              Container(
                color: Colors.white,
                width: screenWidth / 1.1,
                child: TextField(
                  onChanged: (value) {},
                  controller: model.editingController,
                  decoration: const InputDecoration(
                    labelText: "Search",
                    hintText: "Search",
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(15.0),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: ListView(
                  keyboardDismissBehavior:
                      ScrollViewKeyboardDismissBehavior.onDrag,
                  shrinkWrap: true,
                  children: [
                    ...model.selectedfaqs.map(
                      (selectedfaq) => Padding(
                        padding: EdgeInsets.fromLTRB(
                            0, screenHeight * 0.01, 0, screenHeight * 0.01),
                        child: Card(
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(screenWidth * 0.05),
                          ),
                          child: ExpansionTile(
                            backgroundColor: const Color(0xFFB0EBFF),
                            iconColor: Colors.black,
                            textColor: Colors.black,
                            initiallyExpanded: true,
                            title: Text(
                              selectedfaq.topic,
                              style: const TextStyle(
                                  fontSize: 25, fontWeight: FontWeight.bold),
                            ),
                            children: [
                              ...selectedfaq.faqs.map(
                                (faq) => ExpansionTile(
                                  backgroundColor: const Color(0xFFB0EBFF),
                                  iconColor: const Color(0xff00B374),
                                  textColor: const Color(0xff00B374),
                                  title: Text(faq.question,
                                      style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold)),
                                  children: [
                                    ListTile(
                                      tileColor: const Color(0xFFB0EBFF),
                                      title: Text(
                                        faq.answer,
                                        style: TextStyle(
                                            fontSize: screenWidth * 0.05),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
