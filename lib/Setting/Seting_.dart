import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Screen_controllers/SettingController.dart';
import '../Widget/Setting_title.dart';

class SettingsScreen extends GetView<SettingsController> {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.put(SettingsController());

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: const Text(
          'Settings',
          style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.w600),
        ),
      ),
      body: ListView(
        children: [
          SettingsTile(icon: Icons.person_outline, title: 'Profile', onTap: (){}),
          SettingsTile(icon: Icons.account_balance_wallet_outlined, title: 'My Wallet', onTap: (){}),
          SettingsTile(icon: Icons.edit_note, title: 'My Post', onTap: (){}),
          SettingsTile(icon: Icons.trending_up, title: 'Boost Your Post', onTap: (){}),

          Obx(() => SettingsTile(
              icon: Icons.notifications_none,
              title: 'Notifications',
              onTap: (){},
              trailing: c.unreadNotifications.value > 0
                  ? Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircleAvatar(
                    radius: 9,
                    backgroundColor: Colors.red,
                    child: Text(
                      '${c.unreadNotifications.value}',
                      style: const TextStyle(fontSize: 11, color: Colors.white),
                    ),
                  ),
                  const SizedBox(width: 6),
                  const Icon(Icons.chevron_right, size: 20, color: Colors.grey),
                ],
              )
                  : null,
            ),
          ),

          SettingsTile(icon: Icons.description_outlined, title: 'Terms and Conditions', onTap: (){}),
          SettingsTile(icon: Icons.info_outline, title: 'About', onTap: (){}),
          SettingsTile(icon: Icons.card_giftcard_outlined, title: 'Watch Ads & Earn', onTap:  (){}),
          SettingsTile(icon: Icons.share_outlined, title: 'Refer and Earn', onTap: (){}),
          SettingsTile(
            icon: Icons.logout,
            title: 'Log Out',
            iconColor: Colors.black,
            titleColor: Colors.black,
            onTap: c.logoutUser,
          ),
        ],
      ),
    );
  }
}