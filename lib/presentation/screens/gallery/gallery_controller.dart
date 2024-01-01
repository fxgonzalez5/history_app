part of 'gallery_screen.dart';

class GalleryController extends GetxController {
  late AnimationController animateController;
  final RxBool _isVisibility = true.obs;
  late final int totalHitos;
  final Rxn<HitosModel> _newHito = Rxn<HitosModel>();
  final List<HitosModel> hitos = [];

  @override
  void onInit() async {
    super.onInit();
    totalHitos = await FirestoreService().getNumberOfHitos();
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

  HitosModel? get newHito => _newHito.value;
  set newHito(HitosModel? value) {
    _newHito.value = value;
    if (value != null) {
      hitos.add(value);
    }
  } 
}