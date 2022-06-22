import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:meditation_app/constant/colors.dart';
import 'package:meditation_app/constant/strings.dart';
import 'package:meditation_app/widgtes/buttons.dart';
import 'package:meditation_app/widgtes/textfiled.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  TextEditingController emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colours.blackColor,
      body: SafeArea(
        child: Stack(
          children: [
            buildBackButton(),
            Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.05,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        Strings.forgotPassword,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize:
                                MediaQuery.of(context).size.height * 0.035,
                            color: Colours.whiteColor,
                            fontFamily: 'Recoleta-SemiBold'),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.078,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: buildForgotForm(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildBackButton() {
    return Padding(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).size.height * 0.06,
        left: 10,
      ),
      child: GestureDetector(
        onTap: () async {
          await HapticFeedback.mediumImpact();
          Navigator.of(context).pop();
        },
        child: const Icon(
          Icons.arrow_back_ios_new,
          color: Colours.whiteColor,
        ),
      ),
    );
  }

  Widget buildForgotForm() {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(
            left: MediaQuery.of(context).size.width * 0.08,
            right: MediaQuery.of(context).size.width * 0.08,
          ),
          child: const Text(
            Strings.forgotSubtitleStr,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontWeight: FontWeight.w200, color: Colours.greyColor),
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.05,
        ),
        CommanTextFiled(
          controller: emailController,
          hintText: Strings.emailStr,
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.08,
        ),
        buildSendButton(),
      ],
    );
  }

  Widget buildSendButton() {
    return CommanMaterialButton(
      buttonWidth: 190,
      buttonText: Strings.sendStr,
      buttonColor: Colours.whiteColor,
      onPressed: () async {
        await HapticFeedback.mediumImpact();
      },
    );
  }
}
