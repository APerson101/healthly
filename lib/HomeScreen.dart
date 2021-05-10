import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'PostsDataBase/bloc/loadposts.dart';
import 'newpost.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LoadpostsBloc>(create: (_) {
          var loader = LoadpostsBloc();
          loader.add(LoadPost());
          return loader;
        })
      ],
      child: _home(),
    );
  }
}

class _home extends StatelessWidget {
  _home();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoadpostsBloc, LoadpostsState>(
        builder: (context, state) {
      if (state is LoadpostsInitial) {
        return CircularProgressIndicator();
      } else if (state is LoadpostsComplete) {
        var posts = state.posts;
        print(posts);
        var userGroups = state.userGroups;
        return Container(
            child: SafeArea(
                child: Column(children: [
          Expanded(
              child:
                  ListView(children: groupsWidget(state.allgroups, context))),
          SizedBox(height: 4),
          Expanded(
              child: ListView(children: userGroupsBar(userGroups, context))),
          //add new post
          ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => NewPost(userGroups)));
              },
              child: Text('add post'))
        ])));
      }
      return Container();
    });
  }

  groupsWidget(List<String> groups, context) {
    List<ElevatedButton> groupsWidget = [];
    for (var item in groups) {
      groupsWidget.add(ElevatedButton(
          onPressed: () {
            BlocProvider.of<LoadpostsBloc>(context).add(Addgroup(item));
          },
          child: Text(item)));
    }
    return groupsWidget;
  }

  userGroupsBar(List<String> userGroups, context) {
    List<ElevatedButton> usergroups = [];
    for (var item in userGroups) {
      usergroups.add(ElevatedButton(
        onPressed: () {
          BlocProvider.of<LoadpostsBloc>(context).add(Removegroup(item));
        },
        child: Text(item),
      ));
    }
    return usergroups;
  }
}
