import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

import 'package:history_app/config/theme/responsive.dart';
import 'package:history_app/domain/entities/entities.dart';
import 'package:history_app/domain/repositories/cluod_database_repository.dart';
import 'package:history_app/infraestructure/repositories/cloud_database_repository_impl.dart';
import 'package:history_app/presentation/screens/screens.dart';
import 'package:history_app/presentation/widgets/widgets.dart';

part 'gallery_controller.dart';
part 'gallery_binding.dart';

class GalleryPage extends GetView<GalleryController> {
  const GalleryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive(context);
    final colors = Theme.of(context).colorScheme;
    final texts = Theme.of(context).textTheme;
    final navegationController = Get.find<NavigationController>();
    final userController = Get.find<UserController>();

    return Scaffold(
      body: Obx(
        () => Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            _Head(userController.user!.hitos.length, navegationController.totalHitos),
            Container(height: responsive.hp(1.3)),
            if (controller.isVisibility)
              if (userController.user!.hitos.isEmpty)
                const Expanded(child: Center(child: Text('Escanea los QR y revela la historia')),)
              else
                ...[
                  Padding(
                    padding:  EdgeInsets.symmetric(horizontal: responsive.wp(2)),
                    child: DropdownMenu<int>(
                      width: responsive.wp(37.5),
                      label: Text('Ordenar por', style: texts.labelLarge!.copyWith(color: colors.secondary)),
                      initialSelection: controller.selectedOption,
                      dropdownMenuEntries: const [
                        DropdownMenuEntry(
                          value: 0,
                          label: 'Título',
                        ),
                        DropdownMenuEntry(
                          value: 1,
                          label: 'Año',
                        ),
                      ],
                      onSelected: (value) {
                        controller.selectedOption = value;
                        userController.orderBy(value!);
                      }
                    ),
                  ),
                  _GalleryView(userController.user!.hitos)
                ]
            else
              const _AchievementView()
          ],
        ),
      ),
    );
  }
}

class _GalleryView extends StatelessWidget {
  final List<Hito> hitos; 

  const _GalleryView(this.hitos);

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive(context);
    final colors = Theme.of(context).colorScheme;

    return Expanded(
      child: Padding(
        padding: EdgeInsets.only(top: responsive.hp(1)),
        child: ListView.separated(
          padding: EdgeInsets.zero,
          itemCount: hitos.length,
          itemBuilder: (context, index) {
            final hito = hitos[index];
      
            return ListItem(
              label: SizedBox(
                width: responsive.wp(35),
                child: Center(
                  child: Image.network(
                    hito.imageUrl,
                    width: responsive.wp(20),
                    height: responsive.hp(12.5),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              title: hito.title,
              subTitle: Row(
                children: [
                  Text('Año: ', style: TextStyle(fontSize: responsive.ip(1.4), color: Colors.grey)),
                  Text('${hito.year}', style: TextStyle(fontSize: responsive.ip(1.4), fontWeight: FontWeight.w500)),
                ],
              ),
              linkText: 'Ver más',
              linkStyle: TextStyle(
                fontSize: responsive.ip(1.5),
                color: colors.secondary,
              ),
              onTap: () {
                Get.find<GalleryController>().hito = hito;
                Get.toNamed('/information');
              }
            );
          },
          separatorBuilder: (context, index) => const Divider(),
        ),
      ),
    );
  }
}

class _AchievementView extends StatelessWidget {
  const _AchievementView();

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive(context);
    final texts = Theme.of(context).textTheme;

    return FadeOut(
      delay: const Duration(seconds: 5),
      animate: true,
      child: Center(
        child: Column(
          children: [
            Text(
              '¡Felicidades!',
              style: texts.headlineLarge,
            ),
            SizedBox(
              height: responsive.hp(1),
            ),
            Text(
              'Encontraste',
              style: texts.titleLarge,
            ),
            SizedBox(
              height: responsive.hp(1),
            ),
            const _CustomCard()
          ],
        ),
      ),
    );
  }
}

class _CustomCard extends StatelessWidget {
  const _CustomCard();

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive(context);
    final colors = Theme.of(context).colorScheme;
    final texts = Theme.of(context).textTheme;
    final hito = Get.find<GalleryController>().hito;

    return Card(
      surfaceTintColor: Colors.white,
      elevation: 5,
      child: SizedBox(
        width: responsive.wp(80),
        child: Padding(
          padding: EdgeInsets.all(responsive.wp(5)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _CustomImage(hito!.imageUrl),
              SizedBox(height: responsive.ip(2)),
              Text(
                hito.title,
                style: texts.headlineSmall,
              ),
              Row(
                children: [
                  TextButton(
                    style: ButtonStyle(
                      padding: MaterialStatePropertyAll(EdgeInsets.symmetric(vertical: responsive.ip(1))),
                      minimumSize: const MaterialStatePropertyAll(Size.zero),
                      overlayColor: const MaterialStatePropertyAll(Colors.transparent),
                    ),
                    onPressed: () {
                      Get.find<GalleryController>().hito = hito;
                      Get.toNamed('/information');
                    },
                    child: Text(
                      'Ver más...',
                      style: TextStyle(fontSize: responsive.ip(1.35), color: colors.secondary),
                    ),
                  ),
                  const Spacer(),
                  Text('Ganaste 10 pts.', style: TextStyle(fontSize: responsive.ip(1.35), color: Colors.black54)),
                  Icon(Icons.star_rounded, color: colors.secondary),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _CustomImage extends StatelessWidget {
  final String image;

  const _CustomImage(this.image);

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive(context);

    return Center(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(responsive.ip(1)),
        child: Image.network(
          image,
          width: responsive.wp(48),
          height: responsive.hp(28),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class _Head extends StatelessWidget {
  final int found;
  final int total;

  const _Head(this.found, this.total);

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive(context);
    final colors = Theme.of(context).colorScheme;

    return Padding(
      padding: EdgeInsets.only(bottom: responsive.hp(2)),
      child: CustomFigure(
        color: colors.primary,
        scale: 2,
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.only(left: responsive.ip(2)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const _UserInformation(),
                SizedBox(
                  height: responsive.ip(2),
                ),
                CustomProgress(
                  textColor: colors.secondary,
                  backgroundColor: Colors.white,
                  foregroundColor: colors.secondary,
                  valueProgress: found / total,
                ),
                Text('$found de $total', style: TextStyle(fontSize: responsive.ip(1.3), fontWeight: FontWeight.w500, color: Colors.white70)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _UserInformation extends StatelessWidget {
  const _UserInformation();

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive(context);
    final colors = Theme.of(context).colorScheme;
    final userController = Get.find<UserController>();

    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(responsive.ip(0.75)),
          width: responsive.wp(18),
          height: responsive.wp(18),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: colors.secondary, width: 2),
            image: DecorationImage(
              image: NetworkImage(userController.user!.photoUrl ?? 'https://t4.ftcdn.net/jpg/03/49/49/79/360_F_349497933_Ly4im8BDmHLaLzgyKg2f2yZOvJjBtlw5.webp'),
            ),
          ),
        ),
        SizedBox(
          width: responsive.ip(1),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              userController.user!.name,
              style: TextStyle(
                  fontSize: responsive.ip(1.6),
                  fontWeight: FontWeight.w500,
                  color: Colors.white),
            ),
            Text(
              'Estudiante',
              style: TextStyle(
                  fontSize: responsive.ip(1.3),
                  fontWeight: FontWeight.w500,
                  color: Colors.white70),
            ),
          ],
        )
      ],
    );
  }
}
