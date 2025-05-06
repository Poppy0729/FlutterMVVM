import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../view_models/providers/splash_view_model.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) {
        SplashViewModel splashViewModel = SplashViewModel();
        splashViewModel.context = context;
        return splashViewModel;
      },
      child: Consumer<SplashViewModel>(
        builder: (context, data, widget) {
          return Scaffold(
            body: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).highlightColor,
                image: const DecorationImage(
                  image: AssetImage("assets/images/imv-card.png"),
                  fit: BoxFit.fill,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
