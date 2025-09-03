abstract class NotificationEvent {}

class LoadNotifications extends NotificationEvent {}

class AddNotification extends NotificationEvent {
  final Map<String, dynamic> notification;
  AddNotification(this.notification);
}

class ClearNotifications extends NotificationEvent {}
