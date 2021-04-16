import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:salut_app_flutter/ui/admin_screen/admin_login_screen.dart';
import 'package:salut_app_flutter/ui/jemaat_screen/jemaat_main_screen.dart';
import '../../common.dart';

class StartScreen extends StatefulWidget {
  @override
  _StartScreenState createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  Future<bool> exitApp(BuildContext context) async {
    if (Navigator.canPop(context)) {
      SystemNavigator.pop();
      return false;
    } else {
      SystemNavigator.pop();
      return false;
    }
  }

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 2));
    _animation = Tween(begin: 0.0, end: 1.0).animate(_animationController);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _animationController.forward();
    return WillPopScope(
      onWillPop: () => exitApp(context),
      child: MaterialApp(
        title: 'GKJ Salut App',
        debugShowCheckedModeBanner: false,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              AppLocalizations.of(context)!.appName,
              style: kAppBarrTextStyle,
            ),
            elevation: 0.0,
            backgroundColor: Colors.white,
          ),
          body: FadeTransition(
            opacity: _animation,
            child: Center(
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Image.asset(
                      'assets/images/salutapp-logo.png',
                      height: kIsWeb ? 300 : 300,
                    ),
                  ),
                  kIsWeb
                      ? Center(
                          child: Padding(
                            padding:
                                const EdgeInsets.only(left: 16.0, right: 16.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 36,
                                ),
                                RichText(
                                  text: TextSpan(
                                    style: GoogleFonts.montserrat(
                                      color: Colors.black,
                                    ),
                                    children: [
                                      TextSpan(
                                        text: AppLocalizations.of(context)!
                                                .welcome +
                                            "\n",
                                        style: TextStyle(
                                          fontSize: 42,
                                        ),
                                      ),
                                      TextSpan(
                                        text: AppLocalizations.of(context)!.to +
                                            "\n",
                                        style: TextStyle(fontSize: 32),
                                      ),
                                      TextSpan(
                                        text: 'Salatiga Utara\n',
                                        style: TextStyle(
                                          fontSize: 38,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      TextSpan(
                                        text: 'Super App',
                                        style: TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Spacer(),
                                Container(
                                  margin: EdgeInsets.only(bottom: 8),
                                  width: kIsWeb
                                      ? MediaQuery.of(context).size.width / 3
                                      : MediaQuery.of(context).size.width,
                                  child: OutlinedButton(
                                    onPressed: () {
                                      Navigator.pushNamed(
                                          context, AdminLoginScreenRoute);
                                    },
                                    child: Text(
                                        AppLocalizations.of(context)!.admin),
                                    style: kOutlineButtonStyle,
                                  ),
                                ),
                                SizedBox(
                                  height: kIsWeb ? 10.0 : 2.0,
                                ),
                                Container(
                                  margin: EdgeInsets.only(bottom: 36),
                                  width: kIsWeb
                                      ? MediaQuery.of(context).size.width / 3
                                      : MediaQuery.of(context).size.width,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      Navigator.pushNamed(
                                          context, JemaatMainScreenRoute);
                                    },
                                    child: Text(
                                        AppLocalizations.of(context)!.jemaat),
                                    style: kElevatedButtonStyle,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      : Padding(
                          padding:
                              const EdgeInsets.only(left: 16.0, right: 16.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 36,
                              ),
                              RichText(
                                text: TextSpan(
                                  style: GoogleFonts.montserrat(
                                    color: Colors.black,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: AppLocalizations.of(context)!
                                              .welcome +
                                          '\n',
                                      style: TextStyle(
                                        fontSize: 42,
                                      ),
                                    ),
                                    TextSpan(
                                      text: AppLocalizations.of(context)!.to +
                                          '\n',
                                      style: TextStyle(fontSize: 32),
                                    ),
                                    TextSpan(
                                      text: 'Salatiga Utara\n',
                                      style: TextStyle(
                                        fontSize: 38,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    TextSpan(
                                      text: 'Super App',
                                      style: TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Spacer(),
                              Container(
                                margin: EdgeInsets.only(bottom: 8),
                                width: kIsWeb
                                    ? MediaQuery.of(context).size.width / 3
                                    : MediaQuery.of(context).size.width,
                                child: OutlinedButton(
                                  onPressed: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            AdminLoginScreen(),
                                      ),
                                    );
                                  },
                                  child:
                                      Text(AppLocalizations.of(context)!.admin),
                                  style: kOutlineButtonStyle,
                                ),
                              ),
                              SizedBox(
                                height: kIsWeb ? 10.0 : 2.0,
                              ),
                              Container(
                                margin: EdgeInsets.only(bottom: 36),
                                width: kIsWeb
                                    ? MediaQuery.of(context).size.width / 3
                                    : MediaQuery.of(context).size.width,
                                child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            JemaatMainScreen(),
                                      ),
                                    );
                                  },
                                  child: Text(
                                      AppLocalizations.of(context)!.jemaat),
                                  style: kElevatedButtonStyle,
                                ),
                              ),
                            ],
                          ),
                        ),
                ],
              ),
            ),
          ),
          backgroundColor: Colors.white,
        ),
      ),
    );
  }
}
