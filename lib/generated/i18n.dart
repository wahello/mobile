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
  /// "Password dimenticata?"
  String get forgotPassword => "Password dimenticata?";
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
  /// "Genere: "
  String get gender => "Genere: ";
  /// "Generi"
  String get genders => "Generi";
  /// "Seleziona genere"
  String get selectGender => "Seleziona genere";
  /// "Campionato: "
  String get championship => "Campionato: ";
  /// "Campionati"
  String get championships => "Campionati";
  /// "Seleziona campionato"
  String get selectChampionship => "Seleziona campionato";
  /// "Incontro: "
  String get match => "Incontro: ";
  /// "Incontri"
  String get matches => "Incontri";
  /// "Seleziona incontro"
  String get selectMatch => "Seleziona incontro";
  /// "Trofeo: "
  String get trophy => "Trofeo: ";
  /// "Trofei"
  String get trophies => "Trofei";
  /// "Categoria: "
  String get category => "Categoria: ";
  /// "Categorie"
  String get categories => "Categorie";
  /// "Seleziona categoria"
  String get selectCategory => "Seleziona categoria";
  /// "Squadra: "
  String get team => "Squadra: ";
  /// "Squadre"
  String get teams => "Squadre";
  /// "Seleziona squadra"
  String get selectTeam => "Seleziona squadra";
  /// "Giocatore: "
  String get player => "Giocatore: ";
  /// "Giocatori"
  String get players => "Giocatori";
  /// "Seleziona giocatore"
  String get selectPlayer => "Seleziona giocatore";
  /// "Allenatore: "
  String get coach => "Allenatore: ";
  /// "Allenatori"
  String get coaches => "Allenatori";
  /// "Seleziona allenatore"
  String get selectCoach => "Seleziona allenatore";
  /// "Inserimento incontro"
  String get inserimentoIncontro => "Inserimento incontro";
  /// "Inserisci incontro"
  String get inserisciIncontro => "Inserisci incontro";
  /// "Incontro inserito"
  String get incontroInserito => "Incontro inserito";
  /// "Modifica incontro"
  String get modificaIncontro => "Modifica incontro";
  /// "Inserisci formazione tipo"
  String get inserisciFormazioneTipo => "Inserisci formazione tipo";
  /// "Questo campo non può essere vuoto."
  String get obbligatorio => "Questo campo non può essere vuoto.";
  /// "Torna alla home"
  String get homePage => "Torna alla home";
  /// "Aggiungi giocatori"
  String get newPlayers => "Aggiungi giocatori";
  /// "Aggiungi squadra"
  String get newTeam => "Aggiungi squadra";
  /// "Aggiungi allenatore"
  String get newCoach => "Aggiungi allenatore";
  /// "Moduli"
  String get modules => "Moduli";
  /// "L'inserimento è andato a buon fine"
  String get inserimentoCorretto => "L'inserimento è andato a buon fine";
  /// "Qualcosa è andato storto"
  String get erroreGenerico => "Qualcosa è andato storto";
  /// "Nome ${name}"
  String nameWithAttribute(String name) => "Nome ${name}";
  /// "Nome"
  String get nome => "Nome";
  /// "Anno"
  String get anno => "Anno";
  /// "Numero"
  String get numero => "Numero";
}

class _I18n_it_IT extends I18n {
  const _I18n_it_IT();

  @override
  TextDirection get textDirection => TextDirection.ltr;
}

class _I18n_en_US extends I18n {
  const _I18n_en_US();

