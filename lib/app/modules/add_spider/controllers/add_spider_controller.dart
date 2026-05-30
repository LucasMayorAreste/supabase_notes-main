import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AddSpiderController extends GetxController {
  RxBool isLoading = false.obs;
  TextEditingController nameC = TextEditingController();
  TextEditingController speciesC = TextEditingController();

  SupabaseClient client = Supabase.instance.client;

  Future<bool> addSpider() async {
    if (nameC.text.isNotEmpty && speciesC.text.isNotEmpty) {
      isLoading.value = true;
      try {
        // Sacamos tu ID de usuario de Supabase
        final res = await client.from('users').select('id').match({'uid': client.auth.currentUser!.id});
        int userId = res.first['id'] as int;

        // Guardamos la araña
        await client.from('spiders').insert({
          'user_id': userId,
          'name': nameC.text,
          'species': speciesC.text,
        });
        return true;
      } catch (e) {
        print("🚨 ERROR EN SUPABASE: $e");
        return false;
      } finally {
        isLoading.value = false;
      }
    }
    return false;
  }
}