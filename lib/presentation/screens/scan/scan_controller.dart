part of 'scan_screen.dart';

class ScanController extends GetxController {
  final CloudDatabaseRepository cloudDatabaseRepository;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  ScanController(this.cloudDatabaseRepository);

  void onQRViewCreated(QRViewController controller) {
    controller.scannedDataStream.listen((scanData) async {
      try {
        final navigationController = Get.find<NavigationController>();
        final galleryController = Get.find<GalleryController>();

        if (scanData.code != null && galleryController.isVisibility) {
          galleryController.isVisibility = false;
          galleryController.newHito = await cloudDatabaseRepository.getHito(scanData.code!);
          navigationController.selectMenuItem = 1;
          navigationController.animate.value = false;
          await Future.delayed(const Duration(milliseconds: 2000));
          Get.back();
        }
      } catch (e) {
        print(e);
      }
    });
  }
}