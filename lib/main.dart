import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'route_names.dart';

void main() {
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'WEB_ROUTER_DOM',
      navigatorKey: locator<NavigationService>().navigatorKey,
      onGenerateRoute: generateRoute,
      initialRoute: "/",
    );
  }
}

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => NavigationService());
}

class NavigationService {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  Future<dynamic> navigateTo(String routeName,
      {Map<String, String> queryParams}) {
    if (queryParams != null) {
      routeName = Uri(path: routeName, queryParameters: queryParams).toString();
    }
    return navigatorKey.currentState.pushNamed(routeName);
  }

  bool goBack() {
    return navigatorKey.currentState.canPop();
  }
}

class RoutingData {
  final String route;
  final Map<String, String> _queryParameters;

  RoutingData({this.route, Map<String, String> queryParameters})
      : _queryParameters = queryParameters;

  operator [](String key) => _queryParameters[key];
}

extension StringExtension on String {
  RoutingData get getRoutingData {
    var uriData = Uri.parse(this);
    print('queryParameters: ${uriData.queryParameters} path: ${uriData.path}');
    return RoutingData(
      queryParameters: uriData.queryParameters,
      route: uriData.path,
    );
  }
}

Route<dynamic> generateRoute(RouteSettings settings) {
  var routingData = settings.name.getRoutingData;
  switch (routingData.route) {
    case "/":
      return _getPageRoute(HomePage(), settings);
    case "/about":
      return _getPageRoute(AboutPage(), settings);
    default:
      return _getPageRoute(Notfound(), settings);
  }
}

PageRoute _getPageRoute(Widget child, RouteSettings settings) {
  return _FadeRoute(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          actions: [
            TextButton(
                onPressed: () {
                  locator<NavigationService>().navigateTo("/about");
                },
                child: Text(
                  'About',
                )),
            TextButton(
              onPressed: () {
                locator<NavigationService>().navigateTo("/");
              },
              child: Text('Home'),
            ),
          ],
          title: Text(
            'App Bar',
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: child,
      ),
      routeName: settings.name);
}

class _FadeRoute extends PageRouteBuilder {
  final Widget child;
  final String routeName;
  _FadeRoute({this.child, this.routeName})
      : super(
          settings: RouteSettings(name: routeName),
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              child,
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) =>
              FadeTransition(
            opacity: animation,
            child: child,
          ),
        );
}
