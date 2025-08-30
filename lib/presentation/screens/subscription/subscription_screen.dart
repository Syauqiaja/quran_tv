import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:quran_tv/core/utils/route_wrapper.dart';

class SubscriptionScreen extends StatefulWidget {
  const SubscriptionScreen({super.key});

  @override
  State<SubscriptionScreen> createState() => _SubscriptionScreenState();
}

class _SubscriptionScreenState extends State<SubscriptionScreen> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
final class SubscriptionRoute extends RouteWrapper {
  SubscriptionRoute()
    : super(builder: _builder, name: routeName, path: '/subscription');

  static String get routeName => "subscription";

  static go(BuildContext context) => context.goNamed(routeName);

  static push(BuildContext context) => context.pushNamed(routeName);

  static Widget _builder(BuildContext context, GoRouterState state) {
    return SubscriptionScreen();
  }
}
