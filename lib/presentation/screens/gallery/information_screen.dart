import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:history_app/config/theme/responsive.dart';
import 'package:history_app/infraestructure/models/hito_model.dart';
import 'package:history_app/presentation/widgets/widgets.dart';


class InformationScreen extends StatelessWidget {
  const InformationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive(context);
    final hito = Get.arguments as HitosModel;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _CustomSliverAppBar(hito.image),

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
  final HitosModel hito;

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
  final HitosModel hito;

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
              Text('Año: ${hito.date}', style: texts.titleSmall,),
            ],
          ),
        ),
      ),
    );
  }
}

class _CustomSliverAppBar extends StatelessWidget {
  final String image;

  const _CustomSliverAppBar(this.image);

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive(context);

    return SliverAppBar(
      actions: [
        IconButton(
          icon: const Icon(Icons.share),
          onPressed: () {},
        )
      ],
      backgroundColor: Colors.transparent,
      expandedHeight: responsive.hp(80),
      flexibleSpace: FlexibleSpaceBar(
        background: Center(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(responsive.ip(1)),
            child: Image.network(
              image,
              width: responsive.wp(70),
              height: responsive.hp(50),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}