import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:focustime/config/theme/app_theme.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'theme_providers.g.dart';

final colorListProvider = StateProvider((ref) => colorList);

@riverpod
class Theme extends _$Theme {
  
  @override
  AppTheme build() => AppTheme();

  void changeColor(int index) {
    state = state.copyWith(selectColor: index);
  }

  void changeTheme() {
    state = state.copyWith(isDarkMode: !state.isDarkMode);
  }
}