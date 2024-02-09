import 'package:history_app/domain/entities/hito.dart';
import 'package:history_app/infraestructure/models/hito_model.dart';

class HitoMapper {
  static Hito hitoToEntity(HitoModel hitodb) => Hito(
    id: hitodb.id,
    imageUrl: hitodb.image,
    videoUrl: hitodb.video ?? 'no-video',
    title: hitodb.title,
    year: hitodb.date,
    description: hitodb.description,
    category: hitodb.category ?? ''
  );
}