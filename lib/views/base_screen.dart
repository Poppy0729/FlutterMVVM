import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mvvm_template/config/app_theme.dart';
import 'package:flutter_mvvm_template/utils/widget_key.dart';
import 'package:flutter_mvvm_template/view_models/base_view_model.dart';
import 'package:flutter_mvvm_template/views/popup/popup_information_screen.dart';

abstract class BaseScreen extends StatefulWidget {
  const BaseScreen({super.key});
}

abstract class BaseScreenState<Page extends BaseScreen> extends State<Page> {}

mixin BasePageScreen<Page extends BaseScreen> on BaseScreenState<Page> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  DialogRoute? dialog;

  @override
  void initState() {
    super.initState();
    checkWifi();
  }

  void showPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => PopupInformationScreen(
        title: 'Error',
        message: 'กรุณาเชื่อมต่ออินเทอร์เน็ต',
        cancelCallback: () {},
        confirmCallback: () {},
      ),
    );
  }

  void showSnackBar(BuildContext context, String message, Color backgroud,
      {Duration duration = const Duration(seconds: 1)}) {
    Future.delayed(const Duration(milliseconds: 10), () {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          padding: const EdgeInsets.only(left: 24, right: 10 ,top: 10, bottom: 10),
          width: MediaQuery.of(context).size.width - 40,
          backgroundColor: backgroud,
          content: Text(message ,style: const TextStyle(fontSize: 18),),
          duration: duration,
          showCloseIcon: true,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6.0),
          ),
          behavior: SnackBarBehavior.floating,
        ),
      );
    });
  }

  Widget? onChangedState(LoadingState status, {bool isTransparent = false}) {
    switch (status) {
      case LoadingState.loading:
        showLoading(isTransparent: isTransparent);
        return null;
      case LoadingState.onError:
        hideLoading();
        return null;
      default:
        hideLoading();
        return null;
    }
  }

  showLoading({bool isTransparent = false}) {
    if (!(dialog?.isActive ?? false)) {
      Future.delayed(const Duration(milliseconds: 5), () {
        dialog = DialogRoute(
            barrierColor: isTransparent ? Colors.transparent : Colors.black.withOpacity(0.5),
            context: context,
            builder: (_) {
              return Center(
                key: WidgetKey.popupKeys.loading,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 50,
                      width: 50,
                      child: CircularProgressIndicator(
                        color: isTransparent ? Colors.transparent : AppTheme.loadingColor,
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    if (!isTransparent) Text(
                      'LOADING...',
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(fontWeight: FontWeight.w400),
                    )
                  ],
                ),
              );
            },
            barrierDismissible: false);
        Navigator.of(context).push(dialog!);
      });
    }
  }

  hideLoading() {
    if (dialog?.isActive ?? false) {
      Navigator.of(context).removeRoute(dialog!);
    }
  }

  void shawSnackBar(BuildContext context, String message, Color backgroud) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: backgroud,
        content: Text(message),
      ),
    );
  }

  checkWifi() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    bool connectedToWifi = (connectivityResult.isNotEmpty && connectivityResult[0] != ConnectivityResult.none);
    if (!connectedToWifi) {
      // ignore: use_build_context_synchronously
      showSnackBar(
        context, 'กรุณาเชื่อมต่ออินเทอร์เน็ต', 
        AppTheme.snackBarOrange, 
        duration: const Duration(seconds: 4)
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
