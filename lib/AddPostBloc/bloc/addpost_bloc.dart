import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:healthly/AddPostBloc/addpostrepo.dart';
import 'package:healthly/helper/posts.dart';

part 'addpost_event.dart';
part 'addpost_state.dart';

class AddpostBloc extends Bloc<AddpostEvent, AddpostState> {
  AddpostBloc() : super(AddpostInitial());
  AddPostRepo addPostRepo = AddPostRepo();
  @override
  Stream<AddpostState> mapEventToState(
    AddpostEvent event,
  ) async* {
    if (event is AddPost) {
      await addPostRepo.addPost(event.post);
    }
  }
}
