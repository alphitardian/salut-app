import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:salut_app_flutter/common.dart';
import 'package:salut_app_flutter/models/renungan_model.dart';
import 'package:salut_app_flutter/services/auth_services.dart';
import 'package:salut_app_flutter/services/database_services.dart';

class AdminRenunganDataScreen extends StatefulWidget {
  @override
  _AdminRenunganDataScreenState createState() =>
      _AdminRenunganDataScreenState();
}

class _AdminRenunganDataScreenState extends State<AdminRenunganDataScreen> {
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
          AppLocalizations.of(context)!.renunganData,
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('renungan')
            .orderBy('tanggal', descending: true)
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
                          RenunganDataListScreenRoute +
                          '/${e.id}',
                      arguments: Renungan(
                          e.id,
                          e.data()['judul'],
                          e.data()['isi'],
                          e.data()['tanggal'],
                          e.data()['gambar'],
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
                            AdminMainScreenRoute + AdminAddRenunganScreenRoute,
                            arguments: Renungan(
                                e.id,
                                e.data()['judul'],
                                e.data()['isi'],
                                e.data()['tanggal'],
                                e.data()['gambar'],
                                true));
                      },
                    ),
                    IconSlideAction(
                      caption: AppLocalizations.of(context)!.deleteButton,
                      color: Colors.red,
                      icon: Icons.delete,
                      onTap: () {
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
                                      DatabaseRenunganServices.deleteData(e.id);
                                    },
                                  )
                                ],
                              );
                            });
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
                                e.data()['judul'],
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              subtitle: Text(
                                  e.data()['tanggal'].toString().split(' ')[0]),
                            ),
                          ),
                        )
                      : Card(
                          margin: EdgeInsets.all(8),
                          child: ListTile(
                            title: Text(
                              e.data()['judul'],
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text(
                                e.data()['tanggal'].toString().split(' ')[0]),
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
