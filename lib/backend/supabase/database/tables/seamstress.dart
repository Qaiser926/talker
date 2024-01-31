import '../database.dart';

class SeamstressTable extends SupabaseTable<SeamstressRow> {
  @override
  String get tableName => 'Seamstress';

  @override
  SeamstressRow createRow(Map<String, dynamic> data) => SeamstressRow(data);
}

class SeamstressRow extends SupabaseDataRow {
  SeamstressRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => SeamstressTable();

  int get id => getField<int>('id')!;
  set id(int value) => setField<int>('id', value);

  DateTime get createdAt => getField<DateTime>('created_at')!;
  set createdAt(DateTime value) => setField<DateTime>('created_at', value);
}