  /// "Footbal System"
  @override
  String get appName => "Footbal System";
  /// "Good morning ${name}"
  @override
  String greetTo(String name) => "Good morning ${name}";
  /// "LOGIN"
  @override
  String get login => "LOGIN";
  /// "LOGOUT"
  @override
  String get logout => "LOGOUT";
  /// "Forgot password?"
  @override
  String get forgotPassword => "Forgot password?";
  /// "PASSWORD"
  @override
  String get password => "PASSWORD";
  /// "EMAIL"
  @override
  String get email => "EMAIL";
  /// "REPEAT PASSWORD"
  @override
  String get ripetiPassword => "REPEAT PASSWORD";
  /// "SAVE"
  @override
  String get salva => "SAVE";
  /// "Password does not match"
  @override
  String get passwordDifferent => "Password does not match";
  /// "NEXT"
  @override
  String get avanti => "NEXT";
  /// "BACK"
  @override
  String get indietro => "BACK";
  /// "Gender: "
  @override
  String get gender => "Gender: ";
  /// "Genders"
  @override
  String get genders => "Genders";
  /// "Select genere"
  @override
  String get selectGender => "Select genere";
  /// "Championship: "
  @override
  String get championship => "Championship: ";
  /// "Championships"
  @override
  String get championships => "Championships";
  /// "Select championship"
  @override
  String get selectChampionship => "Select championship";
  /// "Match: "
  @override
  String get match => "Match: ";
  /// "Matches"
  @override
  String get matches => "Matches";
  /// "Select match"
  @override
  String get selectMatch => "Select match";
  /// "Trophy: "
  @override
  String get trophy => "Trophy: ";
  /// "Trophies"
  @override
  String get trophies => "Trophies";
  /// "Category: "
  @override
  String get category => "Category: ";
  /// "Categories"
  @override
  String get categories => "Categories";
  /// "Select category"
  @override
  String get selectCategory => "Select category";
  /// "Team: "
  @override
  String get team => "Team: ";
  /// "Teams"
  @override
  String get teams => "Teams";
  /// "Select team"
  @override
  String get selectTeam => "Select team";
  /// "Player: "
  @override
  String get player => "Player: ";
  /// "Players"
  @override
  String get players => "Players";
  /// "Select player"
  @override
  String get selectPlayer => "Select player";
  /// "Coach: "
  @override
  String get coach => "Coach: ";
  /// "Coaches"
  @override
  String get coaches => "Coaches";
  /// "Select coach"
  @override
  String get selectCoach => "Select coach";
  /// "Insert match"
  @override
  String get inserimentoIncontro => "Insert match";
  /// "Insert match"
  @override
  String get inserisciIncontro => "Insert match";
  /// "Match inserted"
  @override
  String get incontroInserito => "Match inserted";
  /// "Edit match"
  @override
  String get modificaIncontro => "Edit match";
  /// "Add lineup"
  @override
  String get inserisciFormazioneTipo => "Add lineup";
  /// "This field cannot be empty."
  @override
  String get obbligatorio => "This field cannot be empty.";
  /// "Back home"
  @override
  String get homePage => "Back home";
  /// "Add player"
  @override
  String get newPlayers => "Add player";
  /// "Add team"
  @override
  String get newTeam => "Add team";
  /// "Add coach"
  @override
  String get newCoach => "Add coach";
  /// "Modules"
  @override
  String get modules => "Modules";
  /// "Insert successful"
  @override
  String get inserimentoCorretto => "Insert successful";
  /// "Something wrong"
  @override
  String get erroreGenerico => "Something wrong";
  /// "Name ${name}"
  @override
  String nameWithAttribute(String name) => "Name ${name}";
  /// "Name"
  @override
  String get nome => "Name";
  /// "Year"
  @override
  String get anno => "Year";
  /// "Number"
  @override
  String get numero => "Number";

  @override
  TextDirection get textDirection => TextDirection.ltr;
}

class GeneratedLocalizationsDelegate extends LocalizationsDelegate<WidgetsLocalizations> {
  const GeneratedLocalizationsDelegate();
  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale("it", "IT"),
      Locale("en", "US")
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
    else if ("en_US" == lang) {
      return SynchronousFuture<WidgetsLocalizations>(const _I18n_en_US());
    }
    else if ("it" == languageCode) {
      return SynchronousFuture<WidgetsLocalizations>(const _I18n_it_IT());
    }
    else if ("en" == languageCode) {
      return SynchronousFuture<WidgetsLocalizations>(const _I18n_en_US());
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