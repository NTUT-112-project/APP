import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_overlay_window/flutter_overlay_window.dart';
import 'package:flutter/services.dart';
import 'package:language_picker/language_picker_dropdown_controller.dart';
import 'package:language_picker/languages.dart';
import 'package:language_picker/language_picker.dart';

import '../../../api/gpt/gpt_translate.dart';
import '../../../api/gpt/gpt_translate_api.dart';

class ToolPage extends StatefulWidget {
  const ToolPage({super.key});

  @override
  State<StatefulWidget> createState() => _ToolPage();
}

class _ToolPage extends State<ToolPage> {
  final gptTranslationApi = GptTranslateApi();
  final List<Language> languages = [
    Language('dl', '(detect language)'),
    ...Languages.defaultLanguages
  ];

  final srcLanguageController =
      LanguagePickerDropdownController(Language('dl', '(detect language)'));
  final distLanguageController =
      LanguagePickerDropdownController(Languages.english);

  final srcTextController = TextEditingController();
  final distTextController = TextEditingController();

  bool isWindowRunning = false;

  @override
  void dispose() {
    srcLanguageController.dispose();
    distLanguageController.dispose();
    srcTextController.dispose();
    distTextController.dispose();
    super.dispose();
  }

  Future<void> requestTranslate() async {
    gptTranslationApi.gptTranslate = GptTranslate(
        (srcLanguageController.value.name == '(detect language)')
            ? 'none'
            : srcLanguageController.value.name,
        distLanguageController.value.name,
        srcTextController.text);
    distTextController.text = "Loading";

    int dotCount = 1;
    Timer loadingTimer = Timer.periodic(Duration(seconds: 1), (Timer timer) {
      if (dotCount <= 3) {
        distTextController.text = "Loading${'.' * dotCount}";
        dotCount++;
      } else {
        dotCount = 1;
      }
    });
    final response = await gptTranslationApi.translate();
    loadingTimer.cancel();
    distTextController.text = response.data.toString();
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
                        onChanged: (text) {},
                        onTap: () async {
                          log("text focus");
                          final data =
                              await Clipboard.getData(Clipboard.kTextPlain);
                          log('get clipboard data done');
                          if (data != null &&
                              data.text != srcTextController.text) {
                            final text = data.text ?? '';
                            srcTextController.text = text;
                            log('got data from clipboard $text');
                            requestTranslate();
                          } else {
                            log("got null");
                          }
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
      appBar: AppBar(title: const Text('GPT translator'), centerTitle: true),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 20,
            ),
            translateMenu(),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith(getColor)),
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
              child: const Text('Activate Translator'),
            ),
          ],
        ),
      ),
    );
  }
}
