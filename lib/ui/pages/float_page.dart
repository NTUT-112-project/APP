import 'package:android_window/android_window.dart';
import 'package:flutter/material.dart';
import 'package:language_picker/language_picker_dropdown_controller.dart';
import 'package:language_picker/languages.dart';
import 'package:language_picker/language_picker.dart';


class AndroidWindowApp extends StatelessWidget {
  const AndroidWindowApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: const WindowHomePage(),
      theme: ThemeData.dark(useMaterial3: true),
      debugShowCheckedModeBanner: false,
    );
  }
}

class WindowHomePage extends StatefulWidget{
  const WindowHomePage({super.key});
  @override
  State<StatefulWidget> createState() => _WindowHomePage();
}

class _WindowHomePage extends State<WindowHomePage> {
  final List<Language> languages = [
    Language('dl', '(detect language)'),
    ...Languages.defaultLanguages
  ];
  final srcLanguageController = LanguagePickerDropdownController(Language('dl', '(detect language)'));
  final distLanguageController = LanguagePickerDropdownController(Languages.english);
  bool isExpended=false;
  final maxWidth=WidgetsBinding.instance.window.physicalSize.width.round();

  Widget _buildDropdownItem(Language language) {
    return Row(
      children: <Widget>[
        const SizedBox(
          width: 8.0,
        ),
        Text("${language.name}",style: const TextStyle(fontSize: 15),),
      ],
    );
  }
  @override
  Widget build(BuildContext context) {
    AndroidWindow.setHandler((name, data) async {
      switch (name) {
        case 'hello':
          showSnackBar(context, 'message from main app: $data');
          return 'hello main app';
      }
      return null;
    });

    return AndroidWindow(
      child: ClipRRect(
        clipBehavior: Clip.hardEdge,
        borderRadius: const BorderRadius.all(Radius.circular(8)),
        child: Scaffold(
          backgroundColor:
          Theme.of(context).scaffoldBackgroundColor.withOpacity(0.8),
          body: SingleChildScrollView(
            child:Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Padding(
                  padding: EdgeInsets.all(16.0),
                  child:Column(
                    children:[
                      GestureDetector(
                        onTap:(){
                          setState(() {
                            if(isExpended){
                              AndroidWindow.resize(maxWidth, 400);
                              AndroidWindow.setPosition(100000, 100000);
                            }
                            else{
                              AndroidWindow.resize(maxWidth, 900);
                              AndroidWindow.setPosition(100000, 100000);
                            }
                            isExpended=!isExpended;
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          padding: EdgeInsets.all(3.0),
                          child: Icon(
                            (isExpended)?Icons.expand_more:Icons.expand_less,
                            size: 24.0,
                            color:Colors.white,
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: SizedBox(
                              width:100,
                              child: LanguagePickerDropdown(
                                initialValue: srcLanguageController.value,
                                controller: srcLanguageController,
                                languages: languages,
                                itemBuilder: _buildDropdownItem,
                                onValuePicked: (Language language){
                                  setState(() {
                                    srcLanguageController.value=language;
                                  });
                                },
                              ),
                            ),
                          ),


                          GestureDetector(
                            onTap:(){
                              if(srcLanguageController.value==languages[0]) return;
                              setState(() {
                                final Language temp=srcLanguageController.value;
                                srcLanguageController.value=distLanguageController.value;
                                distLanguageController.value=temp;
                              });
                          },
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.transparent,
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              padding: EdgeInsets.all(3.0),
                              child: Icon(
                                Icons.swap_horiz,
                                size: 24.0,
                                color:(srcLanguageController.value==languages[0])?Colors.white10:Colors.blue,
                              ),
                            ),
                          ),
                          Expanded(
                            child: SizedBox(
                              width:100,
                              child: LanguagePickerDropdown(
                                initialValue: distLanguageController.value,
                                controller: distLanguageController,
                                itemBuilder: _buildDropdownItem,
                                onValuePicked: (Language language){
                                  setState(() {
                                    distLanguageController.value=language;
                                  });
                                },
                              ),
                            ),
                          ),

                        ],
                      ),

                      TextField(
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'copy something here'
                        ),
                      ),
                      SizedBox(height: 3,),
                      TextField(
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                        ),
                      ),

                    ]
                  )

                ),
              ],
            ),
          )
        ),
      ),
    );
  }

  showSnackBar(BuildContext context, String title) {
    final snackBar =
    SnackBar(content: Text(title), padding: const EdgeInsets.all(8));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}