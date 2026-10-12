import 'dart:io';

// Program sederhana untuk login, mengecek saldo,
// menyetor uang, dan menarik uang.
void main() {
  var ceklogin = true;
  var jalan = true;
  var pin = 112233;
  var saldo = 2000000;

  // Meminta PIN sampai pengguna memasukkan PIN yang benar.
  login() {
    while (ceklogin == true) {
      print('\n================================');
      print('Sistem Bank');
      print('================================');
      stdout.write('Masukkan PIN Anda: ');
      int? inputPin = int.tryParse(stdin.readLineSync() ?? '');

      if (inputPin == pin) {
        print('Login berhasil!');
        ceklogin = false;
      } else {
        print('PIN tidak valid. Coba lagi.');
      }
    }
  }

  // Menampilkan pilihan menu bank.
  tampilMenu() {
    print('\n================================');
    print('1. Cek Saldo');
    print('2. Setor Tunai');
    print('3. Tarik Tunai');
    print('4. Keluar');
    print('================================');
  }

  // Menampilkan saldo saat ini.
  cekSaldo() {
    print('Saldo Anda: Rp$saldo');
  }

  // Menambahkan uang ke saldo.
  setor() {
    stdout.write('Masukkan nominal yang ingin disetor: ');
    int? jumlah = int.tryParse(stdin.readLineSync() ?? '');

    if (jumlah == null || jumlah <= 0) {
      print('Masukkan nominal yang valid.');
    } else {
      saldo = saldo + jumlah;
      print('Setor berhasil. Saldo Anda: Rp$saldo');
    }
  }

  // Mengurangi saldo jika jumlah penarikan valid dan saldo cukup.
  tarik() {
    stdout.write('Masukkan nominal yang ingin ditarik: ');
    int? jumlah = int.tryParse(stdin.readLineSync() ?? '');

    if (jumlah == null || jumlah <= 0) {
      print('Masukkan nominal yang valid.');
    } else if (jumlah > saldo) {
      print('Saldo Anda tidak cukup.');
    } else {
      saldo = saldo - jumlah;
      print('Penarikan berhasil. Saldo Anda: Rp$saldo');
    }
  }

  while (jalan == true) {
    if (ceklogin == true) {
      login();
    } else {
      tampilMenu();
      stdout.write('Pilih menu (1-4): ');
      int? pilihan = int.tryParse(stdin.readLineSync() ?? '');

      switch (pilihan) {
        case 1:
          cekSaldo();
          break;
        case 2:
          setor();
          break;
        case 3:
          tarik();
          break;
        case 4:
          print('Sampai jumpa!');
          jalan = false;
          break;
        default:
          print('Pilihan tidak valid.');
      }
    }
  }
}
