import 'package:flutter/material.dart';
import 'package:meditation_app/constant/colors.dart';
import 'package:meditation_app/constant/strings.dart';

Future<void> showLoader({
  required BuildContext context,
}) {
  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return const Center(
        child: CircularProgressIndicator(
          color: Colours.appColor,
        ),
      );
    },
  );
}

void hideLoader({
  required BuildContext context,
}) {
  Navigator.of(context).pop();
}

Future<void> showCommanDialog({
  required BuildContext context,
  required String content,
  required void Function()? onPressed,
}) {
  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        title: const Text(
          Strings.alertStr,
          style: TextStyle(
            fontWeight: FontWeight.w600,
          ),
        ),
        content: Text(content),
        actions: [
          MaterialButton(
            onPressed: onPressed,
            color: Colours.blackColor,
            child: const Text(
              Strings.okStr,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colours.whiteColor,
              ),
            ),
          )
        ],
      );
    },
  );
}

// on exit show dialog
Future showCommanExitDialog({
  required BuildContext context,
  required String content,
  String? title = Strings.alertStr,
  required void Function()? okOnPressed,
  required void Function()? cancleOnPressed,
}) {
  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        title: Text(
          title!,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
          ),
        ),
        content: Text(content),
        actions: [
          MaterialButton(
            onPressed: cancleOnPressed,
            color: Colours.blackColor,
            child: const Text(
              Strings.cancleStr,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colours.whiteColor,
              ),
            ),
          ),
          MaterialButton(
            onPressed: okOnPressed,
            color: Colours.blackColor,
            child: const Text(
              Strings.okStr,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colours.whiteColor,
              ),
            ),
          )
        ],
      );
    },
  );
}
