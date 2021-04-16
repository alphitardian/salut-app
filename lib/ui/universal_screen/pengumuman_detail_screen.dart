import 'package:salut_app_flutter/common.dart';
import 'package:salut_app_flutter/models/pengumuman_model.dart';
import 'package:share/share.dart';

class PengumumanDetailScreen extends StatelessWidget {
  final Pengumuman args;

  const PengumumanDetailScreen({Key? key, required this.args})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: args.imageUrl.isEmpty
          ? AppBar(
              title: Text(
                AppLocalizations.of(context)!.announcement,
                style: kAppBarrTextStyle,
              ),
              elevation: 0,
              backgroundColor: Colors.white,
              leading: IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                ),
                onPressed: () => Navigator.of(context).pop(),
              ),
            )
          : null,
      backgroundColor: Colors.white,
      body: args.imageUrl.isNotEmpty
          ? kIsWeb
              ? CustomScrollView(
                  slivers: [
                    SliverAppBar(
                      title: Text(
                        AppLocalizations.of(context)!.announcement,
                      ),
                      floating: false,
                      pinned: true,
                      flexibleSpace: FlexibleSpaceBar(
                        collapseMode: CollapseMode.parallax,
                        background: Hero(
                          tag: 'pengumuman_tag_${args.id}',
                          child: Image.network(
                            args.imageUrl,
                            fit: kIsWeb ? BoxFit.cover : BoxFit.fill,
                          ),
                        ),
                      ),
                      expandedHeight: kIsWeb ? 400 : 200,
                      backgroundColor: mainColor,
                    ),
                    SliverFillRemaining(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 128),
                        child: Container(
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
                      ),
                    ),
                  ],
                )
              : CustomScrollView(
                  slivers: [
                    SliverAppBar(
                      title: Text(
                        AppLocalizations.of(context)!.announcement,
                      ),
                      floating: false,
                      pinned: true,
                      flexibleSpace: FlexibleSpaceBar(
                        collapseMode: CollapseMode.parallax,
                        background: Hero(
                          tag: 'pengumuman_tag_${args.id}',
                          child: Image.network(
                            args.imageUrl,
                            fit: kIsWeb ? BoxFit.cover : BoxFit.fill,
                          ),
                        ),
                      ),
                      expandedHeight: 200,
                      backgroundColor: mainColor,
                    ),
                    SliverFillRemaining(
                      child: Container(
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
                    ),
                  ],
                )
          : kIsWeb
              ? Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 128),
                  child: Container(
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
                          height:
                              MediaQuery.of(context).size.height * (3 / 100),
                        ),
                        Text(args.body),
                      ],
                    ),
                  ),
                )
              : Container(
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
                        height: MediaQuery.of(context).size.height * (3 / 100),
                      ),
                      Text(args.body),
                    ],
                  ),
                ),
      floatingActionButton: ElevatedButton(
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
