import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:flutter/material.dart';

class ErrorHandling {
  static void handleError(dynamic error, BuildContext context) {
    String message;
    String statusCode;

    if (error is AuthException) {
      statusCode = error.statusCode!;
    } else if (error is PostgrestException) {
      statusCode = error.code!;
    } else {
      message = "Une erreur inattendue est survenue. Veuillez réessayer.";
      ErrorSnackBar(message: message).show(context);
      return;
    }

    // Traitement des codes d'état connus
    switch (int.parse(statusCode)) {
      case 400:
        message = "Invalid login credentials. Veuillez vérifier vos données.";
        break;
      case 401:
        message = "Session expirée. Veuillez vous reconnecter.";
        break;
      case 403:
        message = "Vous n'avez pas les droits nécessaires pour cette action.";
        break;
      case 404:
        message = "L'élément demandé n'a pas été trouvé. Vérifiez l'entrée.";
        break;
      case 500:
        message = "Problème de serveur. Essayez de nouveau un peu plus tard.";
        break;
      default:
        message = "Veuillez vérifier votre connexion internet.";
        break;
    }

    ErrorSnackBar(message: message).show(context);
  }
}

class ErrorSnackBar extends StatelessWidget {
  final String message;

  const ErrorSnackBar({Key? key, required this.message}) : super(key: key);

  void show(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        duration: Duration(seconds: 4),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Ce widget ne sert que de porteur pour la méthode show, donc il ne construit rien.
    return Container();
  }
}
