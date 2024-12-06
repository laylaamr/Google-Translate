import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:googletranslate/buisness_logic_layer/translaotion_cubit.dart';
import 'package:googletranslate/data/api/translation_api.dart';
import 'package:googletranslate/data/repositry/translation_repositry.dart';
import 'package:googletranslate/presentation/CustomSplashScreen.dart';
import 'package:googletranslate/presentation/SelectLanguageScreen.dart';
import 'package:googletranslate/presentation/TranslationScreen.dart';

class AppRouting {
  Route? onGenereteRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (_) => const CustomSplashScreen(),
        );
      case 'select':
        return MaterialPageRoute(
          builder: (_) => const SelectLanguageScreen(),
        );
      case 'translate':
        final argument = settings.arguments as Map<String, String?>;
        final translateLanguage = argument['translateLanguage'];
        return MaterialPageRoute(
          builder: (context) => BlocProvider<TranslationCubit>(
            create: (context) =>
                TranslationCubit(TranslationRepository(TranslationApi(Dio()))),
            child: Translationscreen(
             translateLanguage: translateLanguage,
            ),
          ),
        );
      default:
        return null;
    }
  }
}



