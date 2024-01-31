import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class TachesAFaireRecord extends FirestoreRecord {
  TachesAFaireRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "Tache" field.
  String? _tache;
  String get tache => _tache ?? '';
  bool hasTache() => _tache != null;

  void _initializeFields() {
    _tache = snapshotData['Tache'] as String?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('TachesAFaire');

  static Stream<TachesAFaireRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => TachesAFaireRecord.fromSnapshot(s));

  static Future<TachesAFaireRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => TachesAFaireRecord.fromSnapshot(s));

  static TachesAFaireRecord fromSnapshot(DocumentSnapshot snapshot) =>
      TachesAFaireRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static TachesAFaireRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      TachesAFaireRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'TachesAFaireRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is TachesAFaireRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createTachesAFaireRecordData({
  String? tache,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'Tache': tache,
    }.withoutNulls,
  );

  return firestoreData;
}

class TachesAFaireRecordDocumentEquality
    implements Equality<TachesAFaireRecord> {
  const TachesAFaireRecordDocumentEquality();

  @override
  bool equals(TachesAFaireRecord? e1, TachesAFaireRecord? e2) {
    return e1?.tache == e2?.tache;
  }

  @override
  int hash(TachesAFaireRecord? e) => const ListEquality().hash([e?.tache]);

  @override
  bool isValidKey(Object? o) => o is TachesAFaireRecord;
}
