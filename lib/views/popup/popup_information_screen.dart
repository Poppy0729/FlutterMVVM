// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_mvvm_template/config/app_theme.dart';
import 'package:flutter_mvvm_template/utils/widget_key.dart';

class PopupInformationScreen extends StatelessWidget {
  final String title;
  final String message;
  final AssetImage? icon;
  final String? strConfirm;
  final String? strCancel;
  final bool? showCloseBtn;
  final bool? isShowIconBack;
  final AssetImage? iconConfirm;
  final Color? bgColor;
  final Color? buttonColor;
  final Color? messageColor;
  final bool popConfirmCallback;
  final Color buttonBorderColor;
  final Color? buttonMessageColor;
  final RichText? customMessage;
  final bool? isShowDropdown;
  final String? dropdownText;

  final VoidCallback cancelCallback;
  final VoidCallback? confirmCallback;

  const PopupInformationScreen({
    Key? key,
    required this.title,
    required this.message,
    this.icon,
    this.strConfirm,
    this.strCancel = 'ยกเลิก',
    this.showCloseBtn = true,
    this.isShowIconBack = false,
    this.iconConfirm,
    this.bgColor,
    this.buttonColor,
    this.messageColor,
    this.popConfirmCallback = true,
    this.buttonBorderColor = Colors.transparent,
    this.buttonMessageColor,
    this.customMessage,
    this.isShowDropdown = false,
    this.dropdownText,
    required this.cancelCallback,
    this.confirmCallback,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: bgColor ?? Theme.of(context).primaryColor,
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            if(showCloseBtn == true)
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.only(right: 15, top: 10),
                child: GestureDetector(
                  key: WidgetKey.popupKeys.close,
                  onTap: () { 
                    Navigator.of(context).pop(); 
                    cancelCallback();
                  },
                  child: const Icon(Icons.close, color: Colors.white, size: 32,)
                ),
              ),
            ),
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 100),
                  if (icon != null) Image(
                      image: AssetImage(icon!.assetName),
                      width: 130,),
                  if (title.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 70),
                    child: Text(title,
                    textAlign: TextAlign.center,
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium!
                        .copyWith(fontSize: 28)),
                  ),
                  const SizedBox(height: 30),
                  if (message != '') Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 70),
                    child: Text(message,
                      textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .copyWith(fontSize: 28, color: messageColor)),
                  ),
                  if (message == '') Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 70),
                    child: customMessage,
                  ),
                  SizedBox(height: isShowDropdown??false ? 0 : 88),
                ],
              ),
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if (strConfirm != null && isShowDropdown == false) confirmButton(context),
                  const SizedBox( height: 16),
                  if(showCloseBtn == true)
                  ElevatedButton(
                    key: WidgetKey.popupKeys.cancel,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      foregroundColor: Colors.white,
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                      cancelCallback();
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (isShowIconBack == true) Image.asset(
                          'assets/images/ic-arrow-left.png',
                          width: 20,
                        ),
                        if (isShowIconBack == true) const SizedBox(width: 6,),
                        Text(
                          strCancel ?? 'Cancel',
                          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget confirmButton(BuildContext context) {
    return ElevatedButton(
      key: WidgetKey.popupKeys.confirm,
      style: ElevatedButton.styleFrom(
        backgroundColor: buttonColor,
        side: BorderSide(color: buttonBorderColor)
      ),
      onPressed: () {
        if (popConfirmCallback) Navigator.of(context).pop();
        if (confirmCallback != null) confirmCallback!();
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (iconConfirm != null) Image(
                image: AssetImage(iconConfirm!.assetName),
                width: 16,
              ),
          if (iconConfirm != null) const SizedBox(width: 8,),
          Text(strConfirm ?? 'Confirm',
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              color: buttonMessageColor ?? AppTheme.textButtonColor,
              fontWeight: FontWeight.bold,
            )
          ),
        ],
      ),
    );
  }
}
