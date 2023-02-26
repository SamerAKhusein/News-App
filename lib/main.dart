// @dart=2.9

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:news_app/layout/home_layout.dart';
import 'package:news_app/shared/Bloc_Observer.dart';
import 'package:news_app/shared/cubit/cubit.dart';
import 'package:news_app/shared/cubit/states.dart';
import 'package:news_app/shared/network/local/CacheHelper.dart';
import 'package:news_app/shared/network/remote/dio_helper.dart';
import 'package:news_app/shared/styles/themes.dart';

void main() async
{
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();
  bool isDark  = CacheHelper.getData(key: 'isDark');
  runApp( MyApp(isDark));
}

class MyApp extends StatelessWidget {

  final bool isDark;
  const MyApp(this.isDark);


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppCubit()..getBusiness() ,
      child: BlocConsumer<AppCubit,AppStates>(
          listener:(context, state) => {} ,
          builder: (context, state)
          {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: lightTheme,
              darkTheme: darkTheme,
              themeMode:
              AppCubit.get(context).isDark ? ThemeMode.dark : ThemeMode.light,
              home: HomeLayout(),
            );
          }
      ),
    );
  }
}