import 'package:flutter/material.dart';

class WidgetKey {
  static PopupKeys popupKeys = PopupKeys();
}

class PopupKeys {
  Key get loading => const Key('Loading');
  Key get confirm => const Key('Confirm');
  Key get cancel => const Key('Cancel');
  Key get close => const Key('Close');
}
