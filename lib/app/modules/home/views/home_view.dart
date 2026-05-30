import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_notes/app/data/models/notes_model.dart';
import 'package:supabase_notes/app/data/models/spider_model.dart';
import 'package:supabase_notes/app/routes/app_pages.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('APP REGISTRO IA05'),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () async => Get.toNamed(Routes.PROFILE),
              icon: const Icon(Icons.person),
            )
          ],
        ),
        // FutureBuilder espera a que se descargue todo
        body: FutureBuilder(
            future: controller.getAllNotes(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              return Obx(() => ListView(
                padding: const EdgeInsets.all(15),
                children: [
                  // --- SECCIÓN NOTAS ---
                  const Text("📝 MIS NOTAS", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blue)),
                  const Divider(),
                  if (controller.allNotes.isEmpty) const Text("No hay notas"),
                  ...controller.allNotes.map((note) => ListTile(
                    onTap: () => Get.toNamed(Routes.EDIT_NOTE, arguments: note),
                    leading: CircleAvatar(child: Text("t${note.id}")),
                    title: Text("Título: ${note.title}"),
                    subtitle: Text("${note.description}"),
                    trailing: IconButton(
                      onPressed: () async => await controller.deleteNote(note.id!),
                      icon: const Icon(Icons.delete, color: Colors.red),
                    ),
                  )),

                  const SizedBox(height: 30),

                  // --- SECCIÓN ARAÑAS ---
                  const Text("🕷️ MIS EJEMPLARES", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.orange)),
                  const Divider(),
                  if (controller.allSpiders.isEmpty) const Text("No hay ejemplares registrados"),
                  ...controller.allSpiders.map((spider) => ListTile(
                    leading: const CircleAvatar(backgroundColor: Colors.orange, child: Icon(Icons.bug_report, color: Colors.white)),
                    title: Text("Nombre: ${spider.name}"),
                    subtitle: Text("Especie/Notas: ${spider.species}"),
                    trailing: IconButton(
                      onPressed: () async => await controller.deleteSpider(spider.id!),
                      icon: const Icon(Icons.delete, color: Colors.red),
                    ),
                  )),
                ],
              ));
            }),
        // LOS DOS BOTONES FLOTANTES
        floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton(
              heroTag: 'spider_btn',
              backgroundColor: Colors.orange,
              onPressed: () async {
                await Get.toNamed(Routes.ADD_SPIDER);
                controller.getAllNotes(); // Fuerza a recargar la lista al volver
              },
              child: const Icon(Icons.bug_report),
            ),
            const SizedBox(height: 10),
            FloatingActionButton(
              heroTag: 'note_btn',
              onPressed: () => Get.toNamed(Routes.ADD_NOTE),
              child: const Icon(Icons.add),
            ),
          ],
        ));
  }
}