import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/modules/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:mobile/modules/authentication/presentation/bloc/authentication_event.dart';
import 'package:mobile/modules/authentication/presentation/bloc/authentication_state.dart';

class MainDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
        child: Drawer(
      child: ListView(padding: EdgeInsets.zero, children: [
        DrawerHeader(
            child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
          builder: (context, state) {
            state = state as SignedInState;
            return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  // CircleAvatar(
                  //     radius: 36.0,
                  //     backgroundColor: Colors.transparent,
                  //     child: ClipOval(
                  //         child: Image.asset(state.currentUser.profileUrl!))),
                  // Text(state.currentUser.name!,
                  //     style: TextStyle(color: Colors.black, fontSize: 24)),
                  // Text(state.currentUser.phoneInfo!,
                  //     style: TextStyle(color: Colors.grey, fontSize: 15)),
                ]);
          },
        )),
        ListTile(leading: Icon(Icons.person), title: Text('My Profile')),
        ListTile(
            leading: Icon(Icons.group),
            title: Text('My Network'),
            onTap: () {}),
        ListTile(leading: Icon(Icons.history), title: Text('My Activity')),
        ListTile(leading: Icon(Icons.settings), title: Text('Settings')),
        ListTile(
          leading: Icon(Icons.logout),
          title: Text('Log out'),
          onTap: () {
            final provider = BlocProvider
              .of<AuthenticationBloc>(context);
            final phoneInfo = provider.state.phoneInfo;
            provider.add(OnSignOutRequested(phoneInfo: phoneInfo));
          })
      ]),
    ));
  }
}
