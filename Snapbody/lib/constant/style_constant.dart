// ignore_for_file: non_constant_identifier_names, constant_identifier_names

import 'package:flutter/material.dart';

const Color BACKGROUND_COLOR = Colors.white;

const Color SCREEN_COLOR = Color(0xFFF9F9F9);
const Color ICON_BACKGROUND_COLOR = Color(0xFFDADADA);


const Color HOME_BACKGROUND_COLOR = Color.fromARGB(255, 245, 245, 245);

const Color PRIMARY_COLOR = Color(0xFFFF3115);
const Color PRIMARY_DARK_COLOR = Color(0xFFCB0000);
const Color PRIMARY_LIGHT_COLOR = Color(0xFFFFA38D);
const Color SECONDARY_COLOR = Color(0xFFFFC627);
const Color SECONDARY_DARK_COLOR = Color(0xFFFC7717);
const Color SECONDARY_LIGHT_COLOR = Color(0xFFFFE288);
const Color TRETIARY_COLOR = Color(0xFF1D5EFF);
const Color TRETIARY_DARK_COLOR = Color(0xFF0000C0);
const Color TRETIARY_LIGHT_COLOR = Color(0xFF94A1FE);
const Color ACCENT_COLOR = Color(0xFF690E03);
const Color DARK_COLOR = Color(0xFF3C3C3C);
const Color ICON_COLOR = Color(0xFFC4C4C4);

ThemeData SNAPBODY_THEME = ThemeData(
  primarySwatch: Colors.blue,
  fontFamily: 'Pretendard',
  textTheme: const TextTheme(
    //타이틀(Title 1)
    headline1: TextStyle(
      fontSize: 22,
      fontWeight: FontWeight.w900,
      color: Color(0xFF222222),
    ),
    //타이틀(Title 2)
    headline2: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w700,
      color: Color(0xFF222222),
    ),
    //타이틀(Title 3)
    headline3: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w500,
      color: Color(0xFF222222),
    ),
    //본문(Body 1)
    bodyText1: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      color: Color(0xFF3D3D3D),
    ),
    //본문(Body 2)
    bodyText2: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: Color(0xFF3D3D3D),
    ),
    //서브텍스트(info_sub)
    caption: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w300,
      color: Color(0xFF818181),
    ),
  ),
);
