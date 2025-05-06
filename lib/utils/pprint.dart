import 'package:flutter/foundation.dart';

void pprint(dynamic str) {
  if (kDebugMode) {
    print('🦞🦞🦞🦞🦞🦞🦞🦞🦞🦞🦞🦞🦞🦞🦞');
    print(str);
  }
}

void kPrint(dynamic str) {
  if (kDebugMode) {
    print(str);
  }
}