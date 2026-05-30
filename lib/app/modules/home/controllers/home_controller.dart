import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../data/models/notes_model.dart';
import '../../../data/models/spider_model.dart'; // Importamos tu modelo de arañas

class HomeController extends GetxController {
  SupabaseClient client = Supabase.instance.client;

  // Listas para guardar las dos cosas
  RxList<Notes> allNotes = List<Notes>.empty(growable: true).obs;
  RxList<Spider> allSpiders = List<Spider>.empty(growable: true).obs;

  Future<int> getUserId() async {
    final res = await client
        .from('users')
        .select('id')
        .match({'uid': client.auth.currentUser!.id});
    return res.first['id'] as int;
  }

  // Ahora esta función descarga AMBAS cosas
  Future<void> getAllNotes() async {
    int userId = await getUserId();

    // Descargar Notas
    final resNotes = await client
        .from('notes')
        .select()
        .match({'user_id': userId})
        .order('created_at', ascending: false);
    allNotes.value = Notes.fromJsonList(resNotes);

    // Descargar Arañas
    final resSpiders = await client
        .from('spiders')
        .select()
        .match({'user_id': userId});
    allSpiders.value = Spider.fromJsonList(resSpiders);
  }

  // Borrar Nota
  Future<void> deleteNote(int id) async {
    await client.from('notes').delete().match({'id': id});
    await getAllNotes();
  }

  // Borrar Araña
  Future<void> deleteSpider(int id) async {
    await client.from('spiders').delete().match({'id': id});
    await getAllNotes();
  }
}