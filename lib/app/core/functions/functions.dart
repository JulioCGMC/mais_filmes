import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:crypto/crypto.dart';

/// Verifica se tem conexão com a internet
Future<bool> hasConnection() async {
  bool retorno;
  try {
    final result = await InternetAddress.lookup('google.com')
      .timeout(const Duration(seconds: 8), onTimeout: () => []);
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      retorno = true;
    } else {
      retorno = false;
    }
  } on SocketException catch (_) {
    retorno = false;
  }
  return retorno;
}

/// Pega um valor aleatório entre um máximo e minimo
int randomBetween(num max, [num min = 0]) {
  final Random _random = Random();
  return min.round() + _random.nextInt(max.round() - min.round());
}

/// Formata a data [`dateTime`] recebida e retorna de acordo com o formato [`format`] desejado,
/// `format` aceita os seguintes parâmetros:
/// d = dia, m = mês, y = ano, w = dia da semana, h = horas, i = minutos, s = segundos
String datetimeToString(dynamic dateTime, {String format = "d/m/y"}) {
  String response = "";
  if (dateTime != null) {
    if (dateTime !is DateTime) {
      if (dateTime is String) {
        if (dateTime.contains("/")) {
          dateTime = dateTime.split(" ")[0].split("/").reversed.join("-");
        }
        else if (DateTime.tryParse(dateTime) != null) {
          dateTime = DateTime.parse(dateTime);
        }
      }
      else if (dateTime !is num) {
        dateTime = dateTime.toDate();
      }
    }
    if (dateTime is DateTime) {
      response = format;
      response = response.replaceAll("d", dateTime.day.toString().padLeft(2, '0'))
        .replaceAll("m", dateTime.month.toString().padLeft(2, '0'))
        .replaceAll("y", dateTime.year.toString().padLeft(4, '0'))
        .replaceAll("h", dateTime.hour.toString().padLeft(2, '0'))
        .replaceAll("i", dateTime.minute.toString().padLeft(2, '0'))
      .replaceAll("s", dateTime.second.toString().padLeft(2, '0'));
      //   .replaceAll("Z", dateTranslator["month"][dateTime.month-1].substring(0,3))
      //   .replaceAll("z", dateTranslator["month"][dateTime.month-1])
      //   .replaceAll("W", dateTranslator["weekday"][dateTime.weekday-1].substring(0,3))
      // .replaceAll("w", dateTranslator["weekday"][dateTime.weekday-1]);
    }
  }
  return response;
}

String createEmailHash(String email) {
  email = email.trim().toLowerCase();
  return md5.convert(utf8.encode(email)).toString();
}