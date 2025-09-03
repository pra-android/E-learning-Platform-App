import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileMenuCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;
  final Color? color;

  const ProfileMenuCard({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 20.w, right: 8.w),
      child: ListTile(
        leading: Icon(icon, color: Colors.black, size: 18.sp),
        title: Text(
          title,
          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 13.sp),
        ),
        subtitle: subtitle.isNotEmpty
            ? Text(subtitle, style: TextStyle(fontSize: 11.sp))
            : null,

        onTap: onTap,
      ),
    );
  }
}
