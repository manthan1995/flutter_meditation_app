import 'package:flutter/material.dart';
import 'package:meditation_app/constant/colors.dart';

class CommanMaterialButton extends StatelessWidget {
  const CommanMaterialButton({
    Key? key,
    this.textColor = Colours.blackColor,
    required this.buttonColor,
    required this.buttonText,
    required this.onPressed,
    this.fontWeight,
    this.buttonWidth,
  }) : super(key: key);
  final Color textColor;
  final Color buttonColor;
  final void Function() onPressed;
  final String buttonText;
  final FontWeight? fontWeight;
  final double? buttonWidth;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      minWidth: buttonWidth ?? 170,
      height: 70,
      onPressed: onPressed,
      color: buttonColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50),
      ),
      child: Text(
        buttonText,
        style: TextStyle(
          fontSize: 20,
          fontFamily: 'FuturaMediumBT',
          fontWeight: FontWeight.w600,
          letterSpacing: 0.78,
          color: textColor,
        ),
      ),
    );
  }
}

class DesignSocialLogo extends StatelessWidget {
  const DesignSocialLogo({
    Key? key,
    required this.logoImage,
    required this.onTap,
  }) : super(key: key);
  final String logoImage;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: CircleAvatar(
        radius: MediaQuery.of(context).size.height * 0.04,
        backgroundColor: Colors.transparent,
        backgroundImage: AssetImage(
          logoImage,
        ),
      ),
    );
  }
}
