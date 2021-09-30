import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:mais_filmes/app/core/constants/default_style.dart';

import '../../components/movie_card.dart';
import '../../components/title_bar_widget.dart';
import '../../controllers/movies_controller.dart';

class MoviesTab extends StatelessWidget {
  final MoviesController controller = Modular.get();

  MoviesTab({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const TitleBarWidget(title: "Episódios"),
            Expanded(
              child: Observer(
                name: "Popular Movies observer",
                builder: (context) => ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                  itemCount: controller.movies.length,
                  itemBuilder: (context, index) 
                    => MovieCard(controller.movies.elementAt(index))
                )
              ),
            ),
          ],
        ),
        _paginationButtons(context)
      ],
    );
  }

  Widget _paginationButtons(BuildContext context) => Align(
    alignment: Alignment.bottomRight,
    child: Padding(
      padding: const EdgeInsets.all(12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          _paginationButton(context, 
            onTap: () => controller.changeMoviesPage(-1),
            rigth: false,
          ),
          _paginationButton(context, 
            onTap: () => controller.changeMoviesPage(1),
            rigth: true
          ),
        ],
      ),
    ),
  );

  Widget _paginationButton(BuildContext context, {bool rigth = true, 
  required void Function()? onTap}) => InkWell(
    onTap: onTap,
    child: Card(
      shape: RoundedRectangleBorder(
        borderRadius: rigth ? const BorderRadius.only(
          topRight: Radius.circular(6),
          bottomLeft: Radius.circular(6)
        ) : const BorderRadius.only(
          topLeft: Radius.circular(6),
          bottomRight: Radius.circular(6)
        )
      ),
      color: DefaultStyle.currentTheme(context).primary,
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Icon(rigth ? Feather.chevron_right : Feather.chevron_left,
          size: 26,
          color: Colors.white
        ),
      )
    ),
  );
}