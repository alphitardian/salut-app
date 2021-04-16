import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:salut_app_flutter/common.dart';
import 'package:salut_app_flutter/models/renungan_model.dart';

class JemaatRenunganDataScreen extends StatelessWidget {
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
                      JemaatMainScreenRoute +
                          RenunganDataListScreenRoute +
                          '/${e.id}',
                      arguments: Renungan(
                          e.id,
                          e.data()['judul'],
                          e.data()['isi'],
                          e.data()['tanggal'],
                          e.data()['gambar'],
                          false));
                },
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
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
