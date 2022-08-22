import 'package:dropdown_button2/dropdown_button2.dart' show DropdownButton2;
import 'package:flutter/material.dart';
import 'package:nakshekadam/common_widgets/backgrounds/bigThreeBg.dart';
import 'package:nakshekadam/common_widgets/formfields.dart';

class PersonalDetails extends StatefulWidget {
  const PersonalDetails({Key? key}) : super(key: key);

  @override
  State<PersonalDetails> createState() => _PersonalDetailsState();
}

class _PersonalDetailsState extends State<PersonalDetails> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  List<String> roles = [
    'Student',
    'Parent',
    'Counsellor',
  ];
  String? selectedRole = null;

  @override
  Widget build(BuildContext context) {
    final List<double> tempDimensions = [MediaQuery.of(context).size.width,MediaQuery.of(context).size.height];
    final double screenHeight = tempDimensions[0] > tempDimensions[1] ? tempDimensions[0] : tempDimensions[1];
    final double screenWidth = tempDimensions[0] > tempDimensions[1] ? tempDimensions[1] : tempDimensions[0];
    return Scaffold(
      resizeToAvoidBottomInset: false,
      floatingActionButton: SizedBox(
        width: screenWidth * 0.9,
        height: screenHeight * 0.06,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: const Color(0xff615793),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(screenHeight * 0.01),
            ),
          ),
          onPressed: () async {
            if (_formKey.currentState!.validate()) {}
          },
          child: Text(
            "CONTINUE",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'Cabin',
              fontSize: screenWidth * 0.06,
              color: const Color(0xffA5A5BA),
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: Container(
        height: screenHeight,
        width: screenWidth,
        color: Colors.white,
        child: Stack(
          children: [
            Positioned(
              height: screenHeight,
              width: screenWidth,
              child: const BigThreeBG(),
            ),
            Positioned(
              top: 0,
              width: screenWidth,
              bottom: 0,
              child: SafeArea(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.04,
                      vertical: screenHeight * 0.007),
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: screenHeight * 0.34),
                        child: Text(
                          "PERSONAL DETAILS",
                          style: TextStyle(
                            fontFamily: "DM Sans",
                            fontSize: screenWidth * 0.06,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xff32324D),
                          ),
                        ),
                      ),
                      NotificationListener<OverscrollIndicatorNotification>(
                        onNotification: (overscroll) {
                          overscroll.disallowIndicator();
                          return true;
                        },
                        child: Expanded(
                          child: SingleChildScrollView(
                            child: Form(
                              key: _formKey,
                              child: Column(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                        top: screenHeight * 0.025),
                                    child: normalformfield(
                                        nameController,
                                        screenWidth,
                                        setState,
                                        "Full Name",
                                        TextInputType.name),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        top: screenHeight * 0.025),
                                    child: phoneformfield(
                                        phoneController, screenWidth, setState),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        top: screenHeight * 0.025),
                                    child: normalformfield(
                                        ageController,
                                        screenWidth,
                                        setState,
                                        "Age",
                                        TextInputType.number),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                      top: screenHeight * 0.025,
                                      bottom: screenHeight * 0.4,
                                    ),
                                    // child:
                                    child: DropdownButton2<String>(
                                      dropdownDecoration: BoxDecoration(
                                        shape: BoxShape.rectangle,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(
                                                screenWidth * 0.05)),
                                        border: Border.all(
                                          color: Colors.black,
                                        ),
                                      ),
                                      dropdownOverButton: false,
                                      // dropdownWidth: screenWidth * 0.85,
                                      isExpanded: true,
                                      itemHeight: kMinInteractiveDimension +
                                          screenHeight * 0.02,
                                      dropdownFullScreen: true,

                                      // decoration: InputDecoration(
                                      //   // suffixIcon: Icon(
                                      //   //   Icons.arrow_drop_down,
                                      //   //   size: screenWidth * 0.12,
                                      //   //   color: Colors.grey,
                                      //   // ),
                                      //   hintText: "Age",
                                      //   filled: true,
                                      //   fillColor: Colors.white,
                                      //   enabledBorder: OutlineInputBorder(
                                      //     borderSide: const BorderSide(
                                      //         color: Colors.grey),
                                      //     borderRadius: BorderRadius.circular(
                                      //         screenWidth * 0.05),
                                      //   ),
                                      //   errorBorder: OutlineInputBorder(
                                      //     borderSide: const BorderSide(
                                      //         color: Colors.grey),
                                      //     borderRadius: BorderRadius.circular(
                                      //         screenWidth * 0.05),
                                      //   ),
                                      //   focusedErrorBorder: OutlineInputBorder(
                                      //     borderSide: const BorderSide(
                                      //         color: Colors.grey),
                                      //     borderRadius: BorderRadius.circular(
                                      //         screenWidth * 0.05),
                                      //   ),
                                      //   focusedBorder: OutlineInputBorder(
                                      //     borderSide: const BorderSide(
                                      //         color: Colors.grey),
                                      //     borderRadius: BorderRadius.circular(
                                      //       screenWidth * 0.05,
                                      //     ),
                                      //   ),
                                      // ),
                                      // validator: (value) {
                                      //   if (value == null) {
                                      //     return "Please select role";
                                      //   } else {
                                      //     return null;
                                      //   }
                                      // },
                                      iconOnClick: const Icon(
                                        Icons.arrow_drop_up,
                                        color: Colors.grey,
                                      ),
                                      hint: const Text("Continue as"),
                                      value: selectedRole,
                                      // icon: const SizedBox.shrink(),
                                      icon: const Icon(
                                        Icons.arrow_drop_down,
                                        color: Colors.grey,
                                      ),
                                      items: roles
                                          .map((item) =>
                                              DropdownMenuItem<String>(
                                                value: item,
                                                child: Text(item),
                                              ))
                                          .toList(),
                                      // roles.map((String item) {
                                      //   return DropDownMenuItem<String>(
                                      //     value: item,
                                      //     child: Column(
                                      //       children: [
                                      //         Container(
                                      //             alignment: Alignment.bottomLeft,
                                      //             padding: EdgeInsets.only(
                                      //                 top: screenHeight * 0.03),
                                      //             child: Text(item)),
                                      //         (roles.last != item)
                                      //             ? const Divider(
                                      //                 color: Colors.black,
                                      //               )
                                      //             : Container(
                                      //                 height: 0,
                                      //               ),
                                      //       ],
                                      //     ),
                                      //   );
                                      // }).toList(),
                                      onChanged: (String? newValue) {
                                        setState(() {
                                          selectedRole = newValue!;
                                        });
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
