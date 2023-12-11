part of 'scan_screen.dart';

class ScanBinding implements Bindings {
@override
void dependencies() {
  Get.lazyPut<ScanController>(() => ScanController());
  }
}