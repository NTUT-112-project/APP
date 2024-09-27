
class Translate{

  String srcLanguage;
  String distLanguage;
  String srcText;
  String apiKey;
  String apiToken;

  String? distText;

  Translate(this.srcLanguage,this.distLanguage,this.srcText,this.apiKey,this.apiToken);

  factory Translate.fromJson(dynamic json){
    return Translate(
      json['srcLanguage'] as String,
      json['distLanguage'] as String,
      json['srcText'] as String,
      json['apiKey'] as String,
      json['api_token'] as String,
    );
  } 
  Map toJson(){
    return {
      'srcLanguage' : srcLanguage,
      'distLanguage' : distLanguage,
      'srcText' : srcText,
      'apiKey' : apiKey,
      'api_token' : apiToken
    };
  }
  @override
  String toString() {
    return '{ $srcLanguage, $distLanguage,$srcText, $apiKey, $apiToken}';
  }
}