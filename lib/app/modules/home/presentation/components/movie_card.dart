import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:mais_filmes/app/modules/home/presentation/controllers/movie_card_controller.dart';
import '../../domain/entities/movie.dart';

import '../../../../core/constants/default_style.dart';
import '../controllers/movies_controller.dart';

class MovieCard extends StatefulWidget {
  final Movie movie;

  const MovieCard(this.movie, {Key? key}) : super(key: key);

  @override
  State<MovieCard> createState() => _MovieCardState();
}

class _MovieCardState extends State<MovieCard> {
  final MovieCardController controller = Modular.get();

  bool get isFavorite {
    return controller.baseController.favorites.any((m) => m.id == widget.movie.id);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => controller.showMovie(widget.movie),
      child: Container(
        height: 200,
        alignment: Alignment.bottomLeft,
        child: Stack(
          children: <Widget>[
            Container(
              height: 180,
              alignment: Alignment.bottomLeft,
              child: Stack(
                fit: StackFit.passthrough,
                children: [
                  Column(
                    children: [
                      const Spacer(),
                      Container(
                        alignment: Alignment.bottomLeft,
                        width: MediaQuery.of(context).size.width,
                        height: 140,
                        padding: const EdgeInsets.symmetric(vertical: 12,horizontal: 12),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12)
                        ),
                        child: Row(
                          children: <Widget>[
                            Container(
                              width: 130,
                            ),
                            _cardInfo(context),
                          ],
                        )
                      ),
                    ],
                  ),
                  _favButton(context)
                ],
              ),
            ),
            Container(
              height: 180,
              margin: const EdgeInsets.only(left: 12, top: 6),
              child: _image(context)
            ),
          ]
        )
      ),
    );
  }

  Widget _cardInfo(BuildContext context) => SizedBox(
    width: MediaQuery.of(context).size.width - 170,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          width: 0.45 * MediaQuery.of(context).size.width,
          child: Text(widget.movie.title, 
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: Colors.black87,
              fontSize: 14,
              fontWeight: FontWeight.w500
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(widget.movie.description,
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            color: Colors.grey,
            fontSize: 12
          ),
        ),
        const Spacer(),
        Row(
          children: <Widget>[
            Row(
              children: [
                const Icon(Icons.star, color: Colors.yellow),
                Text(widget.movie.voteAverage.toStringAsFixed(1), style: TextStyle(
                  color: DefaultStyle.currentTheme(context).background
                )),
              ],
            ),
            const Spacer(),
            Text("Lançado em ${widget.movie.formattedReleaseDate}", style: TextStyle(
              fontSize: 11,
              fontStyle: FontStyle.italic,
              color: DefaultStyle.currentTheme(context).background.withOpacity(0.7)
            )),
          ],
        )
      ],
    ),
  );

  Widget _image(BuildContext context) => Hero(
    tag: "image_tag_${widget.movie.id}",
    child: ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Image.network(
        widget.movie.posterUrl,
        height: 160,
        width: 120,
        fit: BoxFit.cover
      )
    ),
  );

  Widget _favButton(BuildContext contex) => Align(
    alignment: const Alignment(1,-0.4),
    child: Observer(
      builder: (context) => IconButton(
        onPressed: () async {
          await controller.baseController.addFavorite(widget.movie, 
            isFavorite);
          // TODO: Check reactivity fail and remove setState
          setState((){});
        },
        icon: Icon(isFavorite 
          ? Entypo.heart : Entypo.heart_outlined, 
          color: isFavorite 
            ? DefaultStyle.currentTheme(context).primary
            : Colors.grey[700]            
        )
      ),
    ),
  );
}