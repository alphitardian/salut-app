import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart';

class DownloadServices {
  static Future downloadFile() async {
    int i = 2;

    Workbook workbook = Workbook();
    Worksheet worksheet = workbook.worksheets[0];

    worksheet.getRangeByName('A1').setText('Nama');
    worksheet.getRangeByName('B1').setText('Pekerjaan');
    worksheet.getRangeByName('C1').setText('Telepon');
    worksheet.getRangeByName('D1').setText('Tanggal Lahir');

    // Auto Fit Width
    worksheet.getRangeByName('A1').columnWidth = 25;
    worksheet.getRangeByName('B1').columnWidth = 20;
    worksheet.getRangeByName('C1').columnWidth = 15;
    worksheet.getRangeByName('D1').autoFit();

    // Fill data
    FirebaseFirestore.instance
        .collection('jemaat')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((element) {
        i++;

        worksheet.getRangeByName('A$i').setText(element['nama']);
        worksheet.getRangeByName('B$i').setText(element['pekerjaan']);
        worksheet.getRangeByName('C$i').setText(element['telepon']);
        worksheet.getRangeByName('D$i').setText(element['tanggal lahir']);
      });

      workbook.dispose();

      print('Coming Soon');
    });
  }
}
