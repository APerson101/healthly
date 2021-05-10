import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healthly/AddPostBloc/bloc/addpost_bloc.dart';
import 'package:healthly/helper/posts.dart';

class NewPost extends StatelessWidget {
  final List<String> userGroups;
  NewPost(this.userGroups);
  @override
  Widget build(BuildContext context) {
    return BlocProvider<AddpostBloc>(
      create: (_) => AddpostBloc(),
      child: Addp(userGroups),
    );
  }
}

class Addp extends StatelessWidget {
  TextEditingController titleController = TextEditingController(),
      contentController = TextEditingController();
  List<String> userGroups;

  Addp(this.userGroups);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          TextFormField(
            controller: titleController,
          ),
          TextFormField(
            controller: contentController,
          ),
          Expanded(
              child: ListView(
                  children: userGroupsBar(userGroups, context,
                      contentController, titleController))),
        ],
      ),
    );
  }

  userGroupsBar(
      List<String> userGroups, context, contentController, titleController) {
    List<ElevatedButton> usergroups = [];
    for (var item in userGroups) {
      usergroups.add(ElevatedButton(
        onPressed: () {
          var post = Post(
              Timestamp.now(),
              'MRiyE8ZMI82lXJcDQWJg',
              contentController.text,
              item,
              titleController.text,
              0.toString(),
              0.toString());
          BlocProvider.of<AddpostBloc>(context).add(AddPost(post));
        },
        child: Text(item),
      ));
    }
    return usergroups;
  }
}
