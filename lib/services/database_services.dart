import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:path/path.dart';
import 'package:universal_platform/universal_platform.dart';

class DatabaseJemaatServices {
  static CollectionReference jemaatCollection =
      FirebaseFirestore.instance.collection('jemaat');

  Future<void> updateData(
      String id, String name, String job, String phone, String date) async {
    await jemaatCollection.doc(id).update({
      'nama': name,
      'pekerjaan': job,
      'telepon': phone,
      'tanggal lahir': date,
      'searchCase': setSearchParam(name),
    });
  }

  Future<void> addData(
      String name, String job, String phone, String date) async {
    await jemaatCollection.add({
      'nama': name,
      'pekerjaan': job,
      'telepon': phone,
      'tanggal lahir': date,
      'searchCase': setSearchParam(name),
    });
  }

  static Future<void> deleteData(String id) async {
    await jemaatCollection.doc(id).delete();
  }

  static Future<DocumentSnapshot> getData(String id) async {
    return await jemaatCollection.doc(id).get();
  }

  static Future queryData(String query) async {
    return jemaatCollection.where('nama', isGreaterThanOrEqualTo: query).get();
  }

  setSearchParam(String caseNumber) {
    List<String> caseSearchList = [];
    String temp = "";
    for (int i = 0; i < caseNumber.length; i++) {
      temp = temp + caseNumber[i].toLowerCase();
      caseSearchList.add(temp);
    }
    return caseSearchList;
  }
}

class DatabaseRenunganServices {
  static CollectionReference renunganCollection =
      FirebaseFirestore.instance.collection('renungan');

  static Future<void> addData(String title, String body, String url) async {
    await renunganCollection.add({
      'judul': title,
      'isi': body,
      'tanggal': DateTime.now().toString(),
      'gambar': url,
    });
  }

  static Future<void> updateData(String id, String title, String body) async {
    await renunganCollection.doc(id).update({
      'judul': title,
      'isi': body,
      'tanggal': DateTime.now().toString(),
    });
  }

  static Future<void> deleteData(String id) async {
    String imageUrl = '';

    await renunganCollection.doc(id).get().then((value) {
      imageUrl = value.data()!['gambar'];
    });

    await renunganCollection.doc(id).delete();
    await deleteImage(imageUrl);
  }

  static Future<String?> uploadImage(PickedFile image) async {
    UploadTask task;

    String filename = basename(image.path);

    try {
      Reference ref = FirebaseStorage.instance.ref("renungan").child(filename);

      if (UniversalPlatform.isWeb) {
        var data = await image.readAsBytes();
        task = ref.putData(data);

        print('upload success');

        return task.then((res) => res.ref.getDownloadURL());
      } else {
        task = ref.putFile(File(image.path));

        print('upload success');

        return task.then((res) => res.ref.getDownloadURL());
      }
    } catch (e) {
      print(e);
    }
  }

  static Future<void> deleteImage(String imageFileUrl) async {
    try {
      var fileUrl = Uri.decodeFull(basename(imageFileUrl))
          .replaceAll(new RegExp(r'(\?alt).*'), '');
      final Reference firebaseStorageRef =
          FirebaseStorage.instance.ref().child(fileUrl);
      await firebaseStorageRef.delete();
    } catch (e) {
      print(e);
    }
  }
}

class DatabaseWartaJemaatServices {
  static CollectionReference wartaCollection =
      FirebaseFirestore.instance.collection('warta_jemaat');

  static Future<void> addData(String title, String url) async {
    await wartaCollection.add({
      'judul': title,
      'tanggal': DateTime.now().toString(),
      'file': url,
    });
  }

  static Future<String?> uploadFile(FilePickerResult file) async {
    String filename = UniversalPlatform.isWeb
        ? basename(file.files.single.name!)
        : basename(file.files.single.path!);

    Reference ref = FirebaseStorage.instance.ref("warta").child(filename);

    try {
      if (UniversalPlatform.isWeb) {
        Uint8List uploadfile = file.files.single.bytes!;

        UploadTask task = ref.putData(uploadfile);

        print(uploadfile);

        print('upload success');
        return task.then((res) => res.ref.getDownloadURL());
      } else {
        UploadTask task = ref.putFile(File(file.files.single.path!));

        print('upload success');
        return task.then((res) => res.ref.getDownloadURL());
      }
    } catch (e) {
      print(e);
    }
  }

  static Future<void> deleteFile(String url) async {
    var fileUrl =
        Uri.decodeFull(basename(url)).replaceAll(new RegExp(r'(\?alt).*'), '');
    final Reference firebaseStorageRef =
        FirebaseStorage.instance.ref().child(fileUrl);
    await firebaseStorageRef.delete();
  }

  static Future<void> deleteData(String id) async {
    String fileUrl = '';

    await wartaCollection.doc(id).get().then((value) {
      fileUrl = value.data()!['file'];
    });

    await wartaCollection.doc(id).delete();
    await deleteFile(fileUrl);
  }
}

class DatabasePengumumanServices {
  static CollectionReference pengumumanCollection =
      FirebaseFirestore.instance.collection('pengumuman');

  static Future<void> addData(String title, String body, String url) async {
    await pengumumanCollection.add({
      'judul': title,
      'isi': body,
      'tanggal': DateTime.now().toString(),
      'gambar': url,
    });
  }

  static Future<String?> uploadImage(PickedFile image) async {
    UploadTask task;

    String filename = basename(image.path);

    try {
      Reference ref =
          FirebaseStorage.instance.ref("pengumuman").child(filename);

      if (UniversalPlatform.isWeb) {
        var data = await image.readAsBytes();
        task = ref.putData(data);

        print('upload success');

        return task.then((res) => res.ref.getDownloadURL());
      } else {
        task = ref.putFile(File(image.path));

        print('upload success');

        return task.then((res) => res.ref.getDownloadURL());
      }
    } catch (e) {
      print(e);
    }
  }

  static Future<void> deleteImage(String imageFileUrl) async {
    var fileUrl = Uri.decodeFull(basename(imageFileUrl))
        .replaceAll(new RegExp(r'(\?alt).*'), '');
    final Reference firebaseStorageRef =
        FirebaseStorage.instance.ref().child(fileUrl);
    await firebaseStorageRef.delete();
  }
}
