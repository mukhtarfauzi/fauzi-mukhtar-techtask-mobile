// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'generic_resp.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GenericResp _$GenericRespFromJson(Map<String, dynamic> json) {
  return GenericResp(
    error: json['error'] == null
        ? null
        : ErrorData.fromJson(json['error'] as Map<String, dynamic>),
  );
}
