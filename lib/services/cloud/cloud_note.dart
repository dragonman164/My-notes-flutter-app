import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:mynotes/services/cloud/cloud_storage_constants.dart';

@immutable
class CloudNote {
  final String documentId;
  final String ownerId;
  final String text;

  CloudNote({
required this.documentId,
    required this.ownerId,
    required this.text
  });

  CloudNote.fromSnapshot (QueryDocumentSnapshot<Map<String,dynamic>> snapshot) : documentId = snapshot.id,
  ownerId = snapshot.data()[ownerUserIdFieldName],
  text = snapshot.data()[textFieldName] as String;


}