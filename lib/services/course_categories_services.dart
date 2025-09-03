import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_learning_platform/repositories/course_categories_repositories.dart';
import 'package:flutter/widgets.dart';

class CourseCategoriesServices implements CourseCategoriesRepositories {
  FirebaseFirestore firebaseFirestore;

  CourseCategoriesServices(this.firebaseFirestore);
  @override
  Future<List<String>> getCourseCategories() async {
    try {
      final rawdata = await firebaseFirestore.collection("courses").get();
      final categories = rawdata.docs
          .map((e) => e['category'] as String)
          .toSet()
          .toList();
      return categories;
    } catch (e) {
      debugPrint("Error fetching categories: $e");

      return [];
    }
  }
}
