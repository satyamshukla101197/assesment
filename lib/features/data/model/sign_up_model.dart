import 'package:json_annotation/json_annotation.dart';

part 'sign_up_model.g.dart';

@JsonSerializable()
class SignUpModel {
  final DetailsSuccessResult? Result;
  SignUpModel({this.Result});

  factory SignUpModel.fromJson(Map<String, dynamic> json) =>
      _$SignUpModelFromJson(json);

  Map<String, dynamic> toJson() => _$SignUpModelToJson(this);
}

@JsonSerializable()
class DetailsSuccessResult {
  final String? name;
  final String? email;
  final String? password;
  final String? number;
  final String? image;
  DetailsSuccessResult({
    this.name,
    this.email,
    this.password,
    this.number,
    this.image,
  });

  factory DetailsSuccessResult.fromJson(Map<String, dynamic> json) =>
      _$DetailsSuccessResultFromJson(json);
  Map<String, dynamic> toJson() => _$DetailsSuccessResultToJson(this);
}

