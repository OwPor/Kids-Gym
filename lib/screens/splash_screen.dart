import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../theme/app_theme.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});
  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _scale;
  late Animation<double> _fade;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(duration: const Duration(milliseconds: 1500), vsync: this);
    _scale = Tween(begin: 0.5, end: 1.0).animate(CurvedAnimation(parent: _ctrl, curve: Curves.elasticOut));
    _fade = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(parent: _ctrl, curve: const Interval(0, 0.5, curve: Curves.easeIn)));
    _ctrl.forward();
    Future.delayed(const Duration(seconds: 2), () { if (mounted) context.go('/onboarding'); });
  }

  @override
  void dispose() { _ctrl.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.coral,
      body: Center(
        child: FadeTransition(
          opacity: _fade,
          child: ScaleTransition(
            scale: _scale,
            child: const Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: 120, height: 120,
                  child: DecoratedBox(
                    decoration: BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                    child: Icon(Icons.sports_gymnastics, size: 64, color: AppColors.coral),
                  ),
                ),
                SizedBox(height: 24),
                Text('PlaySpace', style: TextStyle(fontSize: 36, fontWeight: FontWeight.w800, color: Colors.white)),
                SizedBox(height: 8),
                Text('Kids Gym & Play', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.white70)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
