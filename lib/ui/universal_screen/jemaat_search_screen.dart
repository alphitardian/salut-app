import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:salut_app_flutter/common.dart';
import 'package:salut_app_flutter/models/jemaat_model.dart';

class JemaatSearchScreen extends StatefulWidget {
  final bool admin;

  const JemaatSearchScreen({Key? key, required this.admin}) : super(key: key);

  @override
  _JemaatSearchScreenState createState() => _JemaatSearchScreenState();
}

class _JemaatSearchScreenState extends State<JemaatSearchScreen> {
  TextEditingController searchController = TextEditingController();
  bool isSearch = false;
  String searchQuery = "";

  Stream<QuerySnapshot> data = FirebaseFirestore.instance
      .collection('jemaat')
      .orderBy('nama')
      .where('searchCase', arrayContains: "")
      .snapshots();

  Stream<QuerySnapshot> allData = FirebaseFirestore.instance
      .collection('jemaat')
      .orderBy('nama')
      .snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: searchController,
          decoration: InputDecoration(
            hintText: AppLocalizations.of(context)!.searchHint,
            enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: secondaryColor)),
            border: UnderlineInputBorder(
                borderSide: BorderSide(color: secondaryColor)),
            focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: secondaryColor)),
          ),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                searchQuery = searchController.text.toLowerCase();
                data = FirebaseFirestore.instance
                    .collection('jemaat')
                    .where('searchCase', arrayContains: searchQuery)
                    .snapshots();
              });
            },
            icon: Icon(
              Icons.search,
              color: Colors.black,
            ),
          ),
        ],
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      body: StreamBuilder<QuerySnapshot>(
        stream: searchQuery.isEmpty ? allData : data,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          return ListView(
            children: snapshot.data!.docs.map((e) {
              return InkWell(
                onTap: () {
                  Navigator.pushNamed(
                      context, JemaatDataListScreenRoute + '/${e.id}',
                      arguments: Jemaat(
                          e.id,
                          e.data()['nama'],
                          e.data()['pekerjaan'],
                          e.data()['telepon'],
                          e.data()['tanggal lahir'],
                          false));
                },
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
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
