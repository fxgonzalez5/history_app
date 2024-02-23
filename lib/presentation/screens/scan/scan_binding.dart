part of 'scan_page.dart';

class ScanBinding implements Bindings {
@override
void dependencies() {
    Get.lazyPut<ScanController>(() => ScanController());
  }
}