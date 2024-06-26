
class GptTranslate{

  String srcLanguage;
  String distLanguage;
  String srcText;
  String gptApiKey;

  String? distText;

  GptTranslate(this.srcLanguage,this.distLanguage,this.srcText,this.gptApiKey);

  factory GptTranslate.fromJson(dynamic json){
    return GptTranslate(
      json['srcLanguage'] as String,
      json['distLanguage'] as String,
      json['srcText'] as String,
      json['gptApiKey'] as String
    );
  }
  Map toJson(){
    return {
      'srcLanguage' : srcLanguage,
      'distLanguage' : distLanguage,
      'srcText' : srcText,
      'gptApiKey' : gptApiKey,
    };
  }
  @override
  String toString() {
    return '{ $srcLanguage, $distLanguage,$srcText, $gptApiKey}';
  }
}