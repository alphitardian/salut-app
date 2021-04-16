import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:salut_app_flutter/common.dart';
import 'package:salut_app_flutter/components/admin_card_menu.dart';
import 'package:salut_app_flutter/models/jemaat_model.dart';
import 'package:salut_app_flutter/models/pengumuman_model.dart';
import 'package:salut_app_flutter/models/renungan_model.dart';
import 'package:salut_app_flutter/services/auth_services.dart';

class AdminMainScreen extends StatefulWidget {
  static const String id = 'AdminMainScreen';
  const AdminMainScreen({Key? key}) : super(key: key);

  @override
  _AdminMainScreenState createState() => _AdminMainScreenState();
}

class _AdminMainScreenState extends State<AdminMainScreen> {
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
    return WillPopScope(
      onWillPop: () async {
        showDialog(
            context: context,
            builder: (context) {
              return StartScreenAlert();
            });
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            AppLocalizations.of(context)!.appName,
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    return StartScreenAlert();
                  });
            },
          ),
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text(
                    AppLocalizations.of(context)!.announcementList,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  height: kIsWeb
                      ? MediaQuery.of(context).size.height * (30 / 100)
                      : MediaQuery.of(context).size.height * (20 / 100),
                  child: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('pengumuman')
                        .orderBy('tanggal', descending: true)
                        .limit(5)
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
                        scrollDirection: Axis.horizontal,
                        children: snapshot.data!.docs.map((e) {
                          return InkWell(
                            onTap: () {
                              Navigator.pushNamed(
                                  context,
                                  AdminMainScreenRoute +
                                      PengumumanScreenRoute +
                                      '/${e.id}',
                                  arguments: Pengumuman(
                                      e.id,
                                      e.data()['judul'],
                                      e.data()['isi'],
                                      e.data()['tanggal'],
                                      e.data()['gambar']));
                            },
                            child: Card(
                              elevation: 8,
                              margin: EdgeInsets.all(10),
                              child: Hero(
                                tag: 'pengumuman_tag_${e.id}',
                                child: Container(
                                  width: 250,
                                  height: kIsWeb ? 400 : 150,
                                  child: e.data()['gambar'] != ""
                                      ? Container(
                                          child: Image(
                                            image: NetworkImage(
                                                e.data()['gambar']),
                                            fit: BoxFit.cover,
                                          ),
                                        )
                                      : Container(
                                          padding: EdgeInsets.all(16),
                                          child: Text(
                                            e.data()['judul'],
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 24,
                                            ),
                                          ),
                                        ),
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pushNamed(context,
                            AdminMainScreenRoute + JemaatDataListScreenRoute);
                      },
                      child: AdminCardMenu(
                        text: AppLocalizations.of(context)!.jemaatData,
                        icon: FontAwesome.paste,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pushNamed(
                            context, AdminMainScreenRoute + '/warta');
                      },
                      child: AdminCardMenu(
                        text: AppLocalizations.of(context)!.wartaJemaatData,
                        icon: FontAwesome.info_circled,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pushNamed(context,
                            AdminMainScreenRoute + RenunganDataListScreenRoute);
                      },
                      child: AdminCardMenu(
                        text: AppLocalizations.of(context)!.renunganData,
                        icon: FontAwesome.book,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pushNamed(context,
                            AdminMainScreenRoute + AdminAddJemaatScreenRoute,
                            arguments: Jemaat("", "", "", "",
                                DateTime.now().toString(), true));
                      },
                      child: AdminCardMenu(
                        text: AppLocalizations.of(context)!.addJemaat,
                        icon: Icons.person_add_alt_1,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pushNamed(context,
                            AdminMainScreenRoute + AdminAddWartaScreenRoute);
                      },
                      child: AdminCardMenu(
                        text: AppLocalizations.of(context)!.addWarta,
                        icon: Icons.upload_file,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pushNamed(context,
                            AdminMainScreenRoute + AdminAddRenunganScreenRoute,
                            arguments: Renungan("", "", "", "", "", true));
                      },
                      child: AdminCardMenu(
                        text: AppLocalizations.of(context)!.addRenungan,
                        icon: Icons.add_box,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pushNamed(
                            context,
                            AdminMainScreenRoute +
                                AdminAddPengumumanScreenRoute);
                      },
                      child: AdminCardMenu(
                        text: AppLocalizations.of(context)!.addAnnouncement,
                        icon: Icons.add_alert,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * (10 / 100),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class StartScreenAlert extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(AppLocalizations.of(context)!.alertWarning),
      content: Text(AppLocalizations.of(context)!.alertWarningMessage),
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
            Navigator.pushNamed(context, StartScreenRoute);
            AuthServices.signOutUser();
          },
        )
      ],
    );
  }
}
