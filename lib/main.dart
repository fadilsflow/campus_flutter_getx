import 'package:flutter/material.dart';
import 'package:get/get.dart'; // Import GetX agar semua fitur bisa dipakai

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // 1. Wajib pakai GetMaterialApp agar utility routing & popups GetX jalan
    return GetMaterialApp(
      title: 'Counter & Utilitas',
      theme: ThemeData.light(),
      home: HomePage(),
    );
  }
}

// Controller: tempat nyimpen logika biar gak nyampur di UI
class CounterController extends GetxController {
  var count = 0.obs; // .obs bikin variabel ini otomatis memantau update

  void increment() => count.value++;
  void decrement() => count.value--;
  void reset() => count.value = 0;
}

class HomePage extends StatelessWidget {
  // Panggil controller
  final c = Get.put(CounterController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Counter & 8 Utility")),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Obx: yang di dalam sini otomatis berubah saat count update
          Obx(
            () => Text(
              "Counter: ${c.count}",
              style: const TextStyle(fontSize: 40),
            ),
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: c.decrement,
                icon: const Icon(Icons.remove),
              ),
              IconButton(onPressed: c.reset, icon: const Icon(Icons.refresh)),
              IconButton(onPressed: c.increment, icon: const Icon(Icons.add)),
            ],
          ),

          const Divider(height: 40),
          const Text("8 Utility GetX:"),

          Wrap(
            alignment: WrapAlignment.center,
            spacing: 5,
            runSpacing: 5,
            children: [
              // 1. Snackbar
              ElevatedButton(
                onPressed: () => Get.snackbar("Hai", "Ini pesan"),
                child: const Text("Snackbar"),
              ),
              // 2. Dialog
              ElevatedButton(
                onPressed: () =>
                    Get.defaultDialog(title: "Halo", middleText: "Ini dialog"),
                child: const Text("Dialog"),
              ),
              // 3. BottomSheet
              ElevatedButton(
                onPressed: () => Get.bottomSheet(
                  Container(color: Colors.white, height: 100),
                ),
                child: const Text("B.Sheet"),
              ),
              // 4. Get.offAll -> Pindah halaman & hapus riwayat (sering dipakai untuk Logout)
              ElevatedButton(
                onPressed: () => Get.offAll(() => HalDua()),
                child: const Text("OffAll Hal 2"),
              ),
              // 5. Get.to + arguments -> Navigasi sambil merouting data / variabel
              ElevatedButton(
                onPressed: () =>
                    Get.to(() => HalDua(), arguments: "Ini Data Rahasia!"),
                child: const Text("Pindah Hal 2"),
              ),
            ],
          ),

          const SizedBox(height: 15),
          // 6. GetUtils -> Sering dipakai cek validasi, misal cek format email form login
          Text("Cek Email 'tes@GetX.com': ${GetUtils.isEmail('tes@GetX.com')}"),
          const SizedBox(height: 5),
          // 7. GetPlatform -> Sering dipakai cek tipe OS yg dipakai HP
          Text("Apakah OS aslinya Android? ${GetPlatform.isAndroid}"),
        ],
      ),
    );
  }
}

class HalDua extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Halaman 2")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Menampilkan data tangkapan dari Get.to di point nomor 5
            if (Get.arguments != null)
              Text(
                "Argumen diterima: ${Get.arguments}",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),

            const SizedBox(height: 20),
            // 8. Navigasi kembali
            ElevatedButton(
              onPressed: () => Get.back(),
              child: const Text("Kembali (Get.back)"),
            ),
          ],
        ),
      ),
    );
  }
}
