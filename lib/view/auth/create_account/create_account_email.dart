import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:meditation_app/constant/colors.dart';
import 'package:meditation_app/constant/preferences_key.dart';
import 'package:meditation_app/constant/strings.dart';
import 'package:meditation_app/model/auth/create_account_model.dart';
import 'package:meditation_app/model/user_model.dart';
import 'package:meditation_app/provider/auth_provider/create_account_provider.dart';
import 'package:meditation_app/view/auth/create_account/create_account_screen.dart';
import 'package:meditation_app/widgtes/buttons.dart';
import 'package:meditation_app/widgtes/cicualer_indicator.dart';
import 'package:meditation_app/widgtes/textfiled.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import '../../../bottom_bar.dart';
import '../../profile_screen/profile_purchase_screen.dart';
import '../login_screen.dart';

class CreateAccountEmailScreen extends StatefulWidget {
  const CreateAccountEmailScreen({Key? key}) : super(key: key);

  @override
  State<CreateAccountEmailScreen> createState() =>
      _CreateAccountEmailScreenState();
}

class _CreateAccountEmailScreenState extends State<CreateAccountEmailScreen> {
  TextEditingController usernamneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController companyCodeController = TextEditingController();
  CreateAccountProvider createAccountProvider = CreateAccountProvider();
  late Map<String, dynamic> prefData;

  @override
  void initState() {
    createAccountProvider =
        Provider.of<CreateAccountProvider>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colours.blackColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildBackButton(),
              buildSignUpEmployeeView(),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildSignUpEmployeeView() {
    return Center(
      child: Padding(
        padding: EdgeInsets.only(
          left: MediaQuery.of(context).size.width * 0.09,
          right: MediaQuery.of(context).size.width * 0.09,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.08,
              ),
              Align(
                alignment: Alignment.center,
                child: Text(
                  Strings.signUpStr,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: MediaQuery.of(context).size.height * 0.045,
                      color: Colours.whiteColor,
                      fontFamily: 'Recoleta-SemiBold'),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.055,
              ),
              buildSignUpForm(),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildSignUpForm() {
    return Consumer<CreateAccountProvider>(
      builder: (context, valueOfCreateAccount, child) => Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          buildUsernameFiled(),
          const SizedBox(
            height: 20,
          ),
          buildEmailFiled(),
          const SizedBox(
            height: 20,
          ),
          buildPasswordFiled(),
          const SizedBox(
            height: 20,
          ),
          buildCompanyCodeFile(),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.1,
          ),
          buildSignUpButton(valueOfCreateAccount),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.02,
          ),
          // signUpEmployee(),
        ],
      ),
    );
  }

  Widget buildBackButton() {
    return Padding(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).size.height * 0.05,
        left: MediaQuery.of(context).size.height * 0.02,
      ),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).pop(PageTransition(
              duration: const Duration(milliseconds: 400),
              type: PageTransitionType.fade,
              child: const CreateAccountScreen()));
        },
        child: const Icon(
          Icons.arrow_back_ios_new,
          color: Colours.whiteColor,
        ),
      ),
    );
  }

  Widget buildUsernameFiled() {
    return CommanTextFiled(
      keyboardType: TextInputType.name,
      controller: usernamneController,
      hintText: Strings.firstNameStr,
    );
  }

  Widget buildEmailFiled() {
    return CommanTextFiled(
      keyboardType: TextInputType.emailAddress,
      controller: emailController,
      hintText: Strings.emailStr,
    );
  }

  Widget buildPasswordFiled() {
    return CommanTextFiled(
      controller: passwordController,
      hintText: Strings.passwordStr,
      obscureText: true,
    );
  }

  Widget buildCompanyCodeFile() {
    return CommanTextFiled(
      controller: companyCodeController,
      hintText: Strings.companyCode,
    );
  }

  Widget buildSignUpButton(CreateAccountProvider valueOfCreateAccount) {
    return CommanMaterialButton(
      buttonWidth: 190,
      buttonText: Strings.signUpStr,
      buttonColor: Colours.whiteColor,
      onPressed: () async {
        await HapticFeedback.mediumImpact();
        if (emailController.text != '' &&
            passwordController.text != '' &&
            usernamneController.text != '') {
          showLoader(context: context);
          ApiResponseModel<CreateAccountModel> createResponse =
              await valueOfCreateAccount.createAccountProvider(
            email: emailController.text.trim(),
            password: passwordController.text.trim(),
            username: usernamneController.text.trim(),
            isSocial: false,
            userType:
                companyCodeController.text.isNotEmpty ? 'COMPANY' : 'NORMAL',
            companyCode: companyCodeController.text.isNotEmpty
                ? companyCodeController.text.trim()
                : '',
          );
          if (createResponse.data?.status == true) {
            var data = preferences.getString(Keys.userReponse);
            if (data != null) {
              prefData = jsonDecode(data);
              hideLoader(context: context);
              preferences.setString(
                  Keys.userId, createResponse.data!.data!.uSERID.toString());
              preferences.setString(
                  Keys.password, passwordController.text.trim());
              Navigator.push(
                context,
                PageTransition(
                  duration: const Duration(milliseconds: 400),
                  type: PageTransitionType.fade,
                  // child: const HomeScreen(),
                  child: prefData['data']['TYPE'] == 'COMPANY'
                      ? BottomBarscreen(selectBottmTab: 0)
                      : const ProfilePurchaseScreen(),
                ),
              );
            } else {
              hideLoader(context: context);
              return showCommanDialog(
                context: context,
                content: createResponse.data!.msg.toString(),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              );
            }
          } else {
            hideLoader(context: context);
            return showCommanDialog(
              context: context,
              content: createResponse.data!.msg.toString(),
              onPressed: () {
                Navigator.of(context).pop();
              },
            );
          }
        } else {
          hideLoader(context: context);
          return showCommanDialog(
            context: context,
            content: 'Please enter valid input',
            onPressed: () {
              Navigator.of(context).pop();
            },
          );
        }
      },
    );
  }

  Widget buildSignInButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        const Text(
          Strings.alreadyHaveAccount,
          style: TextStyle(
            color: Color.fromRGBO(255, 255, 255, 1),
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(
          width: 5,
        ),
        GestureDetector(
          onTap: () async {
            await HapticFeedback.mediumImpact();
            Navigator.push(
              context,
              PageTransition(
                duration: const Duration(milliseconds: 400),
                type: PageTransitionType.fade,
                child: const LoginScreen(),
              ),
            );
          },
          child: const Text(
            '${Strings.signInStr}.',
            style: TextStyle(
              decoration: TextDecoration.underline,
              color: Colours.whiteColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}
