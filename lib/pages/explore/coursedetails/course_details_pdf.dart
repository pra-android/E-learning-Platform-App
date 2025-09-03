import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class CourseDetailsPdf extends StatelessWidget {
  final String url;
  const CourseDetailsPdf({super.key, required this.url});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SfPdfViewer.network(url),

          Positioned(
            top: 35.h,
            left: 10.w,
            child: InkWell(
              onTap: () {
                context.pop();
              },
              child: CircleAvatar(
                backgroundColor: Colors.black,
                child: Icon(
                  Icons.arrow_back_ios_new_outlined,
                  color: Colors.white,
                  size: 14.sp,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
