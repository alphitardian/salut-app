import 'package:google_fonts/google_fonts.dart';
import 'package:salut_app_flutter/common.dart';
import 'package:salut_app_flutter/services/auth_services.dart';

class AdminLoginScreen extends StatefulWidget {
  @override
  _AdminLoginScreenState createState() => _AdminLoginScreenState();
}

class _AdminLoginScreenState extends State<AdminLoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();

  bool obscure = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.appName,
          style: kAppBarrTextStyle,
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back),
          color: Colors.black,
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Container(
          width: kIsWeb
              ? MediaQuery.of(context).size.width / 3
              : MediaQuery.of(context).size.width * (90 / 100),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
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
                      text: AppLocalizations.of(context)!.fors,
                      style: TextStyle(
                        fontSize: 32,
                      ),
                    ),
                    TextSpan(
                      text: AppLocalizations.of(context)!.localeName == 'id'
                          ? '\n' +
                              AppLocalizations.of(context)!.admin +
                              ' ' +
                              AppLocalizations.of(context)!.only
                          : '\n' +
                              AppLocalizations.of(context)!.admin +
                              ' \n' +
                              AppLocalizations.of(context)!.only,
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(),
                  ],
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * (15 / 100),
              ),
              TextField(
                decoration: InputDecoration(
                  labelText: AppLocalizations.of(context)!.email,
                  prefixIcon: Icon(
                    Icons.mail,
                    color: secondaryColor,
                  ),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: secondaryColor)),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: secondaryColor)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: secondaryColor)),
                  labelStyle: TextStyle(color: secondaryDarkColor),
                ),
                controller: emailController,
                cursorColor: secondaryDarkColor,
              ),
              SizedBox(
                height: 10,
              ),
              TextField(
                decoration: InputDecoration(
                  labelText: AppLocalizations.of(context)!.password,
                  prefixIcon: Icon(
                    Icons.lock,
                    color: secondaryColor,
                  ),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: secondaryColor)),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: secondaryColor)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: secondaryColor)),
                  labelStyle: TextStyle(color: secondaryDarkColor),
                  suffixIcon: IconButton(
                    icon: Icon(
                      Icons.remove_red_eye,
                      color: secondaryDarkColor,
                    ),
                    onPressed: () {
                      setState(() {
                        obscure = !obscure;
                      });
                    },
                  ),
                ),
                cursorColor: secondaryDarkColor,
                controller: passController,
                obscureText: obscure,
              ),
              SizedBox(
                height: 16,
              ),
              Text(
                AppLocalizations.of(context)!.loginInformation,
                style: kInfoTextStyle,
                textAlign: TextAlign.center,
              ),
              Spacer(),
              LoginButton(
                emailController: emailController,
                passController: passController,
              ),
            ],
          ),
        ),
      ),
      backgroundColor: Colors.white,
    );
  }
}

class LoginButton extends StatelessWidget {
  const LoginButton({
    Key? key,
    required this.emailController,
    required this.passController,
  }) : super(key: key);

  final TextEditingController emailController;
  final TextEditingController passController;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 36),
      width: MediaQuery.of(context).size.width,
      child: ElevatedButton(
        onPressed: () async {
          if (await AuthServices.signInUser(
              emailController.text.trim(), passController.text.trim())) {
            showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text(AppLocalizations.of(context)!.loginSuccess),
                    actions: [
                      TextButton(
                        child: Text(
                          AppLocalizations.of(context)!.okButton,
                          style: TextStyle(
                            color: secondaryColor,
                          ),
                        ),
                        onPressed: () {
                          Navigator.pushNamed(context, AdminMainScreenRoute);
                        },
                      )
                    ],
                  );
                });
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                width: kIsWeb
                    ? MediaQuery.of(context).size.width / 3
                    : MediaQuery.of(context).size.width * (90 / 100),
                content: Text(AppLocalizations.of(context)!.loginFailed),
                behavior: SnackBarBehavior.floating,
              ),
            );
          }
        },
        child: Text(AppLocalizations.of(context)!.loginButton),
        style: kElevatedButtonStyle,
      ),
    );
  }
}
