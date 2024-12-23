import 'package:flutter/cupertino.dart';

class RouteNavigator {
  // start handeld context
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  static Future<dynamic> navigateTo(String routeName) {
    return navigatorKey.currentState!.pushNamed(routeName);
  }

  static goBack() {
    navigatorKey.currentState!.pop();
  }

  // end handeld context

  static void popAllAndToReStart(BuildContext context) {
    RouteNavigator.popAllAndPushNamedReplacement(context, "/");
  }

  static void popAllAndPushNamedReplacement(
      BuildContext context, String routeName,
      {Object? arguments}) {
    navigatorKey.currentState!.pushNamedAndRemoveUntil(
        routeName, (Route<dynamic> route) => false,
        arguments: arguments);
  }

  static void pushReplacement(
    BuildContext context,
    String routeName, {
    Object? arguments,
  }) {
    navigatorKey.currentState!
        .pushReplacementNamed(routeName, arguments: arguments);
  }

  static void pushNamed(
    BuildContext context,
    String routeName, {
    Object? arguments,
  }) {
    //to avoid doublication route

    if (ModalRoute.of(context)!.settings.name != routeName) {
      navigatorKey.currentState!.pushNamed(routeName, arguments: arguments);
    }
  }

  static void popIfCanPop(BuildContext context) {
    if (navigatorKey.currentState!.canPop()) {
      navigatorKey.currentState!.pop(context);
    }
  }

  static void popAllUntill(BuildContext context, String routeName) {
    Navigator.of(context).popUntil(ModalRoute.withName(routeName));
  }

  static void pop<T extends Object>(BuildContext context, {var v}) {
    Navigator.of(context).pop(v);
  }

  static void pushNamedAndRemoveUntil(
    BuildContext context,
    String pushRouteName,
    String popUntilRouteName, {
    Object? arguments,
  }) {
    navigatorKey.currentState!.pushNamedAndRemoveUntil(
        pushRouteName, ModalRoute.withName(popUntilRouteName),
        arguments: arguments);
  }
}
