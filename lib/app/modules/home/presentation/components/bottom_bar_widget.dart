import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import '../../../../core/constants/default_style.dart';

class BottomBarWidget extends StatelessWidget {
  final int currentIndex;
  final void Function(int, bool)? onTap;

  const BottomBarWidget({Key? key, this.currentIndex = 0, 
    this.onTap}) : super(key: key);
  
  final List<Map<String,dynamic>> items = const [
    {'label': 'Filmes', 'icon': MaterialCommunityIcons.movie_open},
    {'label': 'Favoritos', 'icon': Entypo.heart_outlined}
  ];

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      notchMargin: 7,
      child: SizedBox(
        height: 60,
        child: _itemArrangement(context),
      )
    );
  }

  Widget _itemArrangement(BuildContext context) {
    List<Widget> children = [];
    for (var index = 0; index < items.length; index++) {
      children.add(item(context, items[index]['label'], 
        items[index]['icon'], index));
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: children,
    );
  }

  Widget item(BuildContext context, String text, IconData icon, int index) {
    Color? color;
    if (index == currentIndex) {
      color = DefaultStyle.currentTheme(context).primary;
    }
    return MaterialButton(
      minWidth: 40,
      onPressed: () => onTap!(index, true),
      child: Column(
        children: [
          Container(
            width: 50,
            height: 6,
            color: color ?? Colors.transparent,
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(
                  icon,
                  color: color ?? Colors.grey,
                ),
                Text(
                  text,
                  style: Theme.of(context).textTheme.caption!.apply(
                    color: color ?? Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}