import 'package:flutter/material.dart';
import 'package:flutterhackathon_firecode/ui/homepage.dart';
import 'package:flutterhackathon_firecode/ui/login/login.dart';
import 'package:flutterhackathon_firecode/viewmodel/viewmodel.dart';
import 'package:provider/provider.dart';


class LandingPage extends StatelessWidget {
 
  @override
  Widget build(BuildContext context) {
    final _userviewmodel=Provider.of<ViewModel>(context);
    if(_userviewmodel.viewState==ViewState.Idle){
      if(_userviewmodel.userModel==null){
        return Login();
      }else{
        return HomePage();
      }

    }else{
      return Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    
  }
}