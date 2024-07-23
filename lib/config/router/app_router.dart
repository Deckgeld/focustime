import 'package:focustime/presentation/screen/screens.dart';
import 'package:go_router/go_router.dart';

final appRouter = GoRouter(initialLocation: '/', routes: [
  ShellRoute(
      builder: (context, state, child) {
        return HomeScreen(childView: child);
      },
      routes: [
        GoRoute(
            path: '/',
            builder: (context, state) {
              return const LockProfileView();
            }),
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
        GoRoute(
          path: '/newprofile',
          builder: (context, state) {
            return const NewProfileScreen();
          },
          routes: [
            GoRoute(
              path: ':id',
              builder: (context, state) {
                final id = state.pathParameters['id'] ?? 'no-id';
                return NewProfileScreenWrapper(id: id);
              },
            )
          ],
        ),
      ])
]);
