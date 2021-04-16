import 'package:salut_app_flutter/common.dart';
import 'package:salut_app_flutter/models/jemaat_model.dart';
import 'package:salut_app_flutter/services/database_services.dart';
import 'package:share/share.dart';

class JemaatDetailScreen extends StatefulWidget {
  final Jemaat args;

  JemaatDetailScreen({Key? key, required this.args});

  @override
  _JemaatDetailScreenState createState() => _JemaatDetailScreenState();
}

class _JemaatDetailScreenState extends State<JemaatDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (widget.args.admin == true) {
          Navigator.popUntil(
              context,
              (route) =>
                  route.settings.name! ==
                  AdminMainScreenRoute + JemaatDataListScreenRoute);
        } else if (widget.args.admin == false) {
          Navigator.popUntil(
              context,
              (route) =>
                  route.settings.name! ==
                  JemaatMainScreenRoute + JemaatDataListScreenRoute);
        }

        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            '${widget.args.name}',
            style: kAppBarrTextStyle,
          ),
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            onPressed: () => Navigator.of(context).pop(),
          ),
          actions: [
            widget.args.admin
                ? IconButton(
                    onPressed: () {
                      DatabaseJemaatServices.deleteData(widget.args.id);
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.delete,
                      color: Colors.black,
                    ))
                : IconButton(
                    onPressed: () {
                      Share.share(
                          "Kontak Jemaat : \nNama: ${widget.args.name}\nNo. HP: ${widget.args.phone}");
                    },
                    icon: Icon(
                      Icons.share,
                      color: Colors.black,
                    ),
                  ),
          ],
          elevation: 0,
          backgroundColor: Colors.white,
        ),
        backgroundColor: Colors.white,
        body: Padding(
          padding: kIsWeb
              ? EdgeInsets.symmetric(horizontal: 128)
              : EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(AppLocalizations.of(context)!.jemaatAge),
              Text(
                (DateTime.now()
                            .difference(DateTime.parse(widget.args.birthDate))
                            .inDays /
                        365)
                    .round()
                    .toString(),
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 15,
              ),
              Text(AppLocalizations.of(context)!.jemaatBirth),
              Text(
                widget.args.birthDate.toString(),
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Text(AppLocalizations.of(context)!.jemaatJob),
              Text(
                widget.args.job.toString(),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Text(AppLocalizations.of(context)!.jemaatPhone),
              Text(
                widget.args.phone.toString(),
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Spacer(),
              widget.args.admin
                  ? Container(
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.only(bottom: 16),
                      child: OutlinedButton(
                          onPressed: () {
                            Navigator.pushNamed(
                                context,
                                AdminMainScreenRoute +
                                    AdminAddJemaatScreenRoute,
                                arguments: Jemaat(
                                    widget.args.id,
                                    widget.args.name,
                                    widget.args.job,
                                    widget.args.phone,
                                    widget.args.birthDate,
                                    true));
                          },
                          style: kElevatedButtonStyle,
                          child:
                              Text(AppLocalizations.of(context)!.updateButton)),
                    )
                  : SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}
