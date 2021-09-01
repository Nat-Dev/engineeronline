import 'package:engineeronline/screens/authen.dart';
import 'package:engineeronline/screens/contents/architecture.dart';
import 'package:engineeronline/screens/contents/codeofpractice.dart';
import 'package:engineeronline/screens/contents/contact.dart';
import 'package:engineeronline/screens/contents/contract.dart';
import 'package:engineeronline/screens/contents/ethics.dart';
import 'package:engineeronline/screens/contents/general/engineer_vocab.dart';
import 'package:engineeronline/screens/contents/general/solar_cell.dart';
import 'package:engineeronline/screens/contents/general/structure_work.dart';
import 'package:engineeronline/screens/contents/general/system_work.dart';
import 'package:engineeronline/screens/contents/legislation.dart';
import 'package:engineeronline/screens/contents/materials.dart';
import 'package:engineeronline/screens/contents/standard.dart';
import 'package:engineeronline/screens/contents/structure.dart';
import 'package:engineeronline/screens/contents/system.dart';
import 'package:engineeronline/screens/contents/technique/column_work.dart';
import 'package:engineeronline/screens/contents/technique/concrete_work.dart';
import 'package:engineeronline/screens/contents/technique/floor_work.dart';
import 'package:engineeronline/screens/contents/technique/piling_work.dart';
import 'package:engineeronline/screens/contents/technique/precast_work.dart';
import 'package:engineeronline/screens/contents/technique/reinforcing_steel.dart';
import 'package:engineeronline/screens/contents/technique/retaining_wall.dart';
import 'package:engineeronline/screens/contents/technique/scaffolding.dart';
import 'package:engineeronline/screens/contents/technique/shallow_foundation.dart';
import 'package:engineeronline/screens/contents/technique/soil_work.dart';
import 'package:engineeronline/screens/contents/technique/steel_construction.dart';
import 'package:engineeronline/screens/home.dart';
import 'package:engineeronline/screens/home_signedin.dart';
import 'package:engineeronline/screens/register.dart';
import 'package:engineeronline/screens/topics/general_topics.dart';
import 'package:engineeronline/screens/topics/technique_topics.dart';
import 'package:engineeronline/screens/verify.dart';
import 'package:flutter/material.dart';

final Map<String, WidgetBuilder> routes = {
  '/home': (BuildContext context) => Home(),
  '/home_signedin': (BuildContext context) => HomeSignedIn(),
  '/authen': (BuildContext context) => Authen(),
  '/register': (BuildContext context) => Register(),
  '/verify': (BuildContext context) => VerifyScreen(),
  // technique
  '/technique_topics': (BuildContext context) => TechniqueTopics(),
  '/piling_work': (BuildContext context) => PilingWork(),
  '/retaining_wall': (BuildContext context) => RetainingWall(),
  '/soil_work': (BuildContext context) => SoilWork(),
  '/shallow_foundation': (BuildContext context) => ShallowFoundation(),
  '/concrete_work': (BuildContext context) => ConcreteWork(),
  '/reinforcing_steel': (BuildContext context) => ReinforcingSteel(),
  '/steel_construction': (BuildContext context) => SteelConstruction(),
  '/floor_work': (BuildContext context) => FloorWork(),
  '/precast_work': (BuildContext context) => PrecastWork(),
  '/column_work': (BuildContext context) => ColumnWork(),
  '/scaffolding': (BuildContext context) => Scaffolding(),
  // general
  '/general_topics': (BuildContext context) => GeneralTopics(),
  '/engineer_vocab': (BuildContext context) => EngineerVocab(),
  '/structure_work': (BuildContext context) => StructureWork(),
  '/system_work': (BuildContext context) => SystemWork(),
  '/solar_cell': (BuildContext context) => SolarCell(),
  // others
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
};
