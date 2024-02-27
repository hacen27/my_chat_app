import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:flutter/material.dart';

import '../pages/widgets/customsnackbar.dart';

class ErrorHandling {
  static void handlePostgresError(dynamic error, BuildContext context) {
    String message;
    String? code;
    if (error is PostgrestException) {
      code = error.code;
      switch (code) {
        case '01000':
          message = "Attention: Un avertissement a été émis.";
          break;
        case '0100C':
          message =
              "Attention: Des ensembles de résultats dynamiques sont retournés.";
          break;

        case '08000':
          message = "Exception de connexion.";
          break;
        case '08003':
          message = "La connexion n'existe pas.";
          break;

        case '0A000':
          message = "Fonctionnalité non prise en charge.";
          break;

        case '21000':
          message = "Violation de cardinalité.";
          break;

        case '23505':
          message = "Violation de contrainte d'intégrité : doublon détecté.";
          break;
        case '40000':
          message = "Retour en arrière de la transaction.";
          break;
        case '40P01':
          message = "Interblocage détecté.";
          break;

        case '42601':
          message = "Erreur de syntaxe.";
          break;
        case '42501':
          message = "Privilège insuffisant.";
          break;

        case '53000':
          message = "Ressources insuffisantes.";
          break;
        case '53100':
          message = "Disque plein.";
          break;

        default:
          message = "Erreur PostgreSQL non gérée: code $code";
          break;
      }

      ErrorSnackBar(message: message).show(context);
    }
  }

  static void signInException(dynamic error, BuildContext context) {
    String message;
    String? statusCode;

    if (error is AuthException) {
      statusCode = error.statusCode;

      switch (statusCode) {
        case '400':
          message = "Invalid login credentials.";
          break;
        case '401':
          message = "Session expirée. Veuillez vous reconnecter.";
          break;
        case '403':
          message = "Vous n'avez pas les droits nécessaires pour cette action.";
          break;
        case '404':
          message = "L'élément demandé n'a pas été trouvé. Vérifiez l'entrée.";
          break;
        case '500':
          message = "Problème de serveur. Essayez de nouveau un peu plus tard.";
          break;
        default:
          message = "Erreur AuthException non gérée: code $statusCode";
          break;
      }

      ErrorSnackBar(message: message).show(context);
    }
  }

  static void signUpException(dynamic error, BuildContext context) {
    String message;
    String? statusCode;

    if (error is AuthException) {
      statusCode = error.statusCode;

      switch (statusCode) {
        case '400':
          message = "L'email est déjà utilisé.";
          break;
        case '401':
          message = "Session expirée. Veuillez vous reconnecter.";
          break;
        case '403':
          message = "Vous n'avez pas les droits nécessaires pour cette action.";
          break;
        case '404':
          message = "L'élément demandé n'a pas été trouvé. Vérifiez l'entrée.";
          break;
        case '500':
          message = "Problème de serveur. Essayez de nouveau un peu plus tard.";
          break;
        default:
          message = "Erreur AuthException non gérée: code $statusCode";
          break;
      }
      ErrorSnackBar(message: message).show(context);
    }
  }
}
