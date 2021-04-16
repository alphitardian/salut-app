import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:salut_app_flutter/models/jemaat_model.dart';
import 'package:salut_app_flutter/ui/universal_screen/jemaat_search_screen.dart';
import 'package:salut_app_flutter/common.dart';

class JemaatJemaatDataScreen extends StatelessWidget {
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
                    admin: false,
                  ),
                ),
              );
            },
            icon: Icon(
              Icons.search,
              color: Colors.black,
            ),
          ),
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
                      JemaatMainScreenRoute +
                          JemaatDataListScreenRoute +
                          '/${e.id}',
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
