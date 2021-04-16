import 'package:flutter/material.dart';
import 'package:salut_app_flutter/models/jemaat_model.dart';
import 'package:salut_app_flutter/models/pengumuman_model.dart';
import 'package:salut_app_flutter/models/renungan_model.dart';
import 'package:salut_app_flutter/ui/admin_screen/admin_addjemaat_screen.dart';
import 'package:salut_app_flutter/ui/admin_screen/admin_addpengumuman_screen.dart';
import 'package:salut_app_flutter/ui/admin_screen/admin_addrenungan_screen.dart';
import 'package:salut_app_flutter/ui/admin_screen/admin_addwarta_screen.dart';
import 'package:salut_app_flutter/ui/admin_screen/admin_jemaatdata_screen.dart';
import 'package:salut_app_flutter/ui/admin_screen/admin_login_screen.dart';
import 'package:salut_app_flutter/ui/admin_screen/admin_main_screen.dart';
import 'package:salut_app_flutter/ui/admin_screen/admin_renungandata_screen.dart';
import 'package:salut_app_flutter/ui/jemaat_screen/jemaat_jemaatdata_screen.dart';
import 'package:salut_app_flutter/ui/jemaat_screen/jemaat_main_screen.dart';
import 'package:salut_app_flutter/ui/jemaat_screen/jemaat_renungandata_screen.dart';
import 'package:salut_app_flutter/ui/universal_screen/jemaat_detail_screen.dart';
import 'package:salut_app_flutter/ui/universal_screen/pengumuman_detail_screen.dart';
import 'package:salut_app_flutter/ui/universal_screen/renungan_detail_screen.dart';
import 'package:salut_app_flutter/ui/universal_screen/start_screen.dart';
import 'package:salut_app_flutter/ui/universal_screen/wartadata_screen.dart';

Route<dynamic>? generateRoute(RouteSettings settings) {
  var uri = Uri.parse(settings.name!);

  if (settings.name == StartScreenRoute) {
    return MaterialPageRoute(
        builder: (context) => StartScreen(),
        settings: RouteSettings(name: StartScreenRoute));
  }

  if (settings.name == JemaatMainScreenRoute) {
    return MaterialPageRoute(
        builder: (context) => JemaatMainScreen(),
        settings: RouteSettings(name: JemaatMainScreenRoute));
  }

// Jemaat Data
  if (uri.pathSegments.length == 2 &&
      uri.pathSegments[0] == 'jemaat' &&
      uri.pathSegments[1] == 'jemaatdata') {
    return MaterialPageRoute(
        builder: (context) => JemaatJemaatDataScreen(),
        settings: RouteSettings(name: uri.path));
  }
  if (uri.pathSegments.length == 2 &&
      uri.pathSegments[0] == 'admin' &&
      uri.pathSegments[1] == 'jemaatdata') {
    return MaterialPageRoute(
        builder: (context) => AdminJemaatDataScreen(),
        settings: RouteSettings(name: uri.path));
  }

// Jemaat Data Detail Screen
  if (uri.pathSegments.length == 3 && uri.pathSegments[1] == 'jemaatdata') {
    final Jemaat args = settings.arguments as Jemaat;
    return MaterialPageRoute(
        builder: (context) => JemaatDetailScreen(
              args: args,
            ),
        settings: RouteSettings(name: uri.path));
  }

// Renungan Data
  if (uri.pathSegments.length == 2 &&
      uri.pathSegments[0] == 'jemaat' &&
      uri.pathSegments[1] == 'renungan') {
    return MaterialPageRoute(
        builder: (context) => JemaatRenunganDataScreen(),
        settings: RouteSettings(name: uri.path));
  }
  if (uri.pathSegments.length == 2 &&
      uri.pathSegments[0] == 'admin' &&
      uri.pathSegments[1] == 'renungan') {
    return MaterialPageRoute(
        builder: (context) => AdminRenunganDataScreen(),
        settings: RouteSettings(name: uri.path));
  }
  if (uri.pathSegments.length == 3 && uri.pathSegments[1] == 'renungan') {
    final Renungan args = settings.arguments as Renungan;
    return MaterialPageRoute(
        builder: (context) => RenunganDetailScreen(
              args: args,
            ),
        settings: RouteSettings(name: uri.path + '/${args.id}'));
  }

  // Warta Data
  if (settings.name == JemaatMainScreenRoute + '/warta' ||
      settings.name == AdminMainScreenRoute + '/warta') {
    return MaterialPageRoute(
        builder: (context) => WartaJemaatDataScreen(),
        settings: RouteSettings(name: uri.path));
  }

  // Pengumuman Data
  if (uri.pathSegments.length == 3 && uri.pathSegments[1] == 'pengumuman') {
    final Pengumuman args = settings.arguments as Pengumuman;
    return MaterialPageRoute(
        builder: (context) => PengumumanDetailScreen(args: args),
        settings: RouteSettings(name: uri.path));
  }

// Admin
  if (settings.name == AdminLoginScreenRoute) {
    return MaterialPageRoute(
        builder: (context) => AdminLoginScreen(),
        settings: RouteSettings(name: AdminLoginScreenRoute));
  }

  if (settings.name == AdminMainScreenRoute) {
    return MaterialPageRoute(
        builder: (context) => AdminMainScreen(),
        settings: RouteSettings(name: AdminMainScreenRoute));
  }

  if (settings.name == AdminMainScreenRoute + AdminAddJemaatScreenRoute) {
    final Jemaat args = settings.arguments as Jemaat;
    return MaterialPageRoute(
        builder: (context) => AddJemaatScreen(
              args: args,
            ),
        settings: RouteSettings(name: uri.path));
  }

  if (settings.name == AdminMainScreenRoute + AdminAddWartaScreenRoute) {
    return MaterialPageRoute(
        builder: (context) => AddWartaJemaatScreen(),
        settings: RouteSettings(name: uri.path));
  }

  if (settings.name == AdminMainScreenRoute + AdminAddRenunganScreenRoute) {
    final Renungan args = settings.arguments as Renungan;
    return MaterialPageRoute(
        builder: (context) => AddRenunganScreen(
              args: args,
            ),
        settings: RouteSettings(name: uri.path));
  }

  if (settings.name == AdminMainScreenRoute + AdminAddPengumumanScreenRoute) {
    return MaterialPageRoute(
        builder: (context) => AddPengumumanScreen(),
        settings: RouteSettings(name: uri.path));
  }

  return MaterialPageRoute(
      builder: (context) => StartScreen(),
      settings: RouteSettings(name: StartScreenRoute));
}

const String StartScreenRoute = '/';

// Jemaat Screen
const String JemaatMainScreenRoute = '/jemaat';
const String JemaatDataListScreenRoute = '/jemaatdata';
const String RenunganDataListScreenRoute = '/renungan';

// Admin Screen
const String AdminLoginScreenRoute = '/login';
const String AdminMainScreenRoute = '/admin';
const String AdminAddJemaatScreenRoute = '/addjemaat';
const String AdminAddWartaScreenRoute = '/addwarta';
const String AdminAddRenunganScreenRoute = '/addrenungan';
const String AdminAddPengumumanScreenRoute = '/addpengumuman';

// Universal Screen
const String WartaJemaatScreenRoute = '/warta';
const String PengumumanScreenRoute = '/pengumuman';
