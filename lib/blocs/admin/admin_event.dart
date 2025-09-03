import 'dart:io';

abstract class AdminEvent {}

class SubmitCourseEvent extends AdminEvent {
  final String title;
  final String category;
  final String description;
  final String price;
  final String priceType;
  final File? imageFile;
  final File? videoFile;
  final List<File>? pdfFile;

  SubmitCourseEvent({
    required this.title,
    required this.category,
    required this.description,
    required this.price,
    required this.priceType,
    this.imageFile,
    this.videoFile,
    this.pdfFile,
  });
}
