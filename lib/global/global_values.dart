import 'package:chata/backend/auth/auth_service.dart';
import 'package:get_it/get_it.dart';
import 'package:get_storage/get_storage.dart';
import 'package:supabase/supabase.dart';

GetIt getIt = GetIt.I;
Future<void> setupLocator() async {
  getIt.registerSingleton(GetStorage());
// initalize and register supabase client
  getIt.registerSingleton<SupabaseClient>(
      SupabaseClient(supabaseUrl, supabaseKey));
  // initialize and register global values
  //register auth service
}

const supabaseUrl = 'https://pmmvoxibhvipzhmddwsu.supabase.co';
const supabaseKey =
    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoiYW5vbiIsImlhdCI6MTYyODMzMzk0MCwiZXhwIjoxOTQzOTA5OTQwfQ.5lEuyaW6lgdB6yxN0SmDiOLMIko5Do13ru6HPEPD_5c';
const streanApi = 'cwvmn22t9zk3';
const jixUser = 'boitumelo1@jix.im';
const jixPass = 'tuva1btwo@';
