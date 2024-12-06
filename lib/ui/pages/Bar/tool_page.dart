import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_overlay_window/flutter_overlay_window.dart';
import 'package:flutter/services.dart';
import 'package:language_picker/language_picker_dropdown_controller.dart';
import 'package:language_picker/languages.dart';
import 'package:language_picker/language_picker.dart';

import '../../../api/llm/translate.dart';
import '../../../api/llm/translate_api.dart';
import '../../../storage/storage.dart';

class ToolPage extends StatefulWidget {
  const ToolPage({super.key});

  @override
  State<StatefulWidget> createState() => _ToolPage();
}

class _ToolPage extends State<ToolPage> {
  final translationApi = TranslateApi();
  static const detect = Language('detect*', 'detect*', '(detect language)');
  final List<Language> languages = [
    detect,
    Languages.english,
    Languages.chineseTraditional,
    Languages.spanish,
    Languages.hindi,
    Languages.french,
    Languages.arabic,
    Languages.bengali,
    Languages.portuguese,
    Languages.russian,
    Languages.japanese,
    Languages.german,
    Languages.korean,
    Languages.vietnamese,
    Languages.italian,
    Languages.turkish,
    Languages.thai,
    Languages.persian,
    Languages.dutch,
    Languages.greekModern1453,
    Languages.polish,
  ];

  final srcLanguageController = LanguagePickerDropdownController(detect);
  final distLanguageController =
      LanguagePickerDropdownController(Languages.english);

  final srcTextController = TextEditingController();
  final distTextController = TextEditingController();
  bool isWindowRunning = false;
  bool translationInProgress = false;
  Translate lastTranslateRequest = Translate('', '', '', '', '');

  @override
  void dispose() {
    srcLanguageController.dispose();
    distLanguageController.dispose();
    srcTextController.dispose();
    distTextController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  Future<void> requestTranslate() async {
    if (srcTextController.text == '') return;

    if (translationInProgress) {
      log("previous request not end yet");
      return;
    }
    lastTranslateRequest = Translate(
        (srcLanguageController.value.name == '(detect language)')
            ? 'none'
            : srcLanguageController.value.name,
        distLanguageController.value.name,
        srcTextController.text,
        "none",
        UserStorage.instance.apiToken);
    log("making translation request");
    translationInProgress = true;
    distTextController.text = "${distTextController.text}...";

    translationApi.translate = lastTranslateRequest;
    final response = await translationApi.getTranslateResult();
    distTextController.text = response.data.toString();

    translationInProgress = false;
    if (lastTranslateRequest.srcText != srcTextController.text) {
      requestTranslate();
    }
  }

  Widget translateMenu() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: LanguagePickerDropdown(
                      initialValue: srcLanguageController.value,
                      controller: srcLanguageController,
                      languages: languages,
                      itemBuilder: _buildDropdownItem,
                      onValuePicked: (Language language) {
                        setState(() {
                          srcLanguageController.value = language;
                        });
                        requestTranslate();
                      },
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      if (srcLanguageController.value == languages[0]) return;
                      setState(() {
                        final Language temp = srcLanguageController.value;
                        srcLanguageController.value =
                            distLanguageController.value;
                        distLanguageController.value = temp;
                      });
                      requestTranslate();
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      padding: const EdgeInsets.all(3.0),
                      child: Icon(
                        Icons.swap_horiz,
                        size: 20.0,
                        color: (srcLanguageController.value == languages[0])
                            ? Colors.white10
                            : Colors.blue,
                      ),
                    ),
                  ),
                  Expanded(
                    child: LanguagePickerDropdown(
                      initialValue: distLanguageController.value,
                      controller: distLanguageController,
                      itemBuilder: _buildDropdownItem,
                      onValuePicked: (Language language) {
                        if (!mounted) return;
                        setState(() {
                          requestTranslate();
                          distLanguageController.value = language;
                        });
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width - 20,
                height: 300,
                child: Column(
                  children: [
                    Expanded(
                      child: TextField(
                        maxLines: 100,
                        style: TextStyle(color: Colors.white),
                        onChanged: (text) {
                          requestTranslate();
                        },
                        onTap: () async {
                          // log("text focus");
                          // final data =
                          //     await Clipboard.getData(Clipboard.kTextPlain);
                          // log('get clipboard data done');
                          // if (data != null &&
                          //     data.text != srcTextController.text) {
                          //   final text = data.text ?? '';
                          //   srcTextController.text = text;
                          //   log('got data from clipboard $text');
                          //   requestTranslate();
                          // } else {
                          //   log("got null");
                          // }
                        },
                        controller: srcTextController,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'copy something',
                            hintStyle: TextStyle(color: Colors.white30)),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width - 20,
                      child: const Divider(
                        height: 10,
                        thickness: 1,
                        color: Colors.white24,
                      ),
                    ),
                    Expanded(
                      child: TextField(
                        maxLines: 100,
                        readOnly: true,
                        controller: distTextController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.white, width: 10)),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDropdownItem(Language language) {
    return Row(
      children: <Widget>[
        SizedBox(
          width: 8.0,
        ),
        Text(
          "${language.name}",
          style: TextStyle(fontSize: 15),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    Color getColor(Set<MaterialState> states) {
      return (isWindowRunning) ? Colors.red : Colors.blue;
    }

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(padding: EdgeInsets.only(top: 100.0)),
            const Text(
                '  Real-time language translation\n and learning APP based on LLM',
                style: TextStyle(
                    color: Colors.blue,
                    fontSize: 24,
                    fontWeight: FontWeight.bold)),
            const SizedBox(
              height: 20,
            ),
            translateMenu(),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              style: ButtonStyle(
                textStyle: MaterialStateProperty.all(
                    const TextStyle(color: Colors.white)),
              ),
              onPressed: () async {
                print("trying to open");
                if (await FlutterOverlayWindow.isActive()) {
                  FlutterOverlayWindow.closeOverlay()
                      .then((value) => log('STOPPED: alue: $value'));
                  return;
                }
                print("opening");
                await FlutterOverlayWindow.showOverlay(
                  enableDrag: true,
                  overlayTitle: "X-SLAYER",
                  overlayContent: 'Overlay Enabled',
                  flag: OverlayFlag.defaultFlag,
                  visibility: NotificationVisibility.visibilityPrivate,
                  positionGravity: PositionGravity.none,
                  height: 100,
                  width: 100,
                );
              },
              child: const Text('Overlay Translator'),
            ),
            // TextButton(
            //   onPressed: () async {
            //     await FlutterOverlayWindow.requestPermission();
            //   },
            //   child: const Text('Request Overlay Permission'),
            // ),
          ],
        ),
      ),
    );
  }
}
