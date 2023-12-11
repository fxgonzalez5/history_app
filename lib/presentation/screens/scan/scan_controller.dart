part of 'scan_screen.dart';

class ScanController extends GetxController {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  late final QRViewController controller;
  late final Barcode _resultData;

  void onQRViewCreated(QRViewController ctr) {
    controller = ctr;
    controller.scannedDataStream.listen((scanData) async {
      final navigationController = Get.find<NavigationController>();
      final galleryController = Get.find<GalleryController>();

      // _resultData = scanData;
      galleryController.isVisibility = false;
      navigationController.selectMenuItem = 1;
      navigationController.animate.value = false;
      await Future.delayed(const Duration(milliseconds: 2000));
      Get.back();
    });
  }
}