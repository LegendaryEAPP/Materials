// import 'dart:ffi';
import 'dart:io';

void main() {
  var jalan = true;

  List waitinglist=[];

  // Map POS = {'POS A':Null, 'POS B':Null, 'POS C':Null };
  Map POSA = {'plat':null};
  Map POSB = {'plat':null};
  Map POSC = {'plat':null};

  tambahlist() {
    //jika ketiga pos lagi kosong maka masuk dulu, jika sebuah pos penuh maka akan ke waiting list
    stdout.write('Plat Kendaraan:');
    var plat = (stdin.readLineSync()!);
    
    if (POSA['plat'] == null ) {
      POSA['plat'] = plat;
    } else if (POSB['plat'] == null) {
        POSB['plat'] = plat;
      } else if (POSC['plat'] == null) {
        POSC['plat'] = plat;
      } else {
        waitinglist.add(plat);
      }
    }
  
    
    
  

  showlist(){
    //perulangan pada list for, for in, for each
    for (var i = 0; i < waitinglist.length; i++) {
        print('Waiting List ke-${i+1}: ${waitinglist[i]}'); 
      }
      
    // for (var i in waitinglist) {
    //   print('Waiting List: $i');
    // }

    // waitinglist.forEach((plat) => print('Waiting List: $plat'));
    }

  showpos(){
  //tampil pos A,B,C
   print(POSA['plat']);
   print(POSB['plat']);
   print(POSC['plat']);
  }

  finishpos(){
    //tanya user, hapus pos berapa?
    //jika pos A dihapus
    //maka pos A jadikan null, pos A diisi dengan list pertama, list pertama dihapus
    //jika pos B dihapus
    //maka pos C jadikan null, pos A diisi dengan list pertama, list pertama dihapus
    stdout.write('Pilih POS yang selesai (A/B/C): ');
    var pilihan = stdin.readLineSync()?.toUpperCase(); //Mengubah input menjadi huruf kapital

    Map? targetPOS;
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
      print('$namaPOS memang sedang kosong.');
      return;
    }

    print('Pencucian kendaraan di $namaPOS (${targetPOS['plat']}) telah selesai.');

    // Cek apakah ada antrian di waitinglist
    if (waitinglist.isNotEmpty) {
      // Ambil elemen pertama dari waitinglist dan hapus dari list
      var platberikutnya = waitinglist.removeAt(0);
      targetPOS['plat'] = platberikutnya;
      print('Kendaraan $platberikutnya dari waiting list masuk ke $namaPOS.');
    } else {
      targetPOS['plat'] = null;
      print('$namaPOS sekarang kosong.');
    }
  }


  keluar(){
    //tombol keluar
    exit(0);
    }

  while(jalan==true){
    //tampil menu dulu
    //tanya user pilih menu mana
    //switch case
    //case 1 -> tampil menu
    //case 2 -> lihat waiting list
    //case 3 -> lihat pos
    //case 4 -> selesaikan pos
    //case 5 -> keluar dari aplikasi

    print('\n================================');
    print('Sistem Cuci Mobil');
    print('================================');
    print('1. Tambah Waiting list');
    print('2. Lihat Waiting List');
    print('3. Lihat POS');
    print('4. Selesaikan POS');
    print('5. Keluar');

    stdout.write('Pilih menu (1/2/3/4/5):');
    int pilihan = int.parse(stdin.readLineSync()!);

    switch(pilihan) {
      case 1 :
      tambahlist();
      case 2 :
      showlist();
      case 3 :
      showpos();
      case 4 :
      finishpos();
      case 5 :
      keluar();
    }
  }

  
}