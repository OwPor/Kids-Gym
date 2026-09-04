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

final routerProvider = Provider<GoRouter>((ref) {
  final isAuth = ref.watch(isAuthenticatedProvider);

  return GoRouter(
    initialLocation: '/',
    redirect: (context, state) {
      final public = state.matchedLocation;
      final isPublicRoute = public == '/' || public == '/login' || public == '/signup' || public == '/onboarding';

      if (!isAuth && !isPublicRoute) return '/login';
      if (isAuth && !isPublicRoute && public != '/home') return '/home';
      return null;
    },
    routes: [
      GoRoute(path: '/', builder: (_, __) => const SplashScreen()),
      GoRoute(path: '/onboarding', builder: (_, __) => const OnboardingScreen()),
      GoRoute(path: '/login', builder: (_, __) => const LoginScreen()),
      GoRoute(path: '/signup', builder: (_, __) => const SignupScreen()),
      ShellRoute(builder: (_, __, child) => MainScaffold(child: child), routes: [
        GoRoute(path: '/home', builder: (_, __) => const HomeScreen()),
        GoRoute(path: '/booking', builder: (_, __) => const BookingScreen()),
        GoRoute(path: '/checkin', builder: (_, __) => const CheckInScreen()),
        GoRoute(path: '/children', builder: (_, __) => const ChildrenScreen()),
        GoRoute(path: '/settings', builder: (_, __) => const SettingsScreen()),
      ]),
      GoRoute(path: '/waiver', builder: (_, __) => const WaiverScreen()),
      GoRoute(path: '/membership', builder: (_, __) => const MembershipScreen()),
    ],
  );
});
