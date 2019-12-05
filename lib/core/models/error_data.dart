import 'package:json_annotation/json_annotation.dart';

part 'error_data.g.dart';

@JsonSerializable(createToJson: false)
class ErrorData {
  String name;
  String header;
  String message;

  @override
  String toString() {
    return 'ErrorData{name: $name, header: $header, message: $message}';
  }

  ErrorData({this.name, this.header, this.message});

  factory ErrorData.fromJson(Map<String, dynamic> json) =>
      _$ErrorDataFromJson(json);
}
