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
      fillColor: Colors.white,
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
      hintText: "Email",
      filled: true,
      fillColor: Colors.white,
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
      fillColor: Colors.white,
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
    final List<double> tempDimensions = [MediaQuery.of(context).size.width,MediaQuery.of(context).size.height];
    final double screenHeight = tempDimensions[0] > tempDimensions[1] ? tempDimensions[0] : tempDimensions[1];
    final double screenWidth = tempDimensions[0] > tempDimensions[1] ? tempDimensions[1] : tempDimensions[0];
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
        fillColor: Colors.white,
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
