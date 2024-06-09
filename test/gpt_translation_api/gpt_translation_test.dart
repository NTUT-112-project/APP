

import 'dart:convert';
// 📦 Package imports:
import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:school_project/api/Controller.dart';
import 'package:school_project/api/gpt/gpt_translate.dart';
import 'package:school_project/api/gpt/gpt_translate_api.dart';
import 'package:school_project/api/user/user.dart';
import 'package:school_project/api/user/user_api.dart';

void main() {
  group('gptTranslationTest',(){
    final gptTranslationApi=GptTranslateApi();
    gptTranslationApi.gptTranslate=GptTranslate('chinese','french','早上好我有冰淇林');

    setUp(() {

    });
    test('simpleTranslate', () async {
      final response=await gptTranslationApi.translate();
      debugPrint(response.data.toString());
      expect(response.success, true);
    });
  });

}
