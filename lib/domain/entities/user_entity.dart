import 'package:history_app/domain/entities/hito.dart';

class UserEntity {
  final String id;
  final String email;
  final String name;
  final String? photoUrl;
  final List<Hito> hitos;

  UserEntity({
    required this.id,
    required this.email,
    required this.name,
    required this.photoUrl,
    this.hitos = const []
  });
}