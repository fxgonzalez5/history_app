part of 'gallery_screen.dart';

class GalleryController extends GetxController {
  late AnimationController animateController;
  final RxBool _isVisibility = true.obs;

  bool get isVisibility => _isVisibility.value;
  set isVisibility(bool value) {
    _isVisibility.value = value;
    animationDelay();
  } 
  
  Future<void> animationDelay() async {
    await Future.delayed(const Duration(milliseconds: 5300));
    _isVisibility.value = true;
  }
}