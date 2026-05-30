import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/add_spider_controller.dart';

class AddSpiderView extends GetView<AddSpiderController> {
  const AddSpiderView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AÑADIR EJEMPLAR'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          TextField(
            controller: controller.nameC,
            decoration: const InputDecoration(
              labelText: "Nombre (Ej: Phidippus regius)",
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 20),
          TextField(
            controller: controller.speciesC,
            decoration: const InputDecoration(
              labelText: "Fase / Sexo / Notas",
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 20),
          Obx(() => ElevatedButton(
            onPressed: () async {
              if (controller.isLoading.isFalse) {
                bool res = await controller.addSpider();
                if (res == true) {
                  Get.back(); // Vuelve al Home al guardar
                }
              }
            },
            child: Text(controller.isLoading.isFalse ? "GUARDAR" : "CARGANDO..."),
          )),
        ],
      ),
    );
  }
}