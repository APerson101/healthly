import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class Post extends Equatable {
  static const CONTENT = 'content';
  static const USER = 'user_id';
  static const DATE = 'date';
  static const COMMENTS = 'comment_count';
  static const GROUP = 'group_id';
  static const LIKES = 'upvotes';
  static const TITLE = 'topic';

  String _content, _posterId, _groupId, _title, _key;
  Timestamp _dateposted;
  String _commentCount, _likesCount;
  bool likeStatus;

  Post(this._dateposted, this._posterId, this._content, this._groupId,
      this._title, this._commentCount, this._likesCount);

  String get content => _content;
  Timestamp get date => _dateposted;
  String get posterID => _posterId;
  String get groupID => _groupId;
  String get commentCount => _commentCount;
  String get likesCount => _likesCount;
  String get title => _title;
  String get key => _key;

  Post.fromSnapshot(QueryDocumentSnapshot snap)
      : this._key = snap.id,
        this._content = snap.get(CONTENT),
        this._dateposted = snap.get(DATE),
        this._posterId = snap.get(USER),
        this._groupId = snap.get(GROUP),
        this._commentCount = snap.get(COMMENTS),
        this._likesCount = snap.get(LIKES),
        this._title = snap.get(TITLE);

  Map<String, dynamic> toJSON() {
    return {
      TITLE: _title,
      CONTENT: _content,
      USER: _posterId,
      DATE: _dateposted,
      GROUP: _groupId,
      LIKES: _likesCount,
      COMMENTS: _commentCount
    };
  }

  @override
  List<Object> get props => [];

  @override
  String toString() {
    print('$TITLE: $_title\n $CONTENT: $_content\n ');
    print('$USER: $_posterId\n $DATE: $_dateposted\n ');
    return super.toString();
  }
}
