import 'package:history_app/domain/entities/user_entity.dart';
import 'package:history_app/infraestructure/mappers/hito_mapper.dart';
import 'package:history_app/infraestructure/models/user_model.dart';

class UserMapper {
  static UserModel entityToModel(UserEntity user) {
    return UserModel(
      id: user.id,
      email: user.email,
      name: user.name,
      photo: user.photoUrl,
      hitos: user.hitos.map((e) => HitoMapper.entityToModel(e)).toList(),
    );
  }

  static UserEntity userToEntity(UserModel user) {
    return UserEntity(
      id: user.id,
      email: user.email,
      name: user.name,
      photoUrl: user.photo,
      hitos: user.hitos.map((e) => HitoMapper.hitoToEntity(e)).toList(),
    );
  }
}
