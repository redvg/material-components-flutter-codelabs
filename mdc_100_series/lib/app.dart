// Copyright 2018-present the Flutter authors. All Rights Reserved.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import 'package:flutter/material.dart';
import 'supplemental/cut_corners_border.dart';

import 'home.dart';
import 'login.dart';
import 'colors.dart';
import 'backdrop.dart';

import 'model/product.dart';

  TextTheme _buildTextTheme(TextTheme themeBase) {

    return themeBase.copyWith(
        
        headline: themeBase.headline.copyWith(
        
          fontWeight: FontWeight.w500,
      ),
      
        title: themeBase.title.copyWith(
        
          fontSize: 18.0
      ),
      
        caption: themeBase.caption.copyWith(
        
          fontWeight: FontWeight.w400,
        
          fontSize: 14.0,
      ),
    ).apply(
        
        fontFamily: 'Rubik',
        
        displayColor: kShrineBrown900,
        
        bodyColor: kShrineBrown900,
    );
}

  ThemeData _buildTheme() {

    final ThemeData themeBase = ThemeData.light();

    return themeBase.copyWith(

      accentColor: kShrineBrown900,
      
      primaryColor: kShrinePink100,
      
      buttonColor: kShrinePink100,
      
      scaffoldBackgroundColor: kShrineBackgroundWhite,
      
      cardColor: kShrineBackgroundWhite,
      
      textSelectionColor: kShrinePink100,
      
      errorColor: kShrineErrorRed,

      textTheme: _buildTextTheme(themeBase.textTheme),

      primaryTextTheme: _buildTextTheme(themeBase.primaryTextTheme),

      accentTextTheme: _buildTextTheme(themeBase.accentTextTheme),

      primaryIconTheme: themeBase.iconTheme.copyWith(

        color: kShrineBrown900,
      ),

      inputDecorationTheme: InputDecorationTheme(
          
          border: CutCornersBorder(),)
    );
  }

class ShrineApp extends StatelessWidget {

  final ThemeData _kCustomTheme = _buildTheme();

  @override
  Widget build(BuildContext context) {
    
    return MaterialApp(
      
      title: 'Shrine',
      
      home: Backdrop(

        category: Category.all,

        frontTitle: Text('Shrine'),

        frontLayer: HomePage(),

        backTitle: Text('Menu'),

        backLayer: Container(

          color: kShrinePink100,
        ),
      ),
      
      initialRoute: '/login',
      
      onGenerateRoute: _getRoute,

      theme: _kCustomTheme,
    );
  }

  Route<dynamic> _getRoute(RouteSettings settings) {
    if (settings.name != '/login') {
      return null;
    }

    return MaterialPageRoute<void>(
      settings: settings,
      builder: (BuildContext context) => LoginPage(),
      fullscreenDialog: true,
    );
  }
}
