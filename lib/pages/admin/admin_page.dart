import 'dart:io';
import 'package:e_learning_platform/blocs/admin/admin_bloc.dart';
import 'package:e_learning_platform/blocs/admin/admin_event.dart';
import 'package:e_learning_platform/blocs/admin/admin_state.dart';
import 'package:e_learning_platform/utilities/formvalidation/form_validation.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path_provider/path_provider.dart';

import '../../utilities/constants/colors_constant.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({super.key});

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  String priceType = "Free"; // Default
  File? pickedVideo;
  File? pickedImage;

  //pick video
  Future<void> _pickVideo() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.video,
    );
    if (result != null) {
      File original = File(result.files.single.path!);
      File copied = await _copyToAppDir(original);
      setState(() {
        pickedVideo = copied;
      });
    }
  }

  //pick Image
  Future<void> _pickImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );
    if (result != null) {
      File original = File(result.files.single.path!);
      //picking image path
      debugPrint("Picking image patg is $original");
      File copied = await _copyToAppDir(original);
      setState(() {
        pickedImage = copied;
      });
    }
  }

  //pick pdf
  Future<File> _copyToAppDir(File file) async {
    final appDir = await getApplicationDocumentsDirectory();
    final newFile = await file.copy(
      '${appDir.path}/${file.path.split('/').last}',
    );
    return newFile;
  }

  List<File> pickedPdfs = [];

  Future<void> _pickPdfs() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
      allowMultiple: true,
    );
    if (result != null) {
      pickedPdfs = [];
      for (var file in result.files) {
        File original = File(file.path!);
        File copied = await _copyToAppDir(original); // copy like image/video
        pickedPdfs.add(copied);
      }
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AdminBloc(),
      child: Builder(
        builder: (context) {
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              centerTitle: true,
              leading: IconButton(
                onPressed: () {
                  context.pop();
                },
                icon: Icon(
                  Icons.arrow_back_ios_new_outlined,
                  color: Colors.white,
                  size: 14.sp,
                ),
              ),
              backgroundColor: AppColors.primaryColor,
              title: Text(
                "Admin Features",
                style: GoogleFonts.lato(
                  textStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            body: SafeArea(
              child: Padding(
                padding: EdgeInsets.all(16.w),
                child: Form(
                  key: FormValidations.adminFormKey,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        /// IMAGE PICKER
                        Text(
                          "Course Thumbnail",
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                        SizedBox(height: 8.h),
                        GestureDetector(
                          onTap: _pickImage,
                          child: Container(
                            height: 150.h,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12.r),
                              border: Border.all(color: Colors.grey),
                            ),
                            child: pickedImage != null
                                ? ClipRRect(
                                    borderRadius: BorderRadius.circular(12.r),
                                    child: Image.file(
                                      pickedImage!,
                                      fit: BoxFit.cover,
                                    ),
                                  )
                                : Center(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Icon(
                                          Icons.image,
                                          size: 40,
                                          color: Colors.grey,
                                        ),
                                        Text("Tap to pick image"),
                                      ],
                                    ),
                                  ),
                          ),
                        ),
                        SizedBox(height: 20.h),

                        /// VIDEO PICKER
                        Text(
                          "Course Video",
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                        SizedBox(height: 8.h),
                        GestureDetector(
                          onTap: _pickVideo,
                          child: Container(
                            height: 100.h,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12.r),
                              border: Border.all(color: Colors.grey),
                              color: Colors.grey[100],
                            ),
                            child: Center(
                              child: pickedVideo != null
                                  ? Text(
                                      "Video Selected: ${pickedVideo!.path.split('/').last}",
                                    )
                                  : Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Icon(
                                          Icons.video_library,
                                          size: 40,
                                          color: Colors.grey,
                                        ),
                                        Text("Tap to pick video"),
                                      ],
                                    ),
                            ),
                          ),
                        ),
                        SizedBox(height: 20.h),
                        Text(
                          "Course PDFs",
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                        SizedBox(height: 8.h),
                        GestureDetector(
                          onTap: _pickPdfs,
                          child: Container(
                            height: 100.h,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12.r),
                              border: Border.all(color: Colors.grey),
                              color: Colors.grey[100],
                            ),
                            child: Center(
                              child: pickedPdfs.isNotEmpty
                                  ? Text("${pickedPdfs.length} PDF(s) selected")
                                  : Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Icon(
                                          Icons.picture_as_pdf,
                                          size: 40,
                                          color: Colors.grey,
                                        ),
                                        Text("Tap to pick PDF(s)"),
                                      ],
                                    ),
                            ),
                          ),
                        ),

                        /// TITLE & CATEGORY (Row)
                        SizedBox(height: 10.h),
                        Row(
                          children: [
                            Expanded(
                              child: _buildTextField(
                                "Title",
                                FormValidations.titleController,
                              ),
                            ),
                            SizedBox(width: 12.w),
                            Expanded(
                              child: _buildTextField(
                                "Category",
                                FormValidations.categoryController,
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: 12.h),

                        /// PRICE & PRICE TYPE (Row)
                        Row(
                          children: [
                            Expanded(
                              child: _buildTextField(
                                "Price",
                                FormValidations.priceController,
                                keyboardType: TextInputType.number,
                              ),
                            ),
                            SizedBox(width: 12.w),
                            Expanded(
                              child: DropdownButtonFormField<String>(
                                value: priceType,
                                items: ["Free", "Paid"].map((e) {
                                  return DropdownMenuItem(
                                    value: e,
                                    child: Text(e),
                                  );
                                }).toList(),
                                decoration: InputDecoration(
                                  labelText: "Price Type",
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.r),
                                  ),
                                ),
                                onChanged: (value) {
                                  setState(() {
                                    priceType = value!;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: 12.h),

                        /// DESCRIPTION (Full Width)
                        _buildTextField(
                          "Description",
                          FormValidations.descriptionController,
                          maxLines: 3,
                        ),

                        /// Created At (Auto)
                        SizedBox(height: 12.h),

                        SizedBox(height: 20.h),
                        BlocConsumer<AdminBloc, AdminState>(
                          listener: (context, state) {
                            if (state is AdminSuccess) {
                              FormValidations.titleController.clear();
                              FormValidations.categoryController.clear();
                              FormValidations.priceController.clear();
                              FormValidations.descriptionController.clear();
                              setState(() {
                                pickedImage = null;
                                pickedVideo = null;
                                pickedPdfs = [];
                                priceType = "Free";
                              });
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  backgroundColor: Colors.green,
                                  content: Text("Course added succesfully"),
                                ),
                              );
                            } else if (state is AdminFailure) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text("Error: ${state.error}"),
                                ),
                              );
                            }
                          },
                          builder: (context, state) {
                            return ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.primaryColor,
                                minimumSize: Size(double.infinity, 50.h),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12.r),
                                ),
                              ),
                              onPressed: state is AdminLoading
                                  ? null
                                  : () {
                                      if (FormValidations
                                          .adminFormKey
                                          .currentState!
                                          .validate()) {
                                        context.read<AdminBloc>().add(
                                          SubmitCourseEvent(
                                            title: FormValidations
                                                .titleController
                                                .text,
                                            category: FormValidations
                                                .categoryController
                                                .text,
                                            description: FormValidations
                                                .descriptionController
                                                .text,
                                            price: FormValidations
                                                .priceController
                                                .text,
                                            priceType: priceType,
                                            imageFile: pickedImage,
                                            videoFile: pickedVideo,
                                            pdfFile: pickedPdfs,
                                          ),
                                        );
                                      }
                                    },
                              child: state is AdminLoading?
                                  ? const CircularProgressIndicator(
                                      color: Colors.white,
                                      strokeWidth: 2,
                                    )
                                  : Text(
                                      "Submit",
                                      style: GoogleFonts.lato(
                                        textStyle: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildTextField(
    String label,
    TextEditingController controller, {
    int maxLines = 1,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      keyboardType: keyboardType,
      validator: (value) =>
          value == null || value.isEmpty ? "Enter $label" : null,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.r)),
      ),
    );
  }
}
