part of 'check_auth_page.dart';

class UserController extends GetxController {
  final cloudDatabaseRepository = Get.find<CloudDatabaseRepositoryImpl>();
  UserEntity? user;

  Future<void> loadUser(String id) async {
    user = await cloudDatabaseRepository.getUser(id);
  }

  void addHito(Hito hito) {
    user!.hitos.add(hito);

    final galleryController = Get.find<GalleryController>();
    if (galleryController.selectedOption != null) {
      orderBy(galleryController.selectedOption!);
    }
    
    update();
    cloudDatabaseRepository.saveHito(user!, hito);
  }

  void orderBy(int value) {
    switch (value) {
      case 0:
        user!.hitos.sort((a, b) => a.title.compareTo(b.title));
        break;
      case 1:
        user!.hitos.sort((a, b) => a.year.compareTo(b.year));
        break;
      default:
    }
    update();
  }
}