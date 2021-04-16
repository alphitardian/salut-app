import 'package:firebase_core/firebase_core.dart';
import 'common.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GKJ Salut App',
      debugShowCheckedModeBanner: false,
      initialRoute: StartScreenRoute,
      onGenerateRoute: generateRoute,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      theme: ThemeData.light().copyWith(
        accentColor: secondaryColor,
      ),
    );
  }
}
