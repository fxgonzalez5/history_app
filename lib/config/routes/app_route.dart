import 'package:get/get.dart';
import 'package:history_app/infraestructure/datasources/firebase_datasource.dart';
import 'package:history_app/infraestructure/repositories/cloud_database_repository_impl.dart';
import 'package:history_app/presentation/screens/screens.dart';

const String initialPage = '/login';
final cloudDatabaseRepository = CloudDatabaseRepositoryImpl(FirebaseDatasource());

final appRouter = <GetPage<dynamic>> [
    GetPage(
      name: '/login',
      page: () => const LoginScreen(),
      bindings: [
        LoginBinding(),
        BindingsBuilder.put(() => GalleryController(cloudDatabaseRepository)),
      ]
    ),
    
    GetPage(
      name: '/navigation',
      page: () => const NavigationScreen(),
      binding: NavigationBinding()
    ),
    
    GetPage(
      name: '/home',
      page: () => const HomeScreen()
    ),
    
    GetPage(
      name: '/gallery',
      page: () => const GalleryScreen(),
      // binding: GalleryBinding()
    ),
    
    GetPage(
      name: '/scan',
      page: () => const ScanScreen(),
      // binding: ScanBinding()
    ),
    
    GetPage(
      name: '/information',
      page: () => const InformationScreen()
    ),
];