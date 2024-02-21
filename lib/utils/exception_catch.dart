import 'dart:io';

import 'package:flutter/material.dart';
import 'package:my_chat_app/pages/widgets/customsnackbar.dart';
import 'package:my_chat_app/utils/error_handling.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ExceptionCatch {
  late BuildContext context;
  static Future<ErrorHandlerResponse<T>> catchErrors<T>(
      Future<T> Function() function, BuildContext context) async {
    try {
      final result = await function.call();
      return ErrorHandlerResponse(result: result);
    } catch (err) {
      final String errorMessage;
      errorMessage = err.toString();
      if (err is PostgrestException) {
        ErrorHandling.handlePostgresError(err, context);
      } else if (err is SocketException) {
        const ErrorSnackBar(message: "Problème de connexion.").show(context);
      } else {
        const ErrorSnackBar(message: "Erreur non gérée.").show(context);
      }

      return ErrorHandlerResponse<T>(error: errorMessage);
    }
  }
}

class ErrorHandlerResponse<T> {
  final String? error;
  final T? result;

  ErrorHandlerResponse({this.error, this.result});

  bool get isError => error != null;
}
