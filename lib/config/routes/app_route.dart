import 'package:get/get.dart';
import 'package:history_app/presentation/screens/screens.dart';

const String initialPage = '/';

final appRouter = <GetPage<dynamic>> [
    GetPage(
      name: '/',
      page: () => const CheckAuthScreen(),
    ),

    GetPage(
      name: '/login',
      page: () => const LoginPage(),
      binding: LoginBinding()
    ),
    
    GetPage(
      name: '/navigation',
      page: () => const NavigationPage(),
      binding: NavigationBinding()
    ),
    
    GetPage(
      name: '/home',
      page: () => const HomePage()
    ),
    
    GetPage(
      name: '/gallery',
      page: () => const GalleryPage(),
      binding: GalleryBinding()
    ),
    
    GetPage(
      name: '/scan',
      page: () => const ScanPage(),
      binding: ScanBinding()
    ),
    
    GetPage(
      name: '/information',
      page: () => const HitoPage()
    ),
    
    GetPage(
      name: '/video',
      page: () => const FullVideoPage()
    ),
];