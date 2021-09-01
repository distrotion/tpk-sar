import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tpk_login_arsa_01/script/bloc/BlocChagpage.dart';
import 'package:tpk_login_arsa_01/script/bloc/login/login_bloc.dart';

import 'package:tpk_login_arsa_01/script/sequnce/pagecon.dart';
import 'package:tpk_login_arsa_01/widget/AppBar.dart';
import 'package:tpk_login_arsa_01/widget/menu/mainmenu.dart';
import 'page/loginpage.dart';
//--------------------------------------------- Bloc
import 'package:flutter_bloc/flutter_bloc.dart';

class MainCenter extends StatelessWidget {
  const MainCenter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //return BodyBuffer();
    return pre_login();
  }
}

class pre_login extends StatelessWidget {
  const pre_login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => LoginBloc(),
        child: BlocBuilder<LoginBloc, String>(builder: (_, token) {
          print(token);
          if (token != '') {
            var _data_in_token = jsonDecode(token);
            if (_data_in_token['Status'] == 'ok') {
              return BodyBuffer(status: 'ok');
            } else {
              return BodyBuffer(status: '');
            }
          } else {
            return BodyBuffer(status: '');
          }
        }));
  }
}

class BodyBuffer extends StatelessWidget {
  BodyBuffer({Key? key, this.status}) : super(key: key);
  String? status;

  @override
  Widget build(BuildContext context) {
    String _status = status ?? '';

    return BlocProvider(
        create: (_) => SwPageCubit(),
        child: BlocBuilder<SwPageCubit, String>(builder: (_, Page) {
          print(Page);
          if (_status == 'ok') {
            Page = Page;
            if (Page == "loginpage") {
              Page = "Page1";
            }
          } else {
            Page = "loginpage";
          }
          Widget output = MainBody(selectpage(Page));
          if (Page == "loginpage") {
            output = selectpage(Page);
          } else {
            output = MainBody(selectpage(Page));
          }

          return output;
        }));
  }
}

class MainBody extends StatelessWidget {
  // const MainBody({Key? key}) : super(key: key);
  Widget page;
  MainBody(this.page);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF0b1327),
        actions: <Widget>[App_Bar()],
      ),
      drawer: MainMenu(),
      body: page,
    );
  }
}

class Loginbody extends StatelessWidget {
  const Loginbody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LoginPage();
  }
}
