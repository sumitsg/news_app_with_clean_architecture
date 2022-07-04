import 'package:news_app_with_clean_architecture/src/domain/entities/source.dart';

class SourceModel extends Source {
  const SourceModel({
    String? id,
    String? name,
  }) : super(id: id, name: name);

  factory SourceModel.fromJson(Map<String, dynamic> json) {
    return SourceModel(
      id: json['id'],
      name: json['name'],
    );
  }
}
