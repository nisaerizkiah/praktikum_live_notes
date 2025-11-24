# Laporan Praktikum Live Note Flutter & Firebase 
**Nama: Nisa Eka Kholifaturrizkiah**
**Nim: 362458302018**

## Skenario Proyek: Live Notes
Kita akan membangun aplikasi catatan sederhana. Fitur utamanya adalah singkronisasi real-time. Jika mahasiswa A menambahkan catatan, catatan tersebut akan langsung muncul di layar mahasiswa B tanpa perlu melakukan refresh.

## Langkah Langkah
1. Membuat proyek di console firebase seperti cara yang ada pada modul praktikum.
2. Konfigurasi database.
3. Setelah itu instalasi integrasi dengan membuat project flutter, menambahkan dependency, menghubungkan dengan FlutterFire CLI seperti yang ada pada modul.
4. Kemudian implementasi kode yang ada pada modul di visual code, berikut hasilnya menampilkan halaman awal yang belum memiliki note apapun.

![1](https://github.com/user-attachments/assets/dfbd7916-b6d7-4689-b6fa-882f20c36a2a)

5. Menambahkan catatan dengan klik tombol (+) pojok kanan bawah

![2](https://github.com/user-attachments/assets/2e403901-8ece-4d74-a9b8-d0980694573c)

6. Berikut hasil setelah ditambahkan

![3](https://github.com/user-attachments/assets/cb6e7a83-43f9-4d45-99c5-1550d13e555d)

7.  Update Feature: Tambahkan fitur edit. Ketika ListTile ditekan (onTap), munculkan formulir yang sudah terisi data lama, dan update data tersebut di Firebase menggunakan perintah .update().

Berikut hasilnya menambahkan catatan baru

![4](https://github.com/user-attachments/assets/e240cb95-0a17-495d-a00b-31842a51197c)

Kemudian apabila ditekan bagian note tersebut akan muncul update note

![6](https://github.com/user-attachments/assets/9d526c1e-08cb-498e-b4c3-e40f4ec72390)

Ini hasil note yang sudah diperbarui

![7](https://github.com/user-attachments/assets/677d784a-55f7-4789-8928-80d63d71fb67)

8. Testing: Jalankan aplikasi di 2 device berbeda untuk membuktikan bahwa data tersinkronisasi secara otomatis.
Berikut hasil di device lain saat menambahkan note baru, dan hasilnya benar-benar tersinkronisasi dikedua device tersebut sama-sama tampil.

Device 1 

![8](https://github.com/user-attachments/assets/9ccd7a2c-9a23-4771-a72c-869364c6d4db)

Device 2

![9](https://github.com/user-attachments/assets/d00d7bf3-a713-41cb-9dab-3c3c426bd548)







