import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:history_app/config/theme/responsive.dart';
import 'package:history_app/presentation/widgets/widgets.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class ScanScreen extends StatelessWidget {
  const ScanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive(context);

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const _CustomQrScanner(),
            SizedBox(height: responsive.hp(5),),
            SizedBox(
              width: responsive.wp(50),
              child: Text(
                'Escanea el código QR de tu hallazgo',
                style: TextStyle(
                  fontSize: responsive.ip(1.6),
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
     ),
   );
  }
}

class _CustomQrScanner extends StatelessWidget {
  const _CustomQrScanner();

  @override
  Widget build(BuildContext context) {
    final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
    QRViewController? controller;
    Barcode? result;
    final responsive = Responsive(context);
    final colors = Theme.of(context).colorScheme;

    void _onQRViewCreated(QRViewController ctr) {
      controller = ctr;
      controller!.scannedDataStream.listen((scanData) {
        result = scanData;
        print(result!.format);
      });
    }

    return SizedBox(
      width: responsive.wp(75),
      height: responsive.wp(75),
      child: Stack(
        children: [
          QRView(
            key: qrKey,
            onQRViewCreated: _onQRViewCreated,
            overlay: QrScannerOverlayShape(
              overlayColor: Colors.white,
              borderColor: colors.secondary,
              borderWidth: responsive.ip(1.25),
              borderLength: responsive.ip(5),
              cutOutSize: double.infinity,
            ),
          ),
          
          ShakeY(
            infinite: true,
            duration: const Duration(seconds: 3),
            from: responsive.ip(13),
            child: RoundedLine(
              width: responsive.wp(65),
              height: responsive.ip(0.5),
              color: colors.primary.withOpacity(0.75),
            )
          )
        ],
      ),
    );
  }
}