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
      GoRoute(path: '/', builder: (_, _) => const SplashScreen()),
      GoRoute(path: '/onboarding', builder: (_, _) => const OnboardingScreen()),
      GoRoute(path: '/login', builder: (_, _) => const LoginScreen()),
      GoRoute(path: '/signup', builder: (_, _) => const SignupScreen()),
      ShellRoute(builder: (_, _, child) => MainScaffold(child: child), routes: [
        GoRoute(path: '/home', builder: (_, _) => const HomeScreen()),
        GoRoute(path: '/booking', builder: (_, _) => const BookingScreen()),
        GoRoute(path: '/checkin', builder: (_, _) => const CheckInScreen()),
        GoRoute(path: '/children', builder: (_, _) => const ChildrenScreen()),
        GoRoute(path: '/settings', builder: (_, _) => const SettingsScreen()),
      ]),
      GoRoute(path: '/waiver', builder: (_, _) => const WaiverScreen()),
      GoRoute(path: '/membership', builder: (_, _) => const MembershipScreen()),
    ],
  );
});
