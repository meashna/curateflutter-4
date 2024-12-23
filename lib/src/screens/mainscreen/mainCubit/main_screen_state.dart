part of 'main_screen_cubit.dart';

@immutable
abstract class MainScreenState {}


class MainScreenSelectedIndex extends MainScreenState {
  int index=2;


  MainScreenSelectedIndex(int selectedIndex){

    index=selectedIndex;
  }

}

