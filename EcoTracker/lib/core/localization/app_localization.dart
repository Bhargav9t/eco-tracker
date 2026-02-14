import 'package:flutter/material.dart';

class AppLocalization {
  static final AppLocalization _instance = AppLocalization._internal();
  factory AppLocalization() => _instance;
  AppLocalization._internal();

  final ValueNotifier<Locale> currentLocale = ValueNotifier(Locale('en'));

  void setLocale(String languageCode) {
    currentLocale.value = Locale(languageCode);
  }

  String translate(String key) {
    return _localizedValues[currentLocale.value.languageCode]?[key] ?? key;
  }

  static const Map<String, Map<String, String>> _localizedValues = {
    'en': {
      'app_title': 'Eco-Tracker',
      'login': 'Login',
      'logout': 'Log Out',
      'username': 'Username',
      'password': 'Password',
      'dashboard': 'Home',
      'guide': 'Guide',
      'awards': 'Awards',
      'rank': 'Rank',
      'settings': 'Settings',
      'dark_mode': 'Dark Mode',
      'notifications': 'Notifications',
      'language': 'Language',
      'help_center': 'Help Center',
      'about': 'About',
      'impact': 'Your Impact',
      'recent_actions': 'Recent Actions',
      'log_action': 'Log Action',
      'co2_saved': 'CO2 Saved',
      'streak': 'Streak',
    },
    'es': {
      'app_title': 'Eco-Rastreador',
      'login': 'Iniciar Sesión',
      'logout': 'Cerrar Sesión',
      'username': 'Usuario',
      'password': 'Contraseña',
      'dashboard': 'Inicio',
      'guide': 'Guía',
      'awards': 'Logros',
      'rank': 'Rango',
      'settings': 'Ajustes',
      'dark_mode': 'Modo Oscuro',
      'notifications': 'Notificaciones',
      'language': 'Idioma',
      'help_center': 'Ayuda',
      'about': 'Acerca de',
      'impact': 'Tu Impacto',
      'recent_actions': 'Acciones Recientes',
      'log_action': 'Registrar',
      'co2_saved': 'CO2 Ahorrado',
      'streak': 'Racha',
    },
    'fr': {
      'app_title': 'Éco-Suivi',
      'login': 'Connexion',
      'logout': 'Déconnexion',
      'username': 'Nom d\'utilisateur',
      'password': 'Mot de passe',
      'dashboard': 'Accueil',
      'guide': 'Guide',
      'awards': 'Prix',
      'rank': 'Rang',
      'settings': 'Paramètres',
      'dark_mode': 'Mode Sombre',
      'notifications': 'Notifications',
      'language': 'Langue',
      'help_center': 'Centre d\'aide',
      'about': 'À propos',
      'impact': 'Votre Impact',
      'recent_actions': 'Actions Récents',
      'log_action': 'Enregistrer',
      'co2_saved': 'CO2 Économisé',
      'streak': 'Série',
    },
  };
}
