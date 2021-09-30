import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:mais_filmes/app/core/constants/default_style.dart';
import 'package:mais_filmes/app/modules/home/domain/entities/movie.dart';
import 'package:mais_filmes/app/modules/home/presentation/controllers/movie_details_controller.dart';

class MovieDetailsPage extends StatelessWidget {
  final MovieDetailsController controller = Modular.get();
  final Movie movie;
  MovieDetailsPage(this.movie, { Key? key }) : super(key: key);

  bool get isFavorite {
    return controller.favorites.any((m) => m.id == movie.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: _movieDetail(context),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      title: Text(movie.title),
      actions: [
        _favButton(context)
      ],
    );
  }

  Widget _movieDetail(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Stack(
      children: [
        _coverImage(screenSize),
        Column(
          children: [
            SizedBox(height: 0.3 * screenSize.height),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      DefaultStyle.currentTheme(context).background.withOpacity(0.2),
                      DefaultStyle.currentTheme(context).background,
                    ],
                    stops: const [0,0.08],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter
                  )
                ),
                child: ListView(
                  padding: const EdgeInsets.only(top: 3),
                  children: [
                    _firstInfo(context),
                    _description(context),
                  ],
                ),
              ),
            ),
          ],
        )
      ],
    );
  }

  Widget _description(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(15, 0, 15, 10),
      child: Text(
        movie.description,
        textAlign: TextAlign.justify,
        style: const TextStyle(
          height: 1.4
        ),
      ),
    );
  }

  Widget _firstInfo(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              const Icon(Icons.star, color: Colors.yellow),
              Text(movie.voteAverage.toStringAsFixed(1), style: TextStyle(
                color: DefaultStyle.currentTheme(context).onBackground
              )),
            ],
          ),
          const Spacer(),
          Text("Lançado em ${movie.formattedReleaseDate}", style: TextStyle(
            fontSize: 12,
            fontStyle: FontStyle.italic,
            color: DefaultStyle.currentTheme(context).onBackground.withOpacity(0.7)
          )),
        ],
      ),
    );
  }

  Widget _coverImage(Size screenSize) => Hero(
    tag: "image_tag_${movie.id}",
    child: Image.network(movie.coverUrl, 
      height: 0.35 * screenSize.height, fit: BoxFit.fitHeight)
  );

  Widget _favButton(BuildContext contex) => Align(
    alignment: const Alignment(1,-0.4),
    child: IconButton(
      onPressed: () async {
        await controller.addFavorite(movie, isFavorite);
      },
      icon: Observer(
        builder: (context) => Icon(isFavorite 
          ? Entypo.heart : Entypo.heart_outlined, 
          color: isFavorite 
            ? DefaultStyle.currentTheme(context).primary
            : Colors.grey[900]!,
          size: 32
        )
      )
    ),
  );
}