import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../providers/providers.dart';
import '../screens/splash_screen.dart';
import '../screens/onboarding_screen.dart';
import '../screens/login_screen.dart';
import '../screens/signup_screen.dart';
import '../screens/main_scaffold.dart';
import '../screens/home_screen.dart';
import '../screens/booking_screen.dart';
import '../screens/checkin_screen.dart';
import '../screens/children_screen.dart';
import '../screens/settings_screen.dart';
import '../screens/waiver_screen.dart';
import '../screens/membership_screen.dart';

CustomTransitionPage<void> _slideUpModal(Widget child, GoRouterState state) {
  return CustomTransitionPage<void>(
    key: state.pageKey,
    child: child,
    transitionsBuilder: (ctx, animation, second, child) {
      return SlideTransition(
        position: Tween(begin: const Offset(0, 1), end: Offset.zero).animate(animation),
        child: FadeTransition(opacity: animation, child: child),
      );
    },
  );
}

CustomTransitionPage<void> _slideRight(Widget child, GoRouterState state) {
  return CustomTransitionPage<void>(
    key: state.pageKey,
    child: child,
    transitionsBuilder: (ctx, animation, second, child) {
      return SlideTransition(
        position: Tween(begin: const Offset(0.12, 0), end: Offset.zero).animate(animation),
        child: FadeTransition(opacity: animation, child: child),
      );
    },
  );
}

final routerProvider = Provider<GoRouter>((ref) {
  final isAuth = ref.watch(isAuthenticatedProvider);

  return GoRouter(
    initialLocation: '/',
    redirect: (context, state) {
      final loc = state.matchedLocation;
      final isPublicRoute = loc == '/' || loc == '/login' || loc == '/signup' || loc == '/onboarding';

      if (!isAuth && !isPublicRoute) return '/login';
      if (isAuth && (loc == '/login' || loc == '/signup' || loc == '/onboarding')) return '/home';
      return null;
    },
    routes: [
      GoRoute(path: '/', builder: (_, _) => const SplashScreen()),
      GoRoute(path: '/onboarding', builder: (_, _) => const OnboardingScreen()),
      GoRoute(path: '/login', builder: (_, _) => const LoginScreen()),
      GoRoute(path: '/signup', pageBuilder: (_, s) => _slideRight(const SignupScreen(), s)),
      ShellRoute(
        builder: (_, _, child) => MainScaffold(child: child),
        routes: [
          GoRoute(path: '/home', pageBuilder: (_, s) => NoTransitionPage(child: const HomeScreen())),
          GoRoute(path: '/booking', pageBuilder: (_, s) => NoTransitionPage(child: const BookingScreen())),
          GoRoute(path: '/checkin', pageBuilder: (_, s) => NoTransitionPage(child: const CheckInScreen())),
          GoRoute(path: '/children', pageBuilder: (_, s) => NoTransitionPage(child: const ChildrenScreen())),
          GoRoute(path: '/settings', pageBuilder: (_, s) => NoTransitionPage(child: const SettingsScreen())),
        ],
      ),
      GoRoute(path: '/waiver', pageBuilder: (_, s) => _slideUpModal(const WaiverScreen(), s)),
      GoRoute(path: '/membership', pageBuilder: (_, s) => _slideUpModal(const MembershipScreen(), s)),
    ],
  );
});
