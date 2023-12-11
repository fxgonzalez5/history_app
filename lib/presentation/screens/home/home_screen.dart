import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:history_app/config/menu/menu_items.dart';
import 'package:history_app/config/theme/responsive.dart';
import 'package:history_app/presentation/screens/screens.dart';
import 'package:history_app/presentation/widgets/widgets.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive(context);
    final texts = Theme.of(context).textTheme;
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: IconButton(
                icon: const Icon(Icons.exit_to_app_rounded),
                iconSize: responsive.ip(3.5),
                color: colors.secondary,
                onPressed: (){
                  // TODO: Implementar el cierre de seisión
                },
              ),
            ),

            Column(
              children: [
                SizedBox(height: responsive.hp(5)),
                Text('UTPL en la historia', style: texts.headlineMedium,),
                CustomProgress(
                  padding: EdgeInsets.symmetric(vertical: responsive.ip(3), horizontal: responsive.ip(5)),
                  textColor: colors.secondary,
                  backgroundColor: colors.primary.withOpacity(0.2),
                  foregroundColor: colors.secondary,
                  valueProgress: 0.3
                ),
                Divider(
                  height: 10,
                  thickness: 2,
                  indent: responsive.ip(3),
                  endIndent: responsive.ip(3),
                ),
                const _MenuOptions(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _MenuOptions extends StatelessWidget {
  const _MenuOptions();

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive(context);
    final colors = Theme.of(context).colorScheme;

    return Expanded(
      child: ListView.separated(
        itemCount: 3,
        itemBuilder: (context, index) {
          final menuItem = appMenuItems[index];
    
          return ListItem(
            label: Image.asset(menuItem.image, width: responsive.wp(35), height: responsive.hp(13),),
            title: menuItem.title,
            subTitle: Text(
              menuItem.subTitle,
              style: TextStyle(
                fontSize: responsive.ip(1.5),
                color: Colors.grey,
              ),
            ),
            linkText: menuItem.linkText ,
            link: menuItem.link,
            linkStyle: TextStyle(
              fontSize: responsive.ip(1.5),
              color: colors.primary,
              fontWeight: FontWeight.bold,
              decoration: TextDecoration.underline,
              decorationColor: colors.primary,
              decorationThickness: 2,
            ),
            onTap: menuItem.route.isEmpty
            ? null
            : () {
              final navigationController = Get.find<NavigationController>();

              if (menuItem.route == '/gallery'){
                navigationController.selectMenuItem = 1;
              } else {
                Get.toNamed(menuItem.route);
              }
            },
          );
        },
        separatorBuilder: (context, index) => Divider(
          height: 10,
          thickness: 2,
          indent: responsive.ip(3),
          endIndent: responsive.ip(3),
        ),
      ),
    );
  }
}