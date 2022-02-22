import 'package:json_annotation/json_annotation.dart';

part 'data_model.g.dart';

@JsonSerializable()
class DataModel {
  final List<DataModelResult>? Result;
  DataModel({this.Result});

  factory DataModel.fromJson(Map<String, dynamic> json) =>
      _$DataModelFromJson(json);

  Map<String, dynamic> toJson() => _$DataModelToJson(this);
}

@JsonSerializable()
class DataModelResult {
  final String? id;
  final String? author;
  final int? width;
  final int? height;
  final String? url;
  final String? download_url;
  DataModelResult({
    this.id,
    this.author,
    this.width,
    this.height,
    this.url,
    this.download_url,
  });

  factory DataModelResult.fromJson(Map<String, dynamic> json) =>
      _$DataModelResultFromJson(json);
  Map<String, dynamic> toJson() => _$DataModelResultToJson(this);
}

