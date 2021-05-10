import 'package:healthly/helper/posts.dart';

abstract class LoadpostsState {}

class LoadpostsInitial extends LoadpostsState {}

class LoadpostsComplete extends LoadpostsState {
  List<Post> posts;
  List<String> allgroups;
  List<String> userGroups;
  LoadpostsComplete(this.posts, this.allgroups, this.userGroups);
}
