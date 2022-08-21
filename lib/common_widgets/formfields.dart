import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:nakshekadam/services/Firebase/fireauth/fireauth.dart';

TextFormField normalformfield(
  TextEditingController controller,
  double screenWidth,
  Function setState,
  String hintText,
  TextInputType keyboardType,
) {
  return TextFormField(
    controller: controller,
    onChanged: (value) {
      setState(() {});
    },
    validator: (value) {
      if (value!.isEmpty) {
        return "Please enter your $hintText";
      } else {
        return null;
      }
    },
    inputFormatters: [
      FilteringTextInputFormatter.singleLineFormatter,
    ],
    keyboardType: keyboardType,
    decoration: InputDecoration(
      hintText: hintText,
      filled: true,
      fillColor: const Color(0xffF8F9FE),
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.grey),
        borderRadius: BorderRadius.circular(screenWidth * 0.05),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.grey),
        borderRadius: BorderRadius.circular(screenWidth * 0.05),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.grey),
        borderRadius: BorderRadius.circular(screenWidth * 0.05),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.grey),
        borderRadius: BorderRadius.circular(screenWidth * 0.05),
      ),
    ),
  );
}

TextFormField phoneformfield(
  TextEditingController phoneController,
  double screenWidth,
  Function setState,
) {
  return TextFormField(
    controller: phoneController,
    validator: (value) {
      if (value == null || value.isEmpty) {
        return "Please enter your number";
      } else if (value.length != 10) {
        return "Mobile number is 10 length long";
      } else if (!(value[0] == '5' ||
          value[0] == '6' ||
          value[0] == '7' ||
          value[0] == '8' ||
          value[0] == '9')) {
        return "Invalid mobile number";
      } else {
        return null;
      }
    },
    inputFormatters: [
      FilteringTextInputFormatter.singleLineFormatter,
    ],
    keyboardType: TextInputType.emailAddress,
    decoration: InputDecoration(
      hintText: "Phone Number",
      filled: true,
      fillColor: const Color(0xffF8F9FE),
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.grey),
        borderRadius: BorderRadius.circular(screenWidth * 0.05),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.grey),
        borderRadius: BorderRadius.circular(screenWidth * 0.05),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.grey),
        borderRadius: BorderRadius.circular(screenWidth * 0.05),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.grey),
        borderRadius: BorderRadius.circular(screenWidth * 0.05),
      ),
    ),
  );
}

bool isValidEmail(String input) {
  return RegExp(
          r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
      .hasMatch(input);
}

TextFormField emailformfield(
  TextEditingController emailController,
  double screenWidth,
  Function setState,
  String errorTextEmail,
) {
  return TextFormField(
    controller: emailController,
    onChanged: (value) {
      setState(() {});
    },
    validator: (value) {
      if (!isValidEmail(value as String)) {
        return "Check if mail is valid";
      } else {
        return null;
      }
    },
    inputFormatters: [
      FilteringTextInputFormatter.singleLineFormatter,
    ],
    keyboardType: TextInputType.emailAddress,
    decoration: InputDecoration(
      hintText: "Email",
      filled: true,
      fillColor: const Color(0xffF8F9FE),
      errorText: errorTextEmail == '' ? null : errorTextEmail,
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.grey),
        borderRadius: BorderRadius.circular(screenWidth * 0.05),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.grey),
        borderRadius: BorderRadius.circular(screenWidth * 0.05),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.grey),
        borderRadius: BorderRadius.circular(screenWidth * 0.05),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.grey),
        borderRadius: BorderRadius.circular(screenWidth * 0.05),
      ),
    ),
  );
}

class PasswordFormField extends StatefulWidget {
  const PasswordFormField({
    Key? key,
    required this.passwordController,
    required this.errorTextPassword,
    required this.hintText,
  }) : super(key: key);
  final TextEditingController passwordController;
  final String errorTextPassword;
  final String hintText;
  @override
  State<PasswordFormField> createState() => _PasswordFormFieldState();
}

