import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
class CustomOtpField extends StatelessWidget {
  final Function onCompleted;
  final double padding;
  const CustomOtpField({Key? key,required this.onCompleted, this.padding = 0.0}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: padding),
      child: PinCodeTextField(
        appContext: context,
        length: 4,
        obscureText: false,
        cursorColor: Theme.of(context).primaryColor,
        animationType: AnimationType.fade,
        showCursor: true,
        keyboardType: TextInputType.number,
        pinTheme: PinTheme(
          shape: PinCodeFieldShape.box,
          borderRadius: BorderRadius.circular(5),
          fieldHeight: 50,
          fieldWidth: 50,
          activeFillColor: Theme.of(context).cardColor,
          selectedColor: Theme.of(context).textTheme.titleLarge!.color,
          selectedFillColor: Theme.of(context).primaryColor,
          inactiveFillColor: Theme.of(context).cardColor,
          inactiveColor: Theme.of(context).primaryColor.withOpacity(0.2),
          activeColor: Theme.of(context).primaryColor.withOpacity(0.4),
          borderWidth: 0.1,

        ),
        animationDuration: const Duration(milliseconds: 300),
        backgroundColor: Colors.transparent,
        enableActiveFill: true,
        onCompleted: onCompleted as void Function(String)?,
        onChanged: (value) {
        },
        beforeTextPaste: (text) {
          return true;
        },
      ),
    );
  }
}
