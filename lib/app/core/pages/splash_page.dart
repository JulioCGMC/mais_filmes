import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:mais_filmes/app/core/constants/default_style.dart';
import 'package:mais_filmes/app/core/constants/metadata.dart';
import 'package:mais_filmes/app/shared/stores/auth_store.dart';

class SplashScreenPage extends StatelessWidget {
  SplashScreenPage({Key? key}) : super(key: key) {
    _appRedirection();
  }

  Future<void> _appRedirection() async {
    AuthStore authStore = Modular.get();
    if (await authStore.isLogged) {
      return Modular.to.navigate(Metadata.loggedRoute);
    }
    else {
      return Modular.to.navigate(Metadata.unloggedRoute);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            MaterialCommunityIcons.movie_open,
            color: DefaultStyle.currentTheme(context).primary,
            size: 123,
          ),
          const SizedBox(height: 5),
          Text(Metadata.appName, 
            style: Theme.of(context).textTheme.headline6!.apply(
              color: DefaultStyle.currentTheme(context).onSurface
            ))
        ]
      )
    );
  }
}
