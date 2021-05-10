import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:healthly/PostsDataBase/postsrepo.dart';
import 'loadposts.dart';

class LoadpostsBloc extends Bloc<LoadpostsEvent, LoadpostsState> {
  LoadpostsBloc() : super(LoadpostsInitial());
  PostsRepo _postsRepo = PostsRepo();
  @override
  Stream<LoadpostsState> mapEventToState(
    LoadpostsEvent event,
  ) async* {
    //if state is load post initial, time to load all posts in groups associated with the user
    if (event is LoadPost) {
      print('starting retrieval from database');
      var posts = await _postsRepo.getPosts();
      var userGroups = await _postsRepo.getUserGroups();
      var groups = await _postsRepo.getAllgroups();

      yield LoadpostsComplete(posts, groups, userGroups);
    }

    if (event is Addgroup) {
      print('Adding Group');
      await _postsRepo.addGroup(event.group);
    }

    if (event is Removegroup) {
      print('removing group');
      await _postsRepo.removeGroup(event.group);
    }
  }
}
