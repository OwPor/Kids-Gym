import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'theme/app_theme.dart';
import 'router/router.dart';
import 'providers/providers.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const ProviderScope(child: PlaySpaceApp()));
}

class PlaySpaceApp extends ConsumerWidget {
  const PlaySpaceApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);
    final darkMode = ref.watch(darkModeProvider);

    return MaterialApp.router(
      title: 'PlaySpace',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: darkMode ? ThemeMode.dark : ThemeMode.light,
      themeAnimationDuration: const Duration(milliseconds: 250),
      themeAnimationCurve: Curves.easeInOut,
      routerConfig: router,
      scrollBehavior: const NoGlowBehavior(),
    );
  }
}

/// Disables the Android overscroll glow/stretch for a flat native feel.
class NoGlowBehavior extends ScrollBehavior {
  const NoGlowBehavior();

  @override
  Widget buildOverscrollIndicator(BuildContext context, Widget child, ScrollableDetails details) => child;
}
