import 'dart:io';

// Program sederhana untuk mengatur kendaraan di tempat cuci mobil.
// Kendaraan masuk ke POS yang kosong atau ke waiting list jika semua POS penuh.
void main() {
  var jalan = true;
  List<String> waitinglist = [];

  Map<String, String?> POSA = {'plat': null};
  Map<String, String?> POSB = {'plat': null};
  Map<String, String?> POSC = {'plat': null};

  tambahlist() {
    stdout.write('Plat Kendaraan: ');
    String plat = stdin.readLineSync() ?? '';

    if (plat.isEmpty) {
      print('Plat kendaraan tidak boleh kosong.');
    } else if (POSA['plat'] == null) {
      POSA['plat'] = plat;
    } else if (POSB['plat'] == null) {
      POSB['plat'] = plat;
    } else if (POSC['plat'] == null) {
      POSC['plat'] = plat;
    } else {
      waitinglist.add(plat);
      print('Semua POS penuh. Kendaraan masuk ke waiting list.');
    }
  }

  showlist() {
    if (waitinglist.isEmpty) {
      print('Waiting list masih kosong.');
    } else {
      for (var i = 0; i < waitinglist.length; i++) {
        print('Waiting List ke-${i + 1}: ${waitinglist[i]}');
      }
    }
  }

  showpos() {
    print('POS A: ${POSA['plat'] ?? 'Kosong'}');
    print('POS B: ${POSB['plat'] ?? 'Kosong'}');
    print('POS C: ${POSC['plat'] ?? 'Kosong'}');
  }

  finishpos() {
    stdout.write('Pilih POS yang selesai (A/B/C): ');
    String pilihan = (stdin.readLineSync() ?? '').toUpperCase();

    Map<String, String?>? targetPOS;
    String namaPOS = '';

    if (pilihan == 'A') {
      targetPOS = POSA;
      namaPOS = 'POS A';
    } else if (pilihan == 'B') {
      targetPOS = POSB;
      namaPOS = 'POS B';
    } else if (pilihan == 'C') {
      targetPOS = POSC;
      namaPOS = 'POS C';
    } else {
      print('Pilihan POS tidak valid.');
      return;
    }

    if (targetPOS['plat'] == null) {
      print('$namaPOS sedang kosong.');
    } else {
      print('Kendaraan ${targetPOS['plat']} selesai dicuci di $namaPOS.');

      if (waitinglist.isNotEmpty) {
        String platBerikutnya = waitinglist.removeAt(0);
        targetPOS['plat'] = platBerikutnya;
        print('Kendaraan $platBerikutnya dari waiting list masuk ke $namaPOS.');
      } else {
        targetPOS['plat'] = null;
        print('$namaPOS sekarang kosong.');
      }
    }
  }

  while (jalan == true) {
    print('\n================================');
    print('Sistem Cuci Mobil');
    print('================================');
    print('1. Tambah Kendaraan');
    print('2. Lihat Waiting List');
    print('3. Lihat POS');
    print('4. Selesaikan POS');
    print('5. Keluar');

    stdout.write('Pilih menu (1/2/3/4/5): ');
    int? pilihan = int.tryParse(stdin.readLineSync() ?? '');

    switch (pilihan) {
      case 1:
        tambahlist();
        break;
      case 2:
        showlist();
        break;
      case 3:
        showpos();
        break;
      case 4:
        finishpos();
        break;
      case 5:
        print('Sampai jumpa!');
        jalan = false;
        break;
      default:
        print('Pilihan tidak valid.');
    }
  }
}
