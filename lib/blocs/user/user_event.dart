abstract class UserEvent {}

class LoadUserEvent extends UserEvent {
  final String uid;
  LoadUserEvent(this.uid);
}
