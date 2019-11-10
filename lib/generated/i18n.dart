import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: camel_case_types
// ignore_for_file: prefer_single_quotes
// ignore_for_file: unnecessary_brace_in_string_interps

//WARNING: This file is automatically generated. DO NOT EDIT, all your changes would be lost.

typedef LocaleChangeCallback = void Function(Locale locale);

class I18n implements WidgetsLocalizations {
  const I18n();
  static Locale _locale;
  static bool _shouldReload = false;

  static set locale(Locale newLocale) {
    _shouldReload = true;
    I18n._locale = newLocale;
  }

  static const GeneratedLocalizationsDelegate delegate = GeneratedLocalizationsDelegate();

  /// function to be invoked when changing the language
  static LocaleChangeCallback onLocaleChanged;

  static I18n of(BuildContext context) =>
    Localizations.of<I18n>(context, WidgetsLocalizations);

  @override
  TextDirection get textDirection => TextDirection.ltr;

  /// "Footbal System"
  String get appName => "Footbal System";
  /// "Buon giorno ${name}"
  String greetTo(String name) => "Buon giorno ${name}";
  /// "LOGIN"
  String get login => "LOGIN";
  /// "LOGOUT"
  String get logout => "LOGOUT";
  /// "Passqord dimenticata?"
  String get forgotPassword => "Passqord dimenticata?";
  /// "PASSWORD"
  String get password => "PASSWORD";
  /// "EMAIL"
  String get email => "EMAIL";
  /// "RIPETI PASSWORD"
  String get ripetiPassword => "RIPETI PASSWORD";
  /// "SALVA"
  String get salva => "SALVA";
  /// "Le password non corrispondono"
  String get passwordDifferent => "Le password non corrispondono";
  /// "AVANTI"
  String get avanti => "AVANTI";
  /// "INDIETRO"
  String get indietro => "INDIETRO";
  /// "Generi"
  String get genders => "Generi";
  /// "Seleziona genere"
  String get selectGender => "Seleziona genere";
  /// "Campionati"
  String get championships => "Campionati";
  /// "Seleziona campionato"
  String get selectChampionship => "Seleziona campionato";
  /// "Incontri"
  String get matches => "Incontri";
  /// "Seleziona incontro"
  String get selectMatch => "Seleziona incontro";
  /// "Trofei"
  String get trophies => "Trofei";
  /// "Categorie"
  String get categories => "Categorie";
  /// "Seleziona categoria"
  String get selectCategory => "Seleziona categoria";
  /// "Squadre"
  String get teams => "Squadre";
  /// "Seleziona squadra"
  String get selectTeam => "Seleziona squadra";
  /// "Inserimento incontro"
  String get inserimentoIncontro => "Inserimento incontro";
  /// "Inserisci incontro"
  String get inserisciIncontro => "Inserisci incontro";
  /// "Modifica incontro"
  String get modificaIncontro => "Modifica incontro";
  /// "Inserisci formazione tipo"
  String get inserisciFormazioneTipo => "Inserisci formazione tipo";
  /// "Questo campo non può essere vuoto."
  String get obbligatorio => "Questo campo non può essere vuoto.";
}

class _I18n_it_IT extends I18n {
  const _I18n_it_IT();

  @override
  TextDirection get textDirection => TextDirection.ltr;
}

class GeneratedLocalizationsDelegate extends LocalizationsDelegate<WidgetsLocalizations> {
  const GeneratedLocalizationsDelegate();
  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale("it", "IT")
    ];
  }

  LocaleResolutionCallback resolution({Locale fallback}) {
    return (Locale locale, Iterable<Locale> supported) {
      if (isSupported(locale)) {
        return locale;
      }
      final Locale fallbackLocale = fallback ?? supported.first;
      return fallbackLocale;
    };
  }

  @override
  Future<WidgetsLocalizations> load(Locale locale) {
    I18n._locale ??= locale;
    I18n._shouldReload = false;
    final String lang = I18n._locale != null ? I18n._locale.toString() : "";
    final String languageCode = I18n._locale != null ? I18n._locale.languageCode : "";
    if ("it_IT" == lang) {
      return SynchronousFuture<WidgetsLocalizations>(const _I18n_it_IT());
    }
    else if ("it" == languageCode) {
      return SynchronousFuture<WidgetsLocalizations>(const _I18n_it_IT());
    }

    return SynchronousFuture<WidgetsLocalizations>(const I18n());
  }

  @override
  bool isSupported(Locale locale) {
    for (var i = 0; i < supportedLocales.length && locale != null; i++) {
      final l = supportedLocales[i];
      if (l.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }

  @override
  bool shouldReload(GeneratedLocalizationsDelegate old) => I18n._shouldReload;
}