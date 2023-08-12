import 'package:flutter/material.dart';
import 'package:android_window/main.dart' as android_window;
import 'package:flutter/services.dart';
import 'package:language_picker/languages.dart';
import 'package:language_picker/language_picker.dart';




class ToolPage extends StatefulWidget {
  const ToolPage({super.key});

  @override
  State<StatefulWidget> createState() => _ToolPage();
}

class _ToolPage extends State<ToolPage> {
  final srcTextController=TextEditingController();
  final List<Language> languages = [
    Language('dl', '(detect language)'),
    ...Languages.defaultLanguages
  ];
  bool isWindowRunning = false;
  double screenWidth=0;
  Size screenSize = WidgetsBinding.instance.window.physicalSize;
  @override
  void didChangeDependencies() {
    screenWidth=MediaQuery.of(context).size.height;
    super.didChangeDependencies();
  }

  Widget _buildDropdownItem(Language language) {
    return Row(
      children: <Widget>[
        SizedBox(
          width: 8.0,
        ),
        Text("${language.name}",style: TextStyle(fontSize: 15),),
      ],
    );
  }
  @override
  Widget build(BuildContext context) {
    android_window.setHandler((name, data) async {
      switch (name) {
        case 'getClipboardText':
          final clipboardData = await Clipboard.getData(Clipboard.kTextPlain);
          if(clipboardData!=null){
            return clipboardData.text??'';
          }
          else{
            return '';
          }

      }
      return null;
    });
    Color getColor(Set<MaterialState> states) {
      if (isWindowRunning) {
        return Colors.red;
      }
      return Colors.blue;
    }

    return Scaffold(
      appBar: AppBar(title: const Text('GPT translator'), centerTitle: true),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.max,
              children: [
                const SizedBox(width: 50,),
                const Expanded(
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Translate from', style: TextStyle(fontSize: 18)),
                  ),
                ),
                Expanded(
                  child: Container(
                      width: 200,
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.8),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      child: Align(
                        alignment: Alignment.center,
                        child: LanguagePickerDropdown(
                          languages: languages,
                            itemBuilder: _buildDropdownItem,
                            onValuePicked: (Language language) {
                              print(language.name);
                            }),
                      )
                  ),
                ),
                const SizedBox(width: 10,),
              ],
            ),
            SizedBox(width:MediaQuery.of(context).size.width-20,child: const Divider(
              height: 10,
              thickness: 1,
              color: Colors.white24,
            ),),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.max,
              children: [
                const SizedBox(width: 50,),
                const Expanded(
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Into language', style: TextStyle(fontSize: 18)),
                  ),
                ),
                Expanded(
                  child: Container(
                    width: 200,
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.8),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    child: Align(
                      alignment: Alignment.center,
                      child: LanguagePickerDropdown(
                          itemBuilder: _buildDropdownItem,
                          onValuePicked: (Language language) {
                            print(language.name);
                          }),
                    )
                  ),
                ),
                const SizedBox(width: 10,),
              ],
            ),
            ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith(getColor)),
              onPressed: () async {
                isWindowRunning = await android_window.isRunning();
                print("screenWidth is $screenWidth");
                android_window.open(
                  size: Size(screenSize.width, 400),
                  position: const Offset(10000, 10000),
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
