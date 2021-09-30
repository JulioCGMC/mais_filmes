import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class ErrorPage extends StatelessWidget {
  final String message;
  final Widget? button;

  const ErrorPage(this.message,this.button, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).errorColor.withOpacity(0.6),
      child: Center(
        child: Card(
          margin: const EdgeInsets.symmetric(horizontal: 40),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24)
          ),
          child: Padding(
            padding: const EdgeInsets.all(40),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  "Erro!", 
                  style: Theme.of(context).textTheme.headline5,
                  textAlign: TextAlign.center
                ),
                const SizedBox(height: 20),
                Text(message, textAlign: TextAlign.center),
                const SizedBox(height: 20),
                if (button == null) ElevatedButton(
                  child: const Text("Recarregar"),
                  onPressed: () 
                    => Modular.to.navigate(Modular.initialRoute),
                ) else button!
              ],
            ),
          ),
        ),
      )
    );
  }
}