import 'package:json_annotation/json_annotation.dart';
import 'package:tech_task/core/models/error_data.dart';

part 'generic_resp.g.dart';

@JsonSerializable(createToJson: false)
class GenericResp {
  ErrorData error;

  @override
  String toString() {
      return 'GenericResp{error: ${error.toString()}';
  }

  GenericResp({this.error});

  factory GenericResp.fromJson(Map<String, dynamic> json) =>
      _$GenericRespFromJson(json);
}
