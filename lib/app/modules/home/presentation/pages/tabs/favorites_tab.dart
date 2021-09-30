import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../components/movie_card.dart';
import '../../components/title_bar_widget.dart';
import '../../controllers/favorites_controller.dart';

class FavoritesTab extends StatelessWidget {
  final FavoritesController controller = Modular.get();

  FavoritesTab({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const TitleBarWidget(title: "Para assistir mais tarde"),
        Expanded(
          child: Observer(
            name: "Favorites Movies observer",
            builder: (context) => ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
              itemCount: controller.favorites.length,
              itemBuilder: (context, index) 
                => MovieCard(controller.favorites.elementAt(index))
            )
          ),
        ),
      ],
    );
  }
}