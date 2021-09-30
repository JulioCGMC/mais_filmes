import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:mais_filmes/app/core/constants/default_style.dart';
import 'package:mais_filmes/app/modules/login/presentation/components/custom_fade_animation_widget.dart';

import '../controllers/login_controller.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);
  @override 
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends ModularState<LoginPage, LoginController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/img/bg2.jpg'),
                fit: BoxFit.fill
              )
            ),
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 250,
                  child: CustomFadeAnimationWidget(
                    delay: 1.6, 
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          MaterialCommunityIcons.movie_open,
                          color: DefaultStyle.currentTheme(context).primary,
                          size: 64,
                        ),
                        const Text("Login", 
                          style: TextStyle(color: Colors.white, 
                            fontSize: 40, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  )
                ),
                Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Column(
                    children: <Widget>[
                      CustomFadeAnimationWidget(
                          delay: 1.8, 
                          child: Container(
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: DefaultStyle.currentTheme(context)
                                  .primary.withOpacity(0.2),
                              blurRadius: 20.0,
                              offset: const Offset(0, 10)
                            )
                          ]
                        ),
                        child: _form(context),
                      )),
                      const SizedBox(height: 30,),
                      CustomFadeAnimationWidget(
                          delay: 2,
                          child: _button(context)
                        )
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      )
    );
  }

  Widget _form(BuildContext context) => Column(
    children: <Widget>[
      Container(
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(color: Colors.grey[100]!))
        ),
        child: TextField(
          onChanged: (input) => controller.name = input,
          style: TextStyle(color: Colors.grey[700]),
          decoration: const InputDecoration(
            border: InputBorder.none,
            hintText: "Nome",
            hintStyle: TextStyle(color: Colors.grey),
          ),
        ),
      ),
      Container(
        padding: const EdgeInsets.all(8.0),
        child: TextField(
          onChanged: (input) => controller.email = input,
          style: TextStyle(color: Colors.grey[700]),
          decoration: const InputDecoration(
            border: InputBorder.none,
            hintText: "Email",
            hintStyle: TextStyle(color: Colors.grey)
          ),
        ),
      )
    ],
  );

  Widget _button(BuildContext context) => InkWell(
    onTap: () => controller.enters(),
    child: Container(
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        gradient: LinearGradient(
          colors: [
            DefaultStyle.currentTheme(context).primary,
            DefaultStyle.currentTheme(context)
                .primary.withOpacity(0.6),
          ]
        )
      ),
      child: const Center(
        child: Text("Login", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
      ),
    ),
  );
}