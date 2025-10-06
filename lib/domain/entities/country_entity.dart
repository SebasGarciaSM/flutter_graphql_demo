class CountryEntity {
  final String code;
  final String name;
  final String emoji;
  final String? capital;
  final String? currency;

  CountryEntity({
    required this.code,
    required this.name,
    required this.emoji,
    this.capital,
    this.currency,
  });
}
