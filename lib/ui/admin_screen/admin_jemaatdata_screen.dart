import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:salut_app_flutter/common.dart';
import 'package:salut_app_flutter/models/jemaat_model.dart';
import 'package:salut_app_flutter/services/auth_services.dart';
import 'package:salut_app_flutter/services/database_services.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
// ignore: uri_does_not_exist
import 'package:salut_app_flutter/services/download_services_mobile.dart'
    // ignore: uri_does_not_exist
    if (dart.library.html) 'package:salut_app_flutter/services/download_services_web.dart';
import 'package:salut_app_flutter/theme.dart';
import 'package:salut_app_flutter/ui/universal_screen/jemaat_search_screen.dart';

class AdminJemaatDataScreen extends StatefulWidget {
  @override
  _AdminJemaatDataScreenState createState() => _AdminJemaatDataScreenState();
}

class _AdminJemaatDataScreenState extends State<AdminJemaatDataScreen> {
  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  Future<void> getCurrentUser() async {
    try {
      if (AuthServices.auth.currentUser != null) {
        User currentUser = AuthServices.auth.currentUser!;
        print(currentUser.email);
      } else {
        Navigator.pushNamed(context, StartScreenRoute);
      }
    } on Exception catch (e) {
      print('user not sign in with exception $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          AppLocalizations.of(context)!.jemaatData,
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => JemaatSearchScreen(
                      admin: true,
                    ),
                  ),
                );
              },
              icon: Icon(
                Icons.search,
                color: Colors.black,
              )),
          kIsWeb
              ? IconButton(
                  onPressed: () {
                    DownloadServices.downloadFile();
                  },
                  icon: Icon(
                    Icons.file_download,
                    color: Colors.black,
                  ))
              : SizedBox(),
        ],
      ),
      backgroundColor: Colors.white,
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('jemaat')
            .orderBy('nama')
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(
                backgroundColor: mainColor,
              ),
            );
          }

          if (snapshot.data!.size == 0) {
            return Center(
              child: Text(
                AppLocalizations.of(context)!.noData,
                style: TextStyle(color: Colors.black),
              ),
            );
          }

          return ListView(
            children: snapshot.data!.docs.map((e) {
              return InkWell(
                onTap: () {
                  Navigator.pushNamed(
                      context,
                      AdminMainScreenRoute +
                          JemaatDataListScreenRoute +
                          '/${e.id}',
                      arguments: Jemaat(
                          e.id,
                          e.data()['nama'],
                          e.data()['pekerjaan'],
                          e.data()['telepon'],
                          e.data()['tanggal lahir'],
                          true));
                },
                child: Slidable(
                  movementDuration: Duration(seconds: 1),
                  actionPane: SlidableStrechActionPane(),
                  actions: [
                    IconSlideAction(
                      caption: AppLocalizations.of(context)!.updateButton,
                      color: Colors.blue,
                      icon: Icons.arrow_circle_up,
                      onTap: () {
                        Navigator.pushNamed(context,
                            AdminMainScreenRoute + AdminAddJemaatScreenRoute,
                            arguments: Jemaat(
                                e.id,
                                e.data()['nama'],
                                e.data()['pekerjaan'],
                                e.data()['telepon'],
                                e.data()['tanggal lahir'],
                                true));
                      },
                    ),
                    IconSlideAction(
                      caption: AppLocalizations.of(context)!.deleteButton,
                      color: Colors.red,
                      icon: Icons.delete,
                      onTap: () {
                        DatabaseJemaatServices.deleteData(e.id);
                      },
                    )
                  ],
                  child: kIsWeb
                      ? Padding(
                          padding: const EdgeInsets.only(left: 65, right: 65),
                          child: Card(
                            margin: EdgeInsets.all(8),
                            child: ListTile(
                              title: Text(
                                e.data()['nama'],
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              subtitle: Text(e.data()['pekerjaan']),
                              trailing: IconButton(
                                onPressed: () {
                                  Navigator.pushNamed(
                                      context,
                                      AdminMainScreenRoute +
                                          AdminAddJemaatScreenRoute,
                                      arguments: Jemaat(
                                          e.id,
                                          e.data()['nama'],
                                          e.data()['pekerjaan'],
                                          e.data()['telepon'],
                                          e.data()['tanggal lahir'],
                                          true));
                                },
                                icon: Icon(Icons.edit),
                              ),
                            ),
                          ),
                        )
                      : Card(
                          margin: EdgeInsets.all(8),
                          child: ListTile(
                            title: Text(
                              e.data()['nama'],
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text(e.data()['pekerjaan']),
                          ),
                        ),
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
