import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wholecela/core/config/constants.dart';
import 'package:wholecela/presentation/widgets/menu_drawer.dart';

class ContactScreen extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute(builder: (context) => const ContactScreen());
  }

  const ContactScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      drawer: const MenuDrawer(),
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text(
          "Contact Us",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: const ContactInformationSection(),
    );
  }
}

class ContactInformationSection extends StatefulWidget {
  const ContactInformationSection({super.key});

  @override
  State<ContactInformationSection> createState() =>
      _ContactInformationSectionState();
}

class _ContactInformationSectionState extends State<ContactInformationSection> {
  dynamic launchEmail() async {
    try {
      Uri email = Uri(
        scheme: 'mailto',
        path: "wholecela@gmail.com",
        queryParameters: {'subject': "Wholecela Queries"},
      );

      await launchUrl(email);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  dynamic launchTel() async {
    try {
      Uri phone = Uri(
        scheme: 'tel',
        path: "+263715346351",
      );

      await launchUrl(phone, mode: LaunchMode.externalApplication);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  dynamic launchBrowser({required String url}) async {
    try {
      Uri link = Uri(scheme: 'https', path: url);

      await launchUrl(link, mode: LaunchMode.externalApplication);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: ListView(
        children: [
          ContactItem(
              title: "Facebook - Wholecela Listings",
              icon: Icons.facebook,
              onTap: () async {
                await launchBrowser(url: "www.facebook.com/wholecela/");
              }),
          verticalSpace(height: 15),
          ContactItem(
              title: "WhatsApp Business",
              icon: Icons.wechat_sharp,
              onTap: () async {
                await launchBrowser(url: "wa.me/263715346351");
              }),
          verticalSpace(height: 15),
          ContactItem(
              title: "Twitter - @wholecela",
              icon: Icons.close,
              onTap: () async {
                await launchBrowser(url: "www.twitter.com/wholecela");
              }),
          verticalSpace(height: 15),
          ContactItem(
              title: "Instagram - @wholecela",
              icon: Icons.photo_camera_outlined,
              onTap: () async {
                await launchBrowser(url: "www.instagram.com/wholecela");
              }),
          verticalSpace(height: 15),
          ContactItem(
              title: "Youtube - Wholecela Listings",
              icon: Icons.smart_display_outlined,
              onTap: () async {
                await launchBrowser(url: "www.youtube.com/@wholecela");
              }),
          verticalSpace(height: 15),
          ContactItem(
            title: "Tiktok - @wholecela",
            icon: Icons.tiktok,
            onTap: () async {
              await launchBrowser(url: "vm.tiktok.com/ZM2KSqC1p/");
            },
          ),
          verticalSpace(height: 15),
          ContactItem(
            title: "Call Us",
            icon: Icons.phone,
            onTap: () async {
              await launchTel();
            },
          ),
        ],
      ),
    );
  }
}

class ContactItem extends StatelessWidget {
  final String title;
  final IconData icon;
  final void Function()? onTap;
  const ContactItem({
    super.key,
    required this.title,
    required this.icon,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: kWhiteColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              title,
              style: const TextStyle(
                color: kBlackColor,
                fontSize: kMediumTextSize,
                fontWeight: FontWeight.bold,
              ),
            ),
            horizontalSpace(),
            Icon(
              icon,
              color: kBlackFaded,
              size: kIconSize,
            ),
          ],
        ),
      ),
    );
  }
}
