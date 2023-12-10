import 'package:flutter/material.dart';
import 'package:history_app/config/theme/responsive.dart';
import 'package:url_launcher/url_launcher.dart';

class ListItem extends StatelessWidget {
  final Widget label;
  final String title;
  final Widget subTitle;
  final String? linkText;
  final String? link;
  final TextStyle? linkStyle;
  final String route;
  final VoidCallback? onTap;

  const ListItem({
    super.key, 
    required this.label,
    required this.title,
    required this.subTitle,
    this.linkText,
    this.link,
    this.linkStyle,
    required this.route,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive(context);
    final texts = Theme.of(context).textTheme;

    Future<void> openUrl(String link) async {
      final Uri url = Uri.parse(link);

      if (!await launchUrl(url)) {
        throw Exception('Could not launch $url');
      }
    }

    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: responsive.hp(15),
        padding: EdgeInsets.symmetric(horizontal: responsive.ip(1)),
        child: Row(
          children: [
            label,
            SizedBox(width: responsive.ip(1)),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: texts.headlineSmall,),
                  SizedBox(height: responsive.ip(1),),
                  subTitle,
                  if (linkText != null)
                    InkWell(
                      child: Text(
                        linkText!,
                        style: linkStyle
                      ),
                      onTap: () {
                        if (link != null){
                          openUrl(link!);
                        }
                      },
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}