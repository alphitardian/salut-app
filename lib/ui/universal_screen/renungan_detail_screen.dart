import 'package:salut_app_flutter/common.dart';
import 'package:salut_app_flutter/components/custom_appbar.dart';
import 'package:salut_app_flutter/models/renungan_model.dart';
import 'package:salut_app_flutter/services/database_services.dart';
import 'package:share/share.dart';

class RenunganDetailScreen extends StatelessWidget {
  final Renungan args;

  const RenunganDetailScreen({Key? key, required this.args}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(args.title);
    return Scaffold(
      body: kIsWeb
          ? CustomScrollView(
              slivers: [
                CustomSliverAppBar(
                  admin: args.admin,
                  imageUrl: args.imageUrl,
                  title: AppLocalizations.of(context)!.renunganData,
                  function: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text(
                                AppLocalizations.of(context)!.alertWarning),
                            content: Text(AppLocalizations.of(context)!
                                .alertWarningMessageDelete),
                            actions: [
                              TextButton(
                                child: Text(
                                  AppLocalizations.of(context)!.noButton,
                                  style: TextStyle(color: secondaryColor),
                                ),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                              TextButton(
                                child: Text(
                                  AppLocalizations.of(context)!.yesButton,
                                  style: TextStyle(color: secondaryColor),
                                ),
                                onPressed: () {
                                  Navigator.pop(context);
                                  Navigator.popUntil(
                                      context,
                                      (route) => args.admin
                                          ? route.settings.name! ==
                                              AdminMainScreenRoute +
                                                  RenunganDataListScreenRoute
                                          : route.settings.name! ==
                                              JemaatMainScreenRoute +
                                                  RenunganDataListScreenRoute);
                                  DatabaseRenunganServices.deleteData(args.id);
                                },
                              )
                            ],
                          );
                        });
                  },
                ),
                SliverFillRemaining(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 128),
                    child: Column(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.all(12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                args.title,
                                style: TextStyle(
                                    fontSize: 24, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 4,
                              ),
                              Text(
                                args.date.split(' ')[0],
                                style: kInfoTextStyle,
                              ),
                              SizedBox(
                                height: MediaQuery.of(context).size.height *
                                    (3 / 100),
                              ),
                              Text(args.body),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            )
          : CustomScrollView(
              slivers: [
                CustomSliverAppBar(
                  admin: args.admin,
                  imageUrl: args.imageUrl,
                  title: AppLocalizations.of(context)!.renunganData,
                  function: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text(
                                AppLocalizations.of(context)!.alertWarning),
                            content: Text(AppLocalizations.of(context)!
                                .alertWarningMessageDelete),
                            actions: [
                              TextButton(
                                child: Text(
                                  AppLocalizations.of(context)!.noButton,
                                  style: TextStyle(color: secondaryColor),
                                ),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                              TextButton(
                                child: Text(
                                  AppLocalizations.of(context)!.yesButton,
                                  style: TextStyle(color: secondaryColor),
                                ),
                                onPressed: () {
                                  Navigator.pop(context);
                                  Navigator.popUntil(
                                      context,
                                      (route) => args.admin
                                          ? route.settings.name! ==
                                              AdminMainScreenRoute +
                                                  RenunganDataListScreenRoute
                                          : route.settings.name! ==
                                              JemaatMainScreenRoute +
                                                  RenunganDataListScreenRoute);
                                  DatabaseRenunganServices.deleteData(args.id);
                                },
                              )
                            ],
                          );
                        });
                  },
                ),
                SliverFillRemaining(
                  child: Column(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.all(12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              args.title,
                              style: TextStyle(
                                  fontSize: 24, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 4,
                            ),
                            Text(
                              args.date.split(' ')[0],
                              style: kInfoTextStyle,
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height *
                                  (3 / 100),
                            ),
                            Text(args.body),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
      floatingActionButton: args.admin
          ? ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(
                    context, AdminMainScreenRoute + AdminAddRenunganScreenRoute,
                    arguments: Renungan(args.id, args.title, args.body,
                        args.date, args.imageUrl, true));
              },
              child: Container(
                margin: EdgeInsets.all(16),
                child: Icon(Icons.edit),
              ),
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
                primary: secondaryColor,
              ),
            )
          : ElevatedButton(
              onPressed: () {
                Share.share(
                    'RENUNGAN SALUT \n\n${args.title.toUpperCase()} \n\n${args.body}');
              },
              child: Container(
                margin: EdgeInsets.all(16),
                child: Icon(Icons.share),
              ),
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
                primary: secondaryColor,
              ),
            ),
    );
  }
}
