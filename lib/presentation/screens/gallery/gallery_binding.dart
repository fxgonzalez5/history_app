part of 'gallery_page.dart';

class GalleryBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GalleryController>(() => GalleryController());
  }
}