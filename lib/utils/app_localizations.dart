import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_devfest/config/config_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppLocalizations {
  static const DEFAULT = ZH;
  static const ZH = 'zh';
  static const EN = 'en';
  static const supportLocales = [
    const Locale('en', 'US'), // English
    const Locale('zh', 'TW'), // Chinese
  ];

  Map get _vocabularies {
    return _localizedValues[ConfigBloc().languageCode] ??
        _localizedValues['zh'];
  }

  String get appName => _vocabularies['app_name'];

  String get english => _vocabularies['english'];

  String get traditionalChinese => _vocabularies['traditionalChinese'];

  String get loading => _vocabularies['loading'];

  String get tryAgain => _vocabularies['tryAgain'];

  String get someError => _vocabularies['someError'];

  String get signInText => _vocabularies['signInText'];

  String get signInGoogleText => _vocabularies['signInGoogleText'];

  String get signOutText => _vocabularies['signOutText'];

  String get wrongText => _vocabularies['wrongText'];

  String get confirmText => _vocabularies['confirmText'];

  String get supportText => _vocabularies['supportText'];

  String get featureText => _vocabularies['featureText'];

  String get moreFeatureText => _vocabularies['moreFeatureText'];

  String get updateNowText => _vocabularies['updateNowText'];

  String get checkNetText => _vocabularies['checkNetText'];

  String get agenda => _vocabularies['agenda'];

  String get speakers => _vocabularies['speakers'];

  String get team => _vocabularies['team'];

  String get sponsor => _vocabularies['sponsor'];

  String get faq => _vocabularies['faq'];

  String get map => _vocabularies['map'];

  String get registration => _vocabularies['registration'];

  String get active => _vocabularies['active'];

  String get comingSoon => _vocabularies['comingSoon'];

  String get minutes => _vocabularies['minutes'];

  String get shareText => _vocabularies['shareText'];

  String get events => _vocabularies['events'];

  String get home => _vocabularies['home'];

  String get navigate => _vocabularies['navigate'];

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  String get localeText {
    switch (ConfigBloc().languageCode) {
      case EN:
        return english;
      case ZH:
      default:
        return traditionalChinese;
    }
  }

  static Map<String, Map<String, String>> _localizedValues = {
    'en': {
      'app_name': 'DevFest APP',
      'english': 'En',
      'traditionalChinese': '中',
      'loading': 'Loading...',
      'tryAgain': 'Try Again',
      'someError': 'Some error',
      'signInText': 'Sign In',
      'signInGoogleText': 'Sign in with google',
      'signOutText': 'Sign Out',
      'wrongText': 'Something went wrong',
      'confirmText': 'Confirm',
      'supportText': 'Support Needed',
      'featureText': 'Feature Request',
      'moreFeatureText': 'More Features coming soon.',
      'updateNowText': 'Please update your app for seamless experience.',
      'checkNetText': 'It seems like your internet connection is not active.',
      //* ActionTexts
      'agenda': 'Agenda',
      'speakers': 'Speakers',
      'team': 'Team',
      'sponsor': 'Sponsors',
      'faq': 'FAQ',
      'map': 'Locate Us',
      'registration': 'Registration',
      'active': 'Active',
      'comingSoon': 'Coming Soon',
      'minutes': 'Mins',
      'shareText':
          'Download the new DevFest App and share with your tech friends.\n'
              'Play Store - https://devfesttw.page.link/android\n'
              'Apple Store - https://devfesttw.page.link/ios',
      'events': 'Events',
      'home': 'Home',
      'navigate': 'Navigate',
    },
    'zh': {
      'app_name': 'DevFest APP',
      'english': 'En',
      'traditionalChinese': '中',
      'loading': '載入中...',
      'tryAgain': '重試',
      'someError': '錯誤',
      'signInText': '登入',
      'signInGoogleText': '以Googgle帳戶登入',
      'signOutText': '登出',
      'wrongText': '發生錯誤',
      'confirmText': '確認',
      'supportText': '支援',
      'featureText': '功能請求',
      'moreFeatureText': '敬請期更多功能.',
      'updateNowText': 'Please update your app for seamless experience.',
      'checkNetText': 'It seems like your internet connection is not active.',
      //* ActionTexts
      'agenda': '議程',
      'speakers': '講者',
      'team': '團隊',
      'sponsor': '贊助',
      'faq': 'FAQ',
      'map': '位置',
      'registration': '報名',
      'active': '進行中',
      'comingSoon': '敬啟\n期待',
      'minutes': '分',
      'shareText': '下載 DevFest App 並分享給您的好朋友\n'
          'https://devfesttw.page.link/download'
      'events': '活動',
      'home': '主畫面',
      'navigate': '導航',
    },
  };
}

class AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => true;

  @override
  Future<AppLocalizations> load(Locale locale) async {
    print('Load ${locale.languageCode}');
    return AppLocalizations();
  }

  @override
  bool shouldReload(AppLocalizationsDelegate old) => false;
}
