import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/modules/search/search_screen.dart';
import 'package:news_app/shared/components/components.dart';
import 'package:news_app/shared/cubit/cubit.dart';
import 'package:news_app/shared/cubit/states.dart';



class HomeLayout extends StatelessWidget {
  const HomeLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
      listener: (context, state) => {},
      builder: (context, state) => Scaffold(
          appBar: AppBar(
            title: const Text(
                'News App'
            ),
            actions:
            [
              IconButton(
                  onPressed: ()
                  {
                    navigaTo(context, SearchScreen());
                  },
                  icon: const Icon(
                    Icons.search,
                  ),
              ),
              IconButton(
                onPressed: ()
                {
                  AppCubit.get(context).changeAppMode();

                },
                icon: const Icon(
                  Icons.brightness_4_outlined,
                ),
              ),
            ],
          ),
          body: AppCubit.get(context).screens[AppCubit.get(context).currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: AppCubit.get(context).currentIndex ,
              onTap: (index)
              {
                AppCubit.get(context).changeBottomNavBar(index);
              },
              items: AppCubit.get(context).bottomItem,
          ),
        ),
    );
  }
}
