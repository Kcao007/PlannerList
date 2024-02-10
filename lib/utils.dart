import 'package:flutter/material.dart';

buildLoading(BuildContext context) {
  return showDialog(context: context, barrierDismissible: false, builder: (BuildContext context) {
    return const Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(
              Colors.blue
          ),
        )
    );
  });
}

snackBarBuilder(String message, BuildContext context) {
  final snackBar = SnackBar(content: Text(message));
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}