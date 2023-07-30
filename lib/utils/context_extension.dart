import 'package:flutter/material.dart';

extension BuildContextExtension on BuildContext {
  navigateToScreen({bool isReplace = false, required Widget child}) {
    if (isReplace) {
      Navigator.pushReplacement(this, MaterialPageRoute(builder: (_) => child));
    } else {
      Navigator.push(this, MaterialPageRoute(builder: (_) => child));
    }
  }
}
