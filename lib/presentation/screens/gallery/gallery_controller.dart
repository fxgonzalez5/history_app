part of 'gallery_page.dart';

class GalleryController extends GetxController {
  final CloudDatabaseRepository cloudDatabaseRepository = Get.find<CloudDatabaseRepositoryImpl>();
  late AnimationController animateController;
  final UserController userController = Get.find<UserController>();
  final Rxn<VideoPlayerController> videoController = Rxn<VideoPlayerController>();
  final RxBool _isVisibility = true.obs;
  final Rxn<Hito> _hito = Rxn<Hito>();
  final Rxn<int> _selectedOption = Rxn<int>();
  final Rxn<int> _currentPage = Rxn<int>();

  bool get isVisibility => _isVisibility.value;
  set isVisibility(bool value) {
    _isVisibility.value = value;
    animationDelay();
  }

  Hito? get hito => _hito.value;
  set hito(Hito? value) => _hito.value = value;

  int? get selectedOption => _selectedOption.value;
  set selectedOption(int? value) => _selectedOption.value = value;

  int? get currentPage => _currentPage.value;
  set currentPage(int? value) => _currentPage.value = value;

  Future<void> animationDelay() async {
    await Future.delayed(const Duration(milliseconds: 5300));
    _hito.value = null;
    _isVisibility.value = true;
  }
}