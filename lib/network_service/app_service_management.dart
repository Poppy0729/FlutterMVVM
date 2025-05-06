import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mvvm_template/utils/pprint.dart';

// ignore: constant_identifier_names
const CERTIFICATE_PATH = 'assets/certificates/AmazonRootCA4.pem';

Future<void> checkCertificate(Dio dio) async {
  var certBytes = await rootBundle.load(CERTIFICATE_PATH);

  if (!Platform.environment.containsKey('FLUTTER_TEST')) {
    // allow self-signed certificate
    (dio.httpClientAdapter as IOHttpClientAdapter).createHttpClient = () {
      SecurityContext sc = SecurityContext();
      var list = certBytes.buffer.asInt8List();
      sc.setTrustedCertificatesBytes(list);
      HttpClient httpClient = HttpClient(context: sc);
      httpClient.badCertificateCallback =
          (cert, host, port) {
        pprint('Bad Certificate');
        return false;
      };
      return httpClient;
    };
  }
}