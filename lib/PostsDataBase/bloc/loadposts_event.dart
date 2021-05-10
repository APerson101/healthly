abstract class LoadpostsEvent {}

class LoadPost extends LoadpostsEvent {}

class Addgroup extends LoadpostsEvent {
  String group;
  Addgroup(this.group);
}

class Removegroup extends LoadpostsEvent {
  String group;
  Removegroup(this.group);
}
