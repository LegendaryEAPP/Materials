import 'dart:io';

// Program cuci mobil dengan pembayaran dari saldo bank.
// Mobil yang selesai dicuci harus membayar sebelum POS digunakan lagi.
void main() {
  var jalan = true;
  var pin = 112233;
  var saldo = 2000000;
  var hargaCuci = 50000;
  var sudahLogin = false;

  List<String> waitinglist = [];
  Map<String, String?> POSA = {'plat': null};
  Map<String, String?> POSB = {'plat': null};
  Map<String, String?> POSC = {'plat': null};

  login() {
    while (sudahLogin == false) {
      stdout.write('Masukkan PIN bank Anda: ');
      int? inputPin = int.tryParse(stdin.readLineSync() ?? '');

      if (inputPin == pin) {
        print('Login berhasil!');
        sudahLogin = true;
      } else {
        print('PIN tidak valid. Coba lagi.');
      }
    }
  }

  tambahMobil() {
    stdout.write('Masukkan plat kendaraan: ');
    String plat = stdin.readLineSync() ?? '';

    if (plat.isEmpty) {
      print('Plat kendaraan tidak boleh kosong.');
    } else if (POSA['plat'] == null) {
      POSA['plat'] = plat;
      print('Kendaraan $plat masuk ke POS A.');
    } else if (POSB['plat'] == null) {
      POSB['plat'] = plat;
      print('Kendaraan $plat masuk ke POS B.');
    } else if (POSC['plat'] == null) {
      POSC['plat'] = plat;
      print('Kendaraan $plat masuk ke POS C.');
    } else {
      waitinglist.add(plat);
      print('Semua POS penuh. Kendaraan masuk ke waiting list.');
    }
  }

  lihatData() {
    print('\n--- WAITING LIST ---');
    if (waitinglist.isEmpty) {
      print('Waiting list masih kosong.');
    } else {
      for (var i = 0; i < waitinglist.length; i++) {
        print('${i + 1}. ${waitinglist[i]}');
      }
    }

    print('\n--- STATUS POS ---');
    print('POS A: ${POSA['plat'] ?? 'Kosong'}');
    print('POS B: ${POSB['plat'] ?? 'Kosong'}');
    print('POS C: ${POSC['plat'] ?? 'Kosong'}');
  }

  lihatSaldo() {
    login();
    print('Saldo bank Anda: Rp$saldo');
  }

  setorTunai() {
    login();
    stdout.write('Masukkan nominal yang ingin disetor: ');
    int? jumlah = int.tryParse(stdin.readLineSync() ?? '');

    if (jumlah == null || jumlah <= 0) {
      print('Masukkan nominal yang valid.');
    } else {
      saldo = saldo + jumlah;
      print('Setor berhasil. Saldo Anda: Rp$saldo');
    }
  }

  selesaikanDanBayar() {
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
      return;
    }

    print('Kendaraan ${targetPOS['plat']} selesai dicuci.');
    print('Biaya cuci: Rp$hargaCuci');
    login();

    if (saldo < hargaCuci) {
      print('Saldo tidak cukup. Setor uang sebelum melakukan pembayaran.');
      return;
    }

    saldo = saldo - hargaCuci;
    print('Pembayaran berhasil. Sisa saldo: Rp$saldo');
    targetPOS['plat'] = null;

    if (waitinglist.isNotEmpty) {
      String platBerikutnya = waitinglist.removeAt(0);
      targetPOS['plat'] = platBerikutnya;
      print('Kendaraan $platBerikutnya dari waiting list masuk ke $namaPOS.');
    } else {
      print('$namaPOS sekarang kosong.');
    }
  }

  while (jalan == true) {
    print('\n================================');
    print('Sistem Cuci Mobil dan Pembayaran');
    print('================================');
    print('1. Pesan cuci mobil');
    print('2. Lihat waiting list dan POS');
    print('3. Selesaikan cuci dan bayar');
    print('4. Cek saldo bank');
    print('5. Setor tunai');
    print('6. Keluar');

    stdout.write('Pilih menu (1-6): ');
    int? pilihan = int.tryParse(stdin.readLineSync() ?? '');

    switch (pilihan) {
      case 1:
        tambahMobil();
        break;
      case 2:
        lihatData();
        break;
      case 3:
        selesaikanDanBayar();
        break;
      case 4:
        lihatSaldo();
        break;
      case 5:
        setorTunai();
        break;
      case 6:
        print('Sampai jumpa!');
        jalan = false;
        break;
      default:
        print('Pilihan tidak valid.');
    }
  }
}
