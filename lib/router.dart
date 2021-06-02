import 'package:engineeronline/screens/contents/architecture.dart';
import 'package:engineeronline/screens/contents/codeofpractice.dart';
import 'package:engineeronline/screens/contents/contact.dart';
import 'package:engineeronline/screens/contents/contract.dart';
import 'package:engineeronline/screens/contents/ethics.dart';
import 'package:engineeronline/screens/contents/general.dart';
import 'package:engineeronline/screens/contents/legislation.dart';
import 'package:engineeronline/screens/contents/materials.dart';
import 'package:engineeronline/screens/contents/standard.dart';
import 'package:engineeronline/screens/contents/structure.dart';
import 'package:engineeronline/screens/contents/system.dart';
import 'package:engineeronline/screens/contents/technique.dart';
import 'package:engineeronline/screens/home.dart';
import 'package:engineeronline/screens/home_signedin.dart';
import 'package:engineeronline/screens/posts/general_post.dart';
import 'package:engineeronline/screens/posts/technique_post.dart';
import 'package:engineeronline/screens/register.dart';
import 'package:flutter/material.dart';

final Map<String, WidgetBuilder> routes = {
  '/home': (BuildContext context) => Home(),
  '/home_signedin': (BuildContext context) => HomeSignedIn(),
  '/register': (BuildContext context) => Register(),
  '/general': (BuildContext context) => General(),
  '/technique': (BuildContext context) => Technique(),
  '/contact': (BuildContext context) => Contact(),
  '/structure': (BuildContext context) => Structure(),
  '/architecture': (BuildContext context) => Architecture(),
  '/system': (BuildContext context) => System(),
  '/legislation': (BuildContext context) => Legislation(),
  '/standard': (BuildContext context) => Standard(),
  '/contract': (BuildContext context) => Contract(),
  '/materials': (BuildContext context) => Materials(),
  '/code_of_practice': (BuildContext context) => CodeOfPractice(),
  '/ethics': (BuildContext context) => Ethics(),
  '/general_post': (BuildContext context) => GeneralPost(),
  '/technique_post': (BuildContext context) => TechniquePost()
};
