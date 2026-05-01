import 'package:flutter/material.dart';

/// Manages consent state for privacy policy acceptance.
class ConsentProvider extends ChangeNotifier {
  bool _consentAccepted = false;

  bool get consentAccepted => _consentAccepted;

  void acceptConsent() {
    _consentAccepted = true;
    notifyListeners();
  }

  void resetConsent() {
    _consentAccepted = false;
    notifyListeners();
  }
}
