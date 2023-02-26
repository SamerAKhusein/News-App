import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/modules/business/businessScreen.dart';
import 'package:news_app/modules/science/scienceScreen.dart';
import 'package:news_app/modules/sport/sportScreen.dart';
import 'package:news_app/shared/cubit/states.dart';
import 'package:news_app/shared/network/local/CacheHelper.dart';
import 'package:news_app/shared/network/remote/dio_helper.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialStates());

  static AppCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<BottomNavigationBarItem> bottomItem = [
    const BottomNavigationBarItem(
      icon: Icon(
        Icons.business,
      ),
      label: 'Business',
    ),
    const BottomNavigationBarItem(
      icon: Icon(
        Icons.sports,
      ),
      label: 'Sports',
    ),
    const BottomNavigationBarItem(
      icon: Icon(
        Icons.science,
      ),
      label: 'Science',
    ),
  ];

  List<Widget> screens =
  [
    const BusinessScreen(),
    const SportsScreen(),
    const ScienceScreen(),

  ];

  void changeBottomNavBar(int index) {
    currentIndex = index;
    if (index == 1) {
      getSports();
    } else if (index == 2) {
      getScience();
    }
    emit(AppBottomNavState());
  }

  List<dynamic> business = [];

  void getBusiness() {
    emit(AppGetBusinessLoadingState());
    DioHelper.getData
      (
      url: 'v2/top-headlines',
      query:
      {
        'country': 'eg',
        'category': 'business',
        'apiKey': '65f7f556ec76449fa7dc7c0069f040ca',
      },
    ).then((value) {
      business = value?.data['articles'];
      emit(AppGetBusinessSuccessState());
    }).catchError((onError) {
      emit(AppGetBusinessErrorState(onError.toString()));
    });
  }

  List<dynamic> science = [];

  void getScience() {
    emit(AppGetScienceLoadingState());
    DioHelper.getData
      (
      url: 'v2/top-headlines',
      query:
      {
        'country': 'eg',
        'category': 'science',
        'apiKey': '65f7f556ec76449fa7dc7c0069f040ca',
      },
    ).then((value) {
      science = value?.data['articles'];
      emit(AppGetScienceSuccessState());
    }).catchError((onError) {
      emit(AppGetScienceErrorState(onError.toString()));
    });
  }

  List<dynamic> sports = [];

  void getSports() {
    emit(AppGetSportsLoadingState());

    DioHelper.getData
      (
      url: 'v2/top-headlines',
      query:
      {
        'country': 'eg',
        'category': 'sports',
        'apiKey': '65f7f556ec76449fa7dc7c0069f040ca',

      },
    ).then((value) {
      sports = value?.data['articles'];
      emit(AppGetSportsSuccessState());
    }).catchError((onError) {
      emit(AppGetSportsErrorState(onError.toString()));
    });
  }

  List<dynamic> search = [];

  void getSearch(String value) {
    emit(AppGetSearchLoadingState());

    DioHelper.getData
      (
      url: 'v2/everything',
      query:
      {
        'q': '$value',
        'apiKey': '65f7f556ec76449fa7dc7c0069f040ca',

      },
    ).then((value) {
      search = value?.data['articles'];
      emit(AppGetSearchSuccessState());
    }).catchError((onError) {
      emit(AppGetSearchErrorState(onError.toString()));
    });
  }


  bool isDark = false;

  void changeAppMode({bool? formShared}) {
    if (formShared != null) {
      isDark = formShared;
      emit(AppChangeModeStateD());
    } else {
      isDark = !isDark;
      CacheHelper.putData(key: 'isDark', value: isDark).then((value) {
        emit(AppChangeModeStateD());
      });
    }
  }
}