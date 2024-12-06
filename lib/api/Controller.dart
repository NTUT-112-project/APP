class Response {
  final bool success;
  final dynamic data;
  final String message;
  Response(this.success, this.data, this.message);

  factory Response.fromJson(dynamic json) {
    return Response(
      json['success'] as bool,
      json['data'] as dynamic,
      json['message'] as String,
    );
  }

  Map toJson() {
    return {
      'success': success,
      'data': data,
      'message': message,
    };
  }

  @override
  String toString() {
    return '{$success, $data, $message}';
  }
}
