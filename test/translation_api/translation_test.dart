import 'dart:convert';
// 📦 Package imports:
import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:school_project/api/Controller.dart';
import 'package:school_project/api/llm/translate.dart';
import 'package:school_project/api/llm/translate_api.dart';
import 'package:school_project/api/user/user.dart';
import 'package:school_project/api/user/user_api.dart';

void main() {
  group('TranslationTest', () {
    final translationApi = TranslateApi();
    translationApi.translate = Translate('chinese', 'french', '早上好我有冰淇林', "key");

    setUp(() {});
    test('simpleTranslate', () async {
      final response = await translationApi.getTranslateResult();
      debugPrint(response.data.toString());
      expect(response.success, true);
    });
  });
}
