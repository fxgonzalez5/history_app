part of 'scan_page.dart';

class ScanController extends GetxController {
  final CloudDatabaseRepository cloudDatabaseRepository = Get.find<CloudDatabaseRepositoryImpl>();
  final navigationController = Get.find<NavigationController>();
  final galleryController = Get.find<GalleryController>();
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');


  void onQRViewCreated(QRViewController controller) {
    controller.scannedDataStream.listen((scanData) async {
      try {

        if (scanData.code != null && galleryController.isVisibility) {
          galleryController.isVisibility = false;
          galleryController.hito = await cloudDatabaseRepository.getHito(scanData.code!);
          Get.find<UserController>().addHito(galleryController.hito!);
          navigationController.selectMenuItem = 1;
          navigationController.animate.value = false;
          await Future.delayed(const Duration(milliseconds: 2000));
          Get.back();
        }
      } catch (e) {
        Get.defaultDialog(
          barrierDismissible: false,
          title: 'Error',
          middleText: e.toString().substring(10),
          textConfirm: 'Ok',
          onConfirm: () => Get.back(),
        );
      }
    });
  }
}