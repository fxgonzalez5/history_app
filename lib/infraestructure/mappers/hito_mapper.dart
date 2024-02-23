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

  static HitoModel entityToModel(Hito hito) => HitoModel(
    id: hito.id,
    image: hito.imageUrl,
    video: hito.videoUrl,
    title: hito.title,
    date: hito.year,
    description: hito.description,
    category: hito.category
  );
}