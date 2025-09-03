import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'notification_event.dart';
import 'notification_state.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  final FirebaseFirestore firestore;

  NotificationBloc({required this.firestore}) : super(NotificationInitial()) {
    on<LoadNotifications>(_onLoadNotifications);
    on<AddNotification>(_onAddNotification);
    on<ClearNotifications>(_onClearNotifications);
  }

  // Load notifications for a specific user
  Future<void> _onLoadNotifications(
    LoadNotifications event,
    Emitter<NotificationState> emit,
  ) async {
    emit(NotificationLoading());
    try {
      final snapshot = await firestore
          .collection("notifications")
          .orderBy("createdAt", descending: true)
          .get();

      List<Map<String, dynamic>> notifications = snapshot.docs.map((doc) {
        final data = doc.data();
        return {
          "id": doc.id,
          "title": data["title"] ?? "",
          "body": data["body"] ?? "",
          "courseId": data["courseId"] ?? "",
          "isRead": data["isRead"] ?? false,
          "createdAt": data["createdAt"],
        };
      }).toList();

      emit(NotificationLoaded(notifications));
    } catch (e) {
      emit(NotificationError("Failed to load notifications: $e"));
    }
  }

  void _onAddNotification(
    AddNotification event,
    Emitter<NotificationState> emit,
  ) async {
    if (state is NotificationLoaded) {
      final current = (state as NotificationLoaded).notifications;
      final updated = List<Map<String, dynamic>>.from(current)
        ..insert(0, event.notification); // newest first
      emit(NotificationLoaded(updated));
    }
  }

  void _onClearNotifications(
    ClearNotifications event,
    Emitter<NotificationState> emit,
  ) {
    emit(NotificationLoaded([]));
  }
}
