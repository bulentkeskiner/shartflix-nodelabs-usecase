import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shartflix/features/discover/presentation/pages/discover_page.dart';
import 'package:shartflix/features/main_navigation/presentation/cubit/main_nav_cubit.dart';
import 'package:shartflix/features/profile/presentation/pages/profile_page.dart';
import 'package:shartflix/support/app_lang.dart';

class MainNavigationPage extends StatefulWidget {
  const MainNavigationPage({super.key});

  @override
  State<MainNavigationPage> createState() => _MainNavigationPageState();
}

class _MainNavigationPageState extends State<MainNavigationPage> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainNavCubit, int>(
      builder: (context, index) {
        return Scaffold(
          backgroundColor: Colors.black,
          body: IndexedStack(index: index, children: [DiscoverPage(), ProfilePage()]),
          bottomNavigationBar: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.black.withValues(alpha: 0.8), Colors.black],
              ),
            ),
            child: BottomNavigationBar(
              currentIndex: index,
              onTap: (index) {
                context.read<MainNavCubit>().changeTab(index);
              },
              backgroundColor: Colors.transparent,
              selectedItemColor: Colors.white,
              unselectedItemColor: Colors.grey[400],
              selectedFontSize: 14,
              unselectedFontSize: 12,
              type: BottomNavigationBarType.fixed,
              elevation: 0,
              items: [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home_outlined),
                  activeIcon: Icon(Icons.home),
                  label: lang(LocaleKeys.home),
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person_outline),
                  activeIcon: Icon(Icons.person),
                  label: lang(LocaleKeys.profile),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
