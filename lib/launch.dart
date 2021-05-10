import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:healthly/createacc.dart';

import 'MainApp.dart';

class Launch extends StatelessWidget {
  TextEditingController usernameController;
  TextEditingController passwordController;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: SafeArea(
          child: Column(
        children: [
          login(context, usernameController, passwordController),
          Divider(),
          createAccount(context)
        ],
      )),
    );
  }

  Widget login(context, TextEditingController usernameController,
      TextEditingController passwordController) {
    return Container(
      child: Column(
        children: [
          Text('LOGIN'),
          Row(
            children: [
              Text('Username'),
              // Container(
              //     child: ConstrainedBox(
              //         constraints: BoxConstraints.tight(const Size(200, 50)),
              //         child: Center(
              //             child: TextFormField(
              //           controller: usernameController,
              //         ))))
            ],
          ),
          Row(
            children: [
              Text('Password'),
              // TextField(
              //   controller: passwordController,
              // )
            ],
          ),
          RaisedButton(onPressed: () {
            // if (usernameController.text == 'patient' &&
            //     passwordController.text == 'patient')
            {
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => MainApp()),
                  (route) => false);
            }
          })
        ],
      ),
    );
  }

  createAccount(context) {
    return Container(
      child: RaisedButton(
        child: Text('create account'),
        onPressed: () => Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => CreateAccount()),
            (route) => false),
      ),
    );
  }
}
