import 'package:flutter/material.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/route_manager.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FLutter Getx',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: HomePage(),
    );
  }
}

// controller
class CounterController extends GetxController {
  var count = 0.obs;
  void increment() {
    count.value++;
  }

  void decrement() {
    count.value--;
  }

  void reset() {
    count.value = 0;
  }
}

class HomePage extends StatelessWidget {
  // const HomePage({super.key});

  final CounterController controller = Get.put(CounterController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Counter")),
      body: Column(
        children: [
          Center(child: Obx(() => Text("Nilai:  ${controller.count}"))),
          FloatingActionButton(
            onPressed: controller.increment,
            child: Icon(Icons.add),
          ),
          FloatingActionButton(
            onPressed: controller.decrement,
            child: Icon(Icons.remove),
          ),
          FloatingActionButton(
            onPressed: controller.reset,
            child: Icon(Icons.refresh),
          ),
        ],
      ),
    );
  }
}
