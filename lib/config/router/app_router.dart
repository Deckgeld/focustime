import 'package:focustime/presentation/screen/settings_screen.dart';
import 'package:focustime/presentation/views/fastlock_view.dart';
import 'package:focustime/presentation/screen/home_screen.dart';
import 'package:focustime/presentation/views/lockprofile_view.dart';
import 'package:go_router/go_router.dart';

final appRouter = GoRouter(
  initialLocation: '/', 
  routes: [
    ShellRoute(
      builder: (context, state, child) {
        return HomeScreen(childView: child);
      },
      routes: [
        GoRoute(
            path: '/',
            builder: (context, state) {
              return const LockProfileView();
            }
          ),
        GoRoute(
          path: '/fastlock',
          builder: (context, state) {
            return const FastLockView();
          },
        ),
        GoRoute(
          path: '/settings',
          builder: (context, state) {
            return const SettingsScreen();
          },
        ),
        
      ])
]);