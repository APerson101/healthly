part of 'addpost_bloc.dart';

abstract class AddpostEvent extends Equatable {
  const AddpostEvent();

  @override
  List<Object> get props => [];
}

class AddPost extends AddpostEvent {
  Post post;
  AddPost(this.post);
}
