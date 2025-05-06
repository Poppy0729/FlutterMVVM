// // ignore_for_file: use_build_context_synchronously
// import 'dart:io';
// import 'package:app_settings/app_settings.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:location/location.dart';
// import 'package:permission_handler/permission_handler.dart'
//     as permission_handler;
// import '../views/popup/popup_information_screen.dart';

// class NativePermission {
//   static final NativePermission _nativePermission = NativePermission();
//   static NativePermission get shared => _nativePermission;

//   bool isAllowPermission = false;
//   bool isGettingLocation = false;
//   LocationData? locationData;

//   Future<bool> checkPermissionLocation(BuildContext context) async {
//     Location location = Location();
//     bool serviceEnabled;
//     PermissionStatus permissionGranted;

//     serviceEnabled = await location.serviceEnabled();
//     if (!serviceEnabled) {
//       serviceEnabled = await location.requestService();
//       if (!serviceEnabled) {
//         isAllowPermission = false;
//         showPopupPermissionSetting(context);
//         return false;
//       }
//     }
//     permissionGranted = await location.hasPermission();
//     if (permissionGranted == PermissionStatus.denied) {
//       permissionGranted = await location.requestPermission();
//       if (permissionGranted != PermissionStatus.granted) {
//         isAllowPermission = false;
//         showPopupPermissionSetting(context);
//         return false;
//       }
//     }

//     isAllowPermission = true;
//     await getCurrentLocation(context);
//     return true;
//   }

//   getCurrentLocation(BuildContext context) async {
//     if (isAllowPermission) {
//       Location location = Location();
//       final currentLocation = await location.getLocation();
//       isGettingLocation = true;
//       locationData = currentLocation;
//       if (kDebugMode) {
//         print(
//             'lat: ${currentLocation.latitude}, long: ${currentLocation.longitude}');
//       }
//     } else {
//       showPopupPermissionSetting(context);
//     }
//   }

//   Future<bool> checkPermissionBluetooth(BuildContext context) async {
//     Map<permission_handler.Permission, permission_handler.PermissionStatus>
//         statuses = await [
//       permission_handler.Permission.bluetoothScan,
//       permission_handler.Permission.bluetoothConnect,
//     ].request();

//     if (statuses[permission_handler.Permission.bluetoothScan] ==
//             permission_handler.PermissionStatus.granted &&
//         statuses[permission_handler.Permission.bluetoothScan] ==
//             permission_handler.PermissionStatus.granted) {
//       // permission granted
//       return true;
//     } else {
//       showPopupPermissionSetting(context);
//       return false;
//     }
//   }

//   void showPopupPermissionSetting(BuildContext context) {
//     showGeneralDialog(
//         context: context,
//         pageBuilder: (BuildContext buildContext, Animation animation,
//             Animation secondaryAnimation) {
//           return PopupInformationScreen(
//             title: '',
//             message: '',
//             strConfirm: 'ตั้งค่า Application',
//             strCancel: 'ปิดหน้าต่างนี้',
//             icon: const AssetImage('assets/images/popup/ic-setting.png'),
//             customMessage: RichText(
//               textAlign: TextAlign.center,
//               text: TextSpan(
//                 children: [
//                   TextSpan(
//                     text:
//                         'คุณไม่ได้อนุญาตให้ Application\nเข้าถึงการใช้งาน กรุณาไปที่ ',
//                     style: Theme.of(context).textTheme.titleMedium!.copyWith(
//                           fontWeight: FontWeight.w500,
//                           fontSize: 32,
//                         ),
//                   ),
//                   TextSpan(
//                     text: 'ตั้งค่า',
//                     style: Theme.of(context).textTheme.titleMedium!.copyWith(
//                           fontWeight: FontWeight.w500,
//                           fontSize: 32,
//                           color: AppTheme.yellowColor,
//                           decoration: TextDecoration.underline,
//                           decorationColor: AppTheme.yellowColor,
//                         ),
//                   ),
//                 ],
//               ),
//             ),
//             cancelCallback: () {
//               exit(0);
//             },
//             confirmCallback: () {
//               AppSettings.openAppSettings(type: AppSettingsType.settings);
//             },
//           );
//         });
//   }
// }
