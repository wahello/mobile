class Event {
  final int playerId;
  final EventType type;
  final int instantaneaId;

  Event(this.playerId, this.type, this.instantaneaId);
}

enum EventType {
  yellowCard, redCard, goal, substitution
}