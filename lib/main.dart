import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:tomato_record/router/locations.dart';
import 'package:tomato_record/screens/agreement_screen.dart';
import 'package:tomato_record/screens/home_screen.dart';
import 'package:tomato_record/screens/start_screen.dart';
import 'package:tomato_record/screens/splash_screen.dart';
import 'package:tomato_record/states/user_notifier.dart';

void main() {
  Provider.debugCheckInvalidValueType = null;
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _initialization,
        builder: (context, snapshot) {
          return AnimatedSwitcher(
              duration: Duration(milliseconds: 300),
              child: _splashLoadingWidget(snapshot));
        });
  }

  StatelessWidget _splashLoadingWidget(AsyncSnapshot<Object?> snapshot) {
    if (snapshot.hasError) {
      print('error occur while loading.');
      return Text('Error occur');
    } else if (snapshot.connectionState == ConnectionState.done) {
      return TomatoApp();
    } else {
      return SplashScreen();
    }
  }
}

class TomatoApp2 extends StatelessWidget {
  const TomatoApp2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.yellow,
    );
  }
}

class TomatoApp extends StatelessWidget {
  // const TomatoApp({Key? key}) : super(key: key);
  final userNotifier = UserNotifier();

  late final GoRouter _router = GoRouter(
    routes: <GoRoute>[
      GoRoute(
          path: '/',
          builder: (BuildContext context, GoRouterState state) =>
              const HomeScreen()),
      GoRoute(
          path: '/page2',
          builder: (BuildContext context, GoRouterState state) =>
              const Page2Screen()),
      GoRoute(
          path: '/start',
          builder: (BuildContext context, GoRouterState state) =>
              StartScreen()),
      GoRoute(
          path: '/agreement',
          builder: (BuildContext context, GoRouterState state) =>
              AgreementScreen())
    ],
    redirect: (state) {
      // if the user is not logged in, they need to login
      final loggedIn = userNotifier.islogin();
      final isaggrement = userNotifier.isaggrement();

//[1] 로그인 안되었으면.
      if (!loggedIn) return state.subloc == '/start' ? null : '/start';
      //[2] 로그인은 했는데 미동의
      if (loggedIn && !isaggrement)
        return state.subloc == '/agreement' ? null : '/agreement';
      //[3] 로그인, 동의 완료.
      if (state.subloc == '/start' || state.subloc == '/agreement') return '/';
      return null;
    },
    refreshListenable: userNotifier,
  );

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<UserNotifier>.value(
      value: userNotifier,
      child: MaterialApp.router(
        theme: ThemeData(
            primarySwatch: Colors.red,
            fontFamily: 'DoHyeon',
            hintColor: Colors.grey[350],
            textTheme: TextTheme(
              button: TextStyle(color: Colors.white),
              subtitle1: TextStyle(color: Colors.black87, fontSize: 15),
              subtitle2: TextStyle(color: Colors.grey, fontSize: 13),
              bodyText1: TextStyle(
                  color: Colors.black87,
                  fontSize: 12,
                  fontWeight: FontWeight.normal),
              bodyText2: TextStyle(
                  color: Colors.black54,
                  fontSize: 12,
                  fontWeight: FontWeight.w100),
            ),
            textButtonTheme: TextButtonThemeData(
                style: TextButton.styleFrom(
                    backgroundColor: Colors.red,
                    primary: Colors.white,
                    minimumSize: Size(48, 48))),
            appBarTheme: AppBarTheme(
                backgroundColor: Colors.white,
                foregroundColor: Colors.black87,
                elevation: 2,
                titleTextStyle: TextStyle(
                  color: Colors.black87,
                ),
                actionsIconTheme: IconThemeData(color: Colors.black87)),
            bottomNavigationBarTheme: BottomNavigationBarThemeData(
                selectedItemColor: Colors.black87,
                unselectedItemColor: Colors.black54)),
        routeInformationParser: _router.routeInformationParser,
        routerDelegate: _router.routerDelegate,
      ),
    );
  }
}

/// The screen of the first page.
class Page1Screen extends StatelessWidget {
  /// Creates a [Page1Screen].
  const Page1Screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ElevatedButton(
                onPressed: () {
                  context.push('/page2');
                  // GoRouter.of(context).go('/page2');
                  //context.go('/page2');
                },
                child: const Text('Go to page 2~'),
              ),
            ],
          ),
        ),
      );
}

/// The screen of the second page.
class Page2Screen extends StatelessWidget {
  /// Creates a [Page2Screen].
  const Page2Screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('App.title')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ElevatedButton(
                onPressed: () {
                  GoRouter.of(context).go('/');
                  // context.go('/');
                },
                child: const Text('Go to home page~'),
              ),
            ],
          ),
        ),
      );
}

class LoginScreen extends StatelessWidget {
  /// Creates a [Page2Screen].
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('App.로그인페이지')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ElevatedButton(
                onPressed: () {
                  GoRouter.of(context).go('/');
                  // context.go('/');
                },
                child: const Text('Go to home page~'),
              ),
            ],
          ),
        ),
      );
}
