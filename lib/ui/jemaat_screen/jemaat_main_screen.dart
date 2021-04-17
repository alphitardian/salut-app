import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:salut_app_flutter/common.dart';
import 'package:salut_app_flutter/components/card_menu.dart';
import 'package:salut_app_flutter/models/pengumuman_model.dart';
import 'package:salut_app_flutter/ui/universal_screen/salukul_screen.dart';
import 'package:url_launcher/url_launcher.dart';

class JemaatMainScreen extends StatefulWidget {
  @override
  _JemaatMainScreenState createState() => _JemaatMainScreenState();
}

class _JemaatMainScreenState extends State<JemaatMainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.appName,
          style: kAppBarrTextStyle,
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
              icon: Icon(
                Icons.more_horiz,
                color: Colors.black,
              ),
              onPressed: () {
                showAboutDialog(
                  context: context,
                  applicationIcon: Image.asset(
                    'assets/images/salutapp-logo.png',
                    height: 50,
                    width: 50,
                    fit: BoxFit.cover,
                  ),
                  applicationVersion: '1.0.0',
                  children: [
                    RichText(
                      text: TextSpan(
                        style: GoogleFonts.poppins(color: Colors.black),
                        children: [
                          TextSpan(
                            text: AppLocalizations.of(context)!.developedBy,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextSpan(
                            text: 'Ardian Pramudya Alphita',
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Text(
                      AppLocalizations.of(context)!.businessInquiry,
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                );
              }),
        ],
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
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
                                JemaatMainScreenRoute +
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
                                          image:
                                              NetworkImage(e.data()['gambar']),
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
                height: MediaQuery.of(context).size.height * (10 / 100),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(
                              context,
                              JemaatMainScreenRoute +
                                  JemaatDataListScreenRoute);
                        },
                        child: CardMenu(
                          icon: FontAwesome.paste,
                          cardTitle: AppLocalizations.of(context)!.jemaatData,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(
                              context,
                              JemaatMainScreenRoute +
                                  RenunganDataListScreenRoute);
                        },
                        child: CardMenu(
                          cardTitle: AppLocalizations.of(context)!.renunganData,
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
                          kIsWeb
                              ? launch('https://salukul.gkjsalut.id/')
                              : Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => SalukulScreen(),
                                  ),
                                );
                        },
                        child: CardMenu(
                          icon: FontAwesome.food,
                          cardTitle: 'Salukul',
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(
                              context, JemaatMainScreenRoute + '/warta');
                        },
                        child: CardMenu(
                          cardTitle:
                              AppLocalizations.of(context)!.wartaJemaatData,
                          icon: FontAwesome.info_circled,
                        ),
                      ),
                    ],
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
    );
  }
}
