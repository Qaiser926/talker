import 'package:supabase_flutter/supabase_flutter.dart' hide Provider;

export 'database/database.dart';
export 'storage/storage.dart';

const _kSupabaseUrl = 'https://mznnnlibbdlovyjhxvbw.supabase.co';
const _kSupabaseAnonKey =
    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im16bm5ubGliYmRsb3Z5amh4dmJ3Iiwicm9sZSI6ImFub24iLCJpYXQiOjE2OTc5MzQ2MzYsImV4cCI6MjAxMzUxMDYzNn0.Iwkm1SsfRGXA0SDZ1ahpjlBovYY_A3Kck4r9QVPX_XA';

class SupaFlow {
  SupaFlow._();

  static SupaFlow? _instance;
  static SupaFlow get instance => _instance ??= SupaFlow._();

  final _supabase = Supabase.instance.client;
  static SupabaseClient get client => instance._supabase;

  static Future initialize() => Supabase.initialize(
        url: _kSupabaseUrl,
        anonKey: _kSupabaseAnonKey,
        debug: false,
      );
}