class _PasswordFormFieldState extends State<PasswordFormField> {
  bool hidePassword = true;
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
    return TextFormField(
      controller: widget.passwordController,
      onChanged: (value) {
        setState(() {});
      },
      validator: (value) {
        return null;
      },
      inputFormatters: [
        FilteringTextInputFormatter.singleLineFormatter,
      ],
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        filled: true,
        fillColor: const Color(0xffF8F9FE),
        hintText: widget.hintText,
        errorText:
            widget.errorTextPassword == '' ? null : widget.errorTextPassword,
        suffixIcon: IconButton(
          padding: EdgeInsets.only(right: screenWidth * 0.07),
          onPressed: () {
            print("tapped");

            setState(() => hidePassword = !hidePassword);
          },
          icon: Icon(
            hidePassword
                ? Icons.visibility_off_outlined
                : Icons.visibility_outlined,
            color: Colors.black,
            size: screenWidth * 0.08,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.grey),
          borderRadius: BorderRadius.circular(screenWidth * 0.05),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.grey),
          borderRadius: BorderRadius.circular(screenWidth * 0.05),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.grey),
          borderRadius: BorderRadius.circular(screenWidth * 0.05),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.grey),
          borderRadius: BorderRadius.circular(screenWidth * 0.05),
        ),
      ),
      obscureText: hidePassword,
    );
  }
}

class CustomDropDownField extends StatefulWidget {
  const CustomDropDownField({
    Key? key,
    required this.selectedItem,
    required this.items,
    required this.hintText,
  }) : super(key: key);
  final TextEditingController selectedItem;
  final List<String> items;
  final String hintText;
  @override
  State<CustomDropDownField> createState() => _CustomDropDownField();
}

class _CustomDropDownField extends State<CustomDropDownField> {
  bool hidePassword = true;
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
    return DropdownButtonFormField2<String>(
      dropdownDecoration: BoxDecoration(
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.all(Radius.circular(screenWidth * 0.05)),
        border: Border.all(
          color: Colors.black,
        ),
      ),
      dropdownOverButton: false,
      // dropdownWidth: screenWidth * 0.85,
      isExpanded: true,
      itemHeight: kMinInteractiveDimension + screenHeight * 0.02,
      dropdownFullScreen: true,

      decoration: InputDecoration(
        filled: true,
        fillColor: const Color(0xffF8F9FE),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.grey),
          borderRadius: BorderRadius.circular(screenWidth * 0.05),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.grey),
          borderRadius: BorderRadius.circular(screenWidth * 0.05),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.grey),
          borderRadius: BorderRadius.circular(screenWidth * 0.05),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.grey),
          borderRadius: BorderRadius.circular(
            screenWidth * 0.05,
          ),
        ),
      ),
      validator: (value) {
        if (value == null) {
          return "Please select role";
        } else {
          return null;
        }
      },
      iconOnClick: const Icon(
        Icons.arrow_drop_up,
        color: Colors.grey,
      ),
      hint: FittedBox(
          fit: BoxFit.contain,
          child: Text(
            widget.hintText,
            softWrap: true,
          )),
      value: (widget.selectedItem.text == "") ? null : widget.selectedItem.text,
      // icon: const SizedBox.shrink(),
      icon: const Icon(
        Icons.arrow_drop_down,
        color: Colors.grey,
      ),
      items: widget.items
          .map((item) => DropdownMenuItem<String>(
                value: item,
                child: Text(item),
              ))
          .toList(),
      onChanged: (String? newValue) {
        setState(() {
          widget.selectedItem.text = newValue!;
        });
      },
    );
  }
}

class CustomDropDownFieldMultiLine extends StatefulWidget {
  const CustomDropDownFieldMultiLine({
    Key? key,
    required this.selectedItem,
    required this.items,
    required this.hintText,
  }) : super(key: key);
  final TextEditingController selectedItem;
  final List<String> items;
  final String hintText;
  @override
  State<CustomDropDownFieldMultiLine> createState() =>
      _CustomDropDownFieldMultiLine();
}

