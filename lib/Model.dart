class RanDom {
  final dynamic id;
  final dynamic createdAt;
  final dynamic updatedAt;
  final dynamic value;

  RanDom({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.value,
  });

  factory RanDom.fromJson({required Map json}) {
    return RanDom(
      id: json['id'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      value: json['value'],
    );
  }
}
