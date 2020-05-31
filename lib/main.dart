import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movpedia/circles_app.dart';
import 'package:movpedia/utilities/logger.dart';
import 'package:movpedia/utilities/movpedia_bloc_delegate.dart';

void main() {
  configureLogger();
  WidgetsFlutterBinding.ensureInitialized();
  BlocSupervisor.delegate = MovpediaBlocDelegate();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  runApp(CirclesApp());
}