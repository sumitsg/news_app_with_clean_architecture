import 'package:equatable/equatable.dart';

class Source extends Equatable {
  final String? id;
  final String? name;

  const Source({this.id, this.name});

  @override
  // TODO: implement props
  List<Object?> get props => [id, name];

  @override
  // TODO: implement stringify
  bool? get stringify => true;
}
