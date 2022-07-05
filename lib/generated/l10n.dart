// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Home`
  String get naviHome {
    return Intl.message(
      'Home',
      name: 'naviHome',
      desc: '',
      args: [],
    );
  }

  /// `Cart`
  String get naviCart {
    return Intl.message(
      'Cart',
      name: 'naviCart',
      desc: '',
      args: [],
    );
  }

  /// `Member`
  String get naviMember {
    return Intl.message(
      'Member',
      name: 'naviMember',
      desc: '',
      args: [],
    );
  }

  /// `Discount`
  String get itemDiscount {
    return Intl.message(
      'Discount',
      name: 'itemDiscount',
      desc: '',
      args: [],
    );
  }

  /// `Preference`
  String get itemPreference {
    return Intl.message(
      'Preference',
      name: 'itemPreference',
      desc: '',
      args: [],
    );
  }

  /// `Boutique`
  String get itemBoutique {
    return Intl.message(
      'Boutique',
      name: 'itemBoutique',
      desc: '',
      args: [],
    );
  }

  /// `Import`
  String get itemImport {
    return Intl.message(
      'Import',
      name: 'itemImport',
      desc: '',
      args: [],
    );
  }

  /// `tell me what you want please.`
  String get hintSearch {
    return Intl.message(
      'tell me what you want please.',
      name: 'hintSearch',
      desc: '',
      args: [],
    );
  }

  /// `No more`
  String get hintListNoMore {
    return Intl.message(
      'No more',
      name: 'hintListNoMore',
      desc: '',
      args: [],
    );
  }

  /// `Success`
  String get netWorkSuccess {
    return Intl.message(
      'Success',
      name: 'netWorkSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Request cancel`
  String get netWorkCancel {
    return Intl.message(
      'Request cancel',
      name: 'netWorkCancel',
      desc: '',
      args: [],
    );
  }

  /// `Connection Timeout`
  String get netWorkConnectionTimeOut {
    return Intl.message(
      'Connection Timeout',
      name: 'netWorkConnectionTimeOut',
      desc: '',
      args: [],
    );
  }

  /// `Send Timeout`
  String get netWorkSendTimeOut {
    return Intl.message(
      'Send Timeout',
      name: 'netWorkSendTimeOut',
      desc: '',
      args: [],
    );
  }

  /// `Receive Timeout`
  String get netWorkReceiveTimeout {
    return Intl.message(
      'Receive Timeout',
      name: 'netWorkReceiveTimeout',
      desc: '',
      args: [],
    );
  }

  /// `Grammatical Error`
  String get netWorkGrammaticalError {
    return Intl.message(
      'Grammatical Error',
      name: 'netWorkGrammaticalError',
      desc: '',
      args: [],
    );
  }

  /// `Permission Denied`
  String get netWorkPermissionDenied {
    return Intl.message(
      'Permission Denied',
      name: 'netWorkPermissionDenied',
      desc: '',
      args: [],
    );
  }

  /// `Server Rejects`
  String get netWorkServerRejects {
    return Intl.message(
      'Server Rejects',
      name: 'netWorkServerRejects',
      desc: '',
      args: [],
    );
  }

  /// `Connection Error`
  String get netWorkConnectionError {
    return Intl.message(
      'Connection Error',
      name: 'netWorkConnectionError',
      desc: '',
      args: [],
    );
  }

  /// `Method Not Allow`
  String get netWorkMethodNotAllow {
    return Intl.message(
      'Method Not Allow',
      name: 'netWorkMethodNotAllow',
      desc: '',
      args: [],
    );
  }

  /// `Server Error`
  String get netWorkServerError {
    return Intl.message(
      'Server Error',
      name: 'netWorkServerError',
      desc: '',
      args: [],
    );
  }

  /// `Invalid Request`
  String get netWorkInvalidRequest {
    return Intl.message(
      'Invalid Request',
      name: 'netWorkInvalidRequest',
      desc: '',
      args: [],
    );
  }

  /// `Unsupported Request`
  String get netWorkUnsupportedRequest {
    return Intl.message(
      'Unsupported Request',
      name: 'netWorkUnsupportedRequest',
      desc: '',
      args: [],
    );
  }

  /// `Unknown Error`
  String get netWorkUnknownError {
    return Intl.message(
      'Unknown Error',
      name: 'netWorkUnknownError',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
