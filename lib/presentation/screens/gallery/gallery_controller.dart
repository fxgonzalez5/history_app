part of 'gallery_screen.dart';

class GalleryController extends GetxController {
  final CloudDatabaseRepository cloudDatabaseRepository;
  late AnimationController animateController;
  late final int totalHitos;
  final List<Hito> hitos = [];
  final RxBool _isVisibility = true.obs;
  final Rxn<Hito> _newHito = Rxn<Hito>();

  GalleryController(this.cloudDatabaseRepository);

  @override
  void onInit() async {
    super.onInit();
    totalHitos = await cloudDatabaseRepository.getNumberOfHitos();
  }

  Hito? get newHito => _newHito.value;
  set newHito(Hito? value) {
    _newHito.value = value;
    if (value != null) {
      hitos.add(value);
    }
  }

  bool get isVisibility => _isVisibility.value;
  set isVisibility(bool value) {
    _isVisibility.value = value;
    animationDelay();
  }

  Future<void> animationDelay() async {
    await Future.delayed(const Duration(milliseconds: 5300));
    _newHito.value = null;
    _isVisibility.value = true;
  }
}