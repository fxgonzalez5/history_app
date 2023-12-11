part of 'gallery_screen.dart';

class GalleryBinding implements Bindings {
@override
void dependencies() {
  Get.lazyPut<GalleryController>(() => GalleryController());
  }
}