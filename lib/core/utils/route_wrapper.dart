import 'package:go_router/go_router.dart';

abstract class RouteWrapper extends GoRoute {
  RouteWrapper({required super.path, required super.name, required super.builder});
}
