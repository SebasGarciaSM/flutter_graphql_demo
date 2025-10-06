import 'package:flutter_graphql_demo/domain/entities/country_entity.dart';

class CountryModel extends CountryEntity {
  CountryModel({
    required super.code,
    required super.name,
    required super.emoji,
    super.capital,
    super.currency,
  });

  factory CountryModel.fromJson(Map<String, dynamic> json) {
    return CountryModel(
      code: json['code'],
      name: json['name'],
      emoji: json['emoji'],
      capital: json['capital'],
      currency: json['currency'],
    );
  }
}
