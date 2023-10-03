import 'package:amphibians_bloc/bloc/amphibians_bloc.dart';
import 'package:amphibians_bloc/home_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
      ),
      home: BlocProvider(
        create: (context) => AmphibiansBloc()..add(GetAllAmpibiansEvent()),
        child: HomePage(),
      ),
    );
  }
}
