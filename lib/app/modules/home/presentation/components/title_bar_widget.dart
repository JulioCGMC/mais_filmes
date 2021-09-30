import 'package:flutter/material.dart';

class TitleBarWidget extends StatefulWidget {
  final String title;
  const TitleBarWidget({ Key? key, required this.title }) : super(key: key);

  @override
  _TitleBarWidgetState createState() => _TitleBarWidgetState();
}

class _TitleBarWidgetState extends State<TitleBarWidget> {
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    EdgeInsets padding = MediaQuery.of(context).padding;
    return Padding(
      padding: EdgeInsets.only(
        top: (0.03 * screenSize.height)+padding.top, 
        left: 0.04 * screenSize.width, 
        right: 0.04 * screenSize.width,
        bottom: 10
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _title(context)
        ],
      )  
    );
  }

  Widget _title(BuildContext context) => Text(
    widget.title, 
    style: Theme.of(context).textTheme.headline5,
    textAlign: TextAlign.left,
  );
}