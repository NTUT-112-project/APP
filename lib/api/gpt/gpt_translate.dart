
class GptTranslate{

  String srcLanguage;
  String distLanguage;
  String srcText;

  String? distText;

  GptTranslate(this.srcLanguage,this.distLanguage,this.srcText);

  factory GptTranslate.fromJson(dynamic json){
    return GptTranslate(
      json['srcLanguage'] as String,
      json['distLanguage'] as String,
      json['srcText'] as String,
    );
  }
  Map toJson(){
    return {
      'srcLanguage' : srcLanguage,
      'distLanguage' : distLanguage,
      'srcText' : srcText,
    };
  }
  @override
  String toString() {
    return '{ $srcLanguage, $distLanguage,$srcText }';
  }
}