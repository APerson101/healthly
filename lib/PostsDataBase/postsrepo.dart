import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:healthly/helper/posts.dart';

class PostsRepo {
  PostsRepo();
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<List<Post>> getPosts({List<String> groups}) async {
    //1 get data from Firebase
    if (groups == null) {
      var user_groups = await getUserGroups();
      var result = await _getpostsFromDB(userGroups: user_groups);
      return result;
    } else
      return await _getpostsFromDB(userGroups: groups);

    //2 convert data to post class
    //3 send converted data
  }

  Future<List<String>> getUserGroups() async {
    if (firestore == null) return null;
    // /var userID = FirebaseAuth.instance.currentUser.uid;

    var userGroups = await _getGroupsIDsUser('MRiyE8ZMI82lXJcDQWJg');
    if (userGroups == null) {
      return null;
    } else
      return userGroups;
  }

  _getpostsFromDB({List<String> userGroups}) async {
    var postsDocsSnaps = await _getPostsfromFireBase(userGroups: userGroups);
    if (postsDocsSnaps != null) {
      //posts exists
      var listPosts = _mapPosts(postsDocsSnaps);
      return listPosts;
    } else
      return null;
  }

  Future<List<String>> _getGroupsIDsUser(String userID) async {
    // var userDoc = await firestore.collection('Users').doc(userID).get();
    // var username_ = userDoc.data()['Username'];

    var userGroups =
        await firestore.collection('User_groups').doc(userID).get();

    //groupIDS user follows
    //iterate over the user_groups and detect null/empty and get the groupIDs
    if (userGroups != null && userGroups.exists) {
      var dynamicNames = userGroups.get('group_names');
      List<String> groupNames = [];
      for (var item in dynamicNames) {
        groupNames.add(item.toString());
      }
      print(groupNames);
      return groupNames;
    } else {
      return null;
    }
  }

  _getPostsfromFireBase({List<String> userGroups}) async {
    Query postsQuery;
    if (userGroups != null) {
      postsQuery =
          firestore.collection('posts').where('group_id', whereIn: userGroups);
    } else if (userGroups == null) {
      postsQuery = firestore
          .collection('Posts')
          .orderBy('likes_count', descending: true)
          .limit(20);
    }

    var postsSnapShots = await postsQuery.get();

    var postDocs = postsSnapShots.docs;

    if (postDocs != null) {
      return postDocs;
    } else
      return null;
  }

  List<Post> _mapPosts(List<QueryDocumentSnapshot> postsDocsSnaps) {
    List<Post> _postsList = [];
    for (var item in postsDocsSnaps) {
      var _convertedDoc = Post.fromSnapshot(item);
      _postsList.add(_convertedDoc);
    }
    return _postsList;
  }

  determineGroups() async {
    return await getUserGroups();
  }

  getAllgroups() async {
    List<String> groups = [];
    var groupCollection = await firestore.collection('groups').get();
    var allDocs = groupCollection.docs;
    for (var item in allDocs) {
      groups.add(item.get('Name').toString());
    }
    return groups;
  }

  addGroup(String group) async {
    List<String> group_ = [];
    group_.add(group);
    await firestore
        .collection('User_groups')
        .doc('MRiyE8ZMI82lXJcDQWJg')
        .update({'group_names': FieldValue.arrayUnion(group_)});

    print('success');
  }

  removeGroup(String group) async {
    List<String> group_ = [];
    group_.add(group);
    await firestore
        .collection('User_groups')
        .doc('MRiyE8ZMI82lXJcDQWJg')
        .update({'group_names': FieldValue.arrayRemove(group_)});
  }
}
