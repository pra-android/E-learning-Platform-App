import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_learning_platform/blocs/purchase/purchase_events.dart';
import 'package:e_learning_platform/blocs/purchase/purchase_states.dart';
import 'package:e_learning_platform/models/purchasemodel/purchase_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PurchaseBloc extends Bloc<PurchaseEvents, PurchaseStates> {
  final FirebaseFirestore firestore;
  PurchaseBloc(this.firestore) : super(PurchaseLoading()) {
    on<LoadPurchaseEvent>((event, emit) async {
      try {
        emit(PurchaseLoading());

        final snapshot = await firestore
            .collection("users")
            .doc(event.userId)
            .collection("purchasedCourses")
            .orderBy("paidAt", descending: true)
            .get();

        final purchasesCourses = snapshot.docs
            .map((e) => Purchase.fromDoc(e))
            .toList();
        emit(PurchaseLoaded(purchasesCourses));
      } catch (e) {
        debugPrint(e.toString());
        emit(PurchaseError(e.toString()));
      }
    });
  }
}