class _CustomDropDownFieldMultiLine
    extends State<CustomDropDownFieldMultiLine> {
  bool hidePassword = true;
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
    return DropdownButtonFormField2<String>(
      dropdownDecoration: BoxDecoration(
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.all(Radius.circular(screenWidth * 0.05)),
        border: Border.all(
          color: Colors.black,
        ),
      ),
      dropdownOverButton: true,
      scrollbarAlwaysShow: true,
      // dropdownWidth: screenWidth * 0.85,
      isExpanded: true,
      itemHeight: kMinInteractiveDimension + screenHeight * 0.02,
      dropdownFullScreen: true,
      customItemsIndexes:
          widget.items.map((item) => widget.items.indexOf(item)).toList(),
      customItemsHeight: screenHeight * 0.1,
      // dropdownPadding: EdgeInsets.only(bottom: screenHeight * 0.05),
      selectedItemHighlightColor: Colors.blueGrey[50],
      // itemPadding: EdgeInsets.only(bottom: screenHeight * 0.05, left: screenWidth * 0.05, right: screenWidth * 0.05),
      decoration: InputDecoration(
        hintMaxLines: 2,
        filled: true,
        fillColor: const Color(0xffF8F9FE),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.grey),
          borderRadius: BorderRadius.circular(screenWidth * 0.05),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.grey),
          borderRadius: BorderRadius.circular(screenWidth * 0.05),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.grey),
          borderRadius: BorderRadius.circular(screenWidth * 0.05),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.grey),
          borderRadius: BorderRadius.circular(
            screenWidth * 0.05,
          ),
        ),
      ),
      validator: (value) {
        if (value == null) {
          return "Please select role";
        } else {
          return null;
        }
      },
      isDense: false,
      iconOnClick: const Icon(
        Icons.arrow_drop_up,
        color: Colors.grey,
      ),
      hint: Text(widget.hintText, softWrap: true),
      value: (widget.selectedItem.text == "") ? null : widget.selectedItem.text,
      // icon: const SizedBox.shrink(),
      icon: const Icon(
        Icons.arrow_drop_down,
        color: Colors.grey,
      ),
      items: widget.items
          .map(
            (item) => DropdownMenuItem<String>(
              value: item,
              child: Text(
                item,
                overflow: TextOverflow.visible,
              ),
            ),
          )
          .toList(),
      onChanged: (String? newValue) {
        setState(() {
          widget.selectedItem.text = newValue!;
        });
      },
    );
  }
}

class SearchFormField extends StatelessWidget {
  const SearchFormField({
    Key? key,
    required this.searchController,
    required this.hintText,
    required this.redirectFunction,
  }) : super(key: key);
  final TextEditingController searchController;
  final String hintText;
  final void Function() redirectFunction;

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
    return Card(
      color: Colors.white,
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(screenWidth * 0.03),
      ),
      child: TextFormField(
        controller: searchController,
        onChanged: (value) {
          // setState(() {});
        },
        validator: (value) {
          return null;
        },
        inputFormatters: [
          FilteringTextInputFormatter.singleLineFormatter,
        ],
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: screenHeight * 0.005),
          filled: true,
          hintStyle: TextStyle(
            color: Colors.grey,
            fontSize: screenWidth * 0.037,
          ),
          fillColor: Colors.white,
          hintText: hintText,
          prefixIcon: IconButton(
            // padding: EdgeInsets.only(left: screenWidth * 0.07),
            onPressed: () {},
            icon: Icon(
              Icons.search_rounded,
              color: Colors.grey,
              size: screenWidth * 0.08,
            ),
          ),
          suffixIcon: IconButton(
            padding: EdgeInsets.only(right: screenWidth * 0.07),
            onPressed: redirectFunction,
            icon: Icon(
              CupertinoIcons.slider_horizontal_3,
              color: Colors.deepOrange,
              size: screenWidth * 0.08,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.grey),
            borderRadius: BorderRadius.circular(screenWidth * 0.03),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.grey),
            borderRadius: BorderRadius.circular(screenWidth * 0.03),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.grey),
            borderRadius: BorderRadius.circular(screenWidth * 0.03),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.grey),
            borderRadius: BorderRadius.circular(screenWidth * 0.03),
          ),
        ),
      ),
    );
  }
}

TextFormField mutliLineTestFormField(TextEditingController controller,
        String hintText, double screenWidth, int maxLines) =>
    TextFormField(
      onChanged: (value) {
        // setState(() {});
      },
      controller: controller,
      keyboardType: TextInputType.multiline,
      minLines: maxLines,
      maxLines: null,
      maxLengthEnforcement: MaxLengthEnforcement.enforced,
      maxLength: 100,
      decoration: InputDecoration(
        counterText: "",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(screenWidth * 0.05),
          ),
        ),
        filled: false,
        alignLabelWithHint: true,
        label: Text(
          hintText,
          style: TextStyle(
              fontFamily: 'DM SANS',
              fontSize: screenWidth * 0.04,
              color: Colors.grey),
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Please enter a message";
        } else {
          return null;
        }
      },
    );
