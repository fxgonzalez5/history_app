import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'package:history_app/config/theme/responsive.dart';
import 'package:history_app/domain/entities/hito.dart';
import 'package:history_app/presentation/screens/gallery/gallery_page.dart';
import 'package:history_app/presentation/widgets/widgets.dart';


class HitoPage extends StatelessWidget {
  const HitoPage({super.key});

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive(context);
    final hito = Get.find<GalleryController>().hito!;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _CustomSliverAppBar(
            image: hito.imageUrl,
            video: hito.videoUrl
          ),

          SliverToBoxAdapter(
            child: Container(
              height: responsive.hp(60),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(responsive.ip(3)),
                  topRight: Radius.circular(responsive.ip(3))
                ),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black45,
                    blurRadius: 2,
                  )
                ]
              ),
              child: _BoxContent(hito),
            ),  
          ),
        ],
      )
    );
  }
}

class _BoxContent extends StatelessWidget {
  final Hito hito;

  const _BoxContent(this.hito);

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive(context);
    final texts = Theme.of(context).textTheme;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: responsive.ip(1), horizontal: responsive.ip(3)),
      child:  Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RoundedLine(
            width: responsive.wp(20),
            height: responsive.ip(0.25),
            color: Colors.grey[300]
          ),
          _Heading(hito),
          const Divider(
            height: 10,
            thickness: 2,
            color: Colors.black12,
          ),
          SizedBox(height: responsive.ip(1.5),),
          Text('Descripción', style: texts.titleSmall,),
          SizedBox(height: responsive.ip(1.5),),
          Text(hito.description, style: texts.bodyLarge, textAlign: TextAlign.justify),
        ],
      ),
    );
  }
}

class _Heading extends StatelessWidget {
  final Hito hito;

  const _Heading(this.hito);

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive(context);
    final texts = Theme.of(context).textTheme;

    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: responsive.ip(2)),
        child: SizedBox(
          width: responsive.wp(75),
          child: Column(
            children: [
              Text(hito.title, style: TextStyle(fontSize: responsive.ip(2), height: 1.25), textAlign: TextAlign.center,),
              Text('Año: ${hito.year}', style: texts.titleSmall,),
            ],
          ),
        ),
      ),
    );
  }
}

class _CustomSliverAppBar extends StatelessWidget {
  final String image;
  final String video;

  const _CustomSliverAppBar({
    required this.image,
    required this.video
  });

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive(context);
    final colors = Theme.of(context).colorScheme;
    final galleryController = Get.find<GalleryController>();

    return Obx(
      () => SliverAppBar(
        actions: [
          if (galleryController.currentPage != null && galleryController.currentPage == 1)
            FadeIn(
              child: IconButton(
                icon: const Icon(Icons.screen_rotation_alt_outlined),
                onPressed: () async {
                  await SystemChrome.setPreferredOrientations([
                    DeviceOrientation.landscapeRight,
                    DeviceOrientation.landscapeLeft,
                  ]);
                  Get.toNamed('/video');
                },
              ),
            ),
          
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () {},
          )
        ],
        expandedHeight: responsive.hp(80),
        flexibleSpace: FlexibleSpaceBar(
          titlePadding: EdgeInsets.symmetric(vertical: responsive.hp(1)),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.photo_library_outlined, size: responsive.ip(1.5), color: colors.secondary),
              if(video != 'no-video') 
                ...[
                  SizedBox(width: responsive.ip(0.5)),
                  Icon(Icons.video_collection_outlined, size: responsive.ip(1.5), color: colors.secondary)
                ]
            ],
          ),
          background: PageView(
            onPageChanged: (page) => galleryController.currentPage = page,
            children: [
              HeaderImage(image),
              if(video != 'no-video')
                HeaderVideo(video)
            ],
          ),
        ),
      )
    );
  }
}
