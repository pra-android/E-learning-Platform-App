import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_learning_platform/blocs/purchase/purchase_bloc.dart';
import 'package:e_learning_platform/blocs/purchase/purchase_events.dart';
import 'package:e_learning_platform/blocs/purchase/purchase_states.dart';
import 'package:e_learning_platform/pages/history/history_purchase_card.dart';
import 'package:e_learning_platform/utilities/constants/colors_constant.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class History extends StatelessWidget {
  const History({super.key});

  @override
  Widget build(BuildContext context) {
    final userId = FirebaseAuth.instance.currentUser!.uid;

    return BlocProvider(
      create: (_) =>
          PurchaseBloc(FirebaseFirestore.instance)
            ..add(LoadPurchaseEvent(userId: userId)),
      child: Column(
        children: [
          SizedBox(height: 35.h),
          Center(
            child: Text(
              "Purchase History",
              style: TextStyle(
                color: Colors.black,
                fontSize: 15.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),

          // 🔥 Fetch purchases from Firestore
          Expanded(
            child: BlocBuilder<PurchaseBloc, PurchaseStates>(
              builder: (context, state) {
                if (state is PurchaseLoading) {
                  return Center(
                    child: CircularProgressIndicator(
                      color: AppColors.primaryColor,
                    ),
                  );
                } else if (state is PurchaseLoaded) {
                  if (state.purchases.isEmpty) {
                    return const Center(
                      child: Text("No purchase history yet."),
                    );
                  }
                  return ListView.builder(
                    padding: EdgeInsets.all(12),
                    itemCount: state.purchases.length,
                    itemBuilder: (context, index) {
                      final purchase = state.purchases[index];
                      return HistoryPurchaseCard(
                        title: purchase.courseName,
                        orderId: purchase.transactionId,
                        date: (purchase.paidAt.toString()),
                        status: "Succeeded",
                        statusColor: Colors.green,
                        price: purchase.amountPaid.toString(),
                      );
                    },
                  );
                } else if (state is PurchaseError) {
                  return Center(child: Text("Error: ${state.message}"));
                }
                return const SizedBox();
              },
            ),
          ),
        ],
      ),
    );
  }
}
