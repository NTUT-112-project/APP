import 'dart:developer';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_overlay_window/flutter_overlay_window.dart';
import 'package:language_picker/language_picker_dropdown_controller.dart';
import 'package:language_picker/languages.dart';
import 'package:language_picker/language_picker.dart';

import 'package:clipboard/clipboard.dart';

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}

class WindowHomePage extends StatefulWidget {
  const WindowHomePage({super.key});
  @override
  State<StatefulWidget> createState() => _WindowHomePage();
}

class _WindowHomePage extends State<WindowHomePage> {
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

  bool isExpended = false;

  @override
  void dispose() {
    srcTextController.dispose();
    super.dispose();
  }
  @override
  void initState() {
    isExpended = false;
    super.initState();
  }

  Widget translateMenu(){
    return SingleChildScrollView(
      child: Column(
        children: [
          Align(
              alignment: Alignment.centerLeft,
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () async {
                      setState(() {
                        isExpended = false;
                      });
                      await FlutterOverlayWindow.resizeOverlay(
                          40, 40);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius:
                        BorderRadius.circular(8.0),
                      ),
                      padding: EdgeInsets.all(3.0),
                      child: Icon(
                        Icons.chevron_left_outlined,
                        size: 24.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Expanded(
                      child: TextButton(
                          onPressed: () {},
                          child: Row(
                            mainAxisAlignment:
                            MainAxisAlignment.center,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  borderRadius:
                                  BorderRadius.circular(8.0),
                                ),
                                child: const Icon(
                                  Icons.translate,
                                  size: 20.0,
                                  color: Colors.white,
                                ),
                              ),
                              const Text(
                                "Translate",
                                style:
                                TextStyle(color: Colors.white),
                              ),
                            ],
                          )),
                  ),

                ],
              )),
          Padding(
            padding: const EdgeInsets.fromLTRB(7, 0, 7, 0),
            child: Column(
              children: [
                Row(

                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Focus(
                        onFocusChange: (hasFocus) async {
                        },
                        child:LanguagePickerDropdown(
                          initialValue: srcLanguageController.value,
                          controller: srcLanguageController,
                          languages: languages,
                          itemBuilder: _buildDropdownItem,
                          onValuePicked: (Language language) {
                            // await FlutterOverlayWindow.showOverlay(enableDrag: true);
                            setState(() {
                              srcLanguageController.value = language;
                            });
                          },
                        )
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        if (srcLanguageController.value == languages[0])
                          return;
                        setState(() {
                          final Language temp =
                              srcLanguageController.value;
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
                          color: (srcLanguageController.value ==
                              languages[0])
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
                          setState(() {
                            distLanguageController.value = language;
                          });
                        },
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        style: TextStyle(color: Colors.white),
                        onTapOutside: (event) async {
                          log("text unfocus");
                          await FlutterOverlayWindow.updateFlag(
                              OverlayFlag.defaultFlag);
                        },
                        onTap: () async {
                          log("text focus");
                          await FlutterOverlayWindow.updateFlag(
                              OverlayFlag.focusPointer);
                        },
                        controller: srcTextController,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'copy something',
                            hintStyle:
                            TextStyle(color: Colors.white30)
                        ),
                      ),
                    ),
                    SizedBox(width: 8,),
                    Expanded(
                      child: TextField(
                        readOnly: true,
                        controller: distTextController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white,width: 10)
                          ),
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
  Widget expendButton(){
    return Center(
      child: GestureDetector(
        onTap: () async {
          setState(() {
            isExpended = true;
          });
          await FlutterOverlayWindow.resizeOverlay(350, 200);
        },
        child: Container(
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(8.0),
          ),
          padding: const EdgeInsets.all(5.0),
          child: const Icon(
            Icons.open_in_new,
            size: 24.0,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {

    return Focus(
      onFocusChange: (hasFocus) async {
        if (hasFocus) {
          await FlutterOverlayWindow.updateFlag(OverlayFlag.focusPointer);
        } else {
          await FlutterOverlayWindow.updateFlag(OverlayFlag.defaultFlag);
        }
      },
      child: ClipRRect(
          clipBehavior: Clip.hardEdge,
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          child: GestureDetector(
            child: Scaffold(
              resizeToAvoidBottomInset: false,
              backgroundColor: Colors.black.withOpacity(0.5),
              body: (isExpended)
                  ? translateMenu()
                  : expendButton()
            ),
          )),
    );
  }
  Widget _buildDropdownItem(Language language) {
    return Row(
      children: <Widget>[
        SizedBox(
          width: 1.0,
        ),
        Text("${language.name}",style: TextStyle(fontSize: 12,color: Colors.white),),
      ],
    );
  }
  showSnackBar(BuildContext context, String title) {
    final snackBar =
        SnackBar(content: Text(title), padding: const EdgeInsets.all(8));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
