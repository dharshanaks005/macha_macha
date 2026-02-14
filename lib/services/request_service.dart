
import 'package:cloud_firestore/cloud_firestore.dart';

Future<String?> acceptRequest(String requestId, String helperId) async {
  final firestore = FirebaseFirestore.instance;

  return await firestore.runTransaction((transaction) async {

    final requestRef = firestore.collection('requests').doc(requestId);
    final requestSnap = await transaction.get(requestRef);

    if (!requestSnap.exists) return null;

    final data = requestSnap.data()!;
    
    if (data['status'] != 'open') {
      return null; // Someone already accepted
    }

    // Create session
    final sessionRef = firestore.collection('sessions').doc();

    transaction.set(sessionRef, {
      'userA': data['createdBy'],  // requester
      'userB': helperId,
      'status': 'active',
      'startedAt': FieldValue.serverTimestamp(),
    });

    // Update request
    transaction.update(requestRef, {
      'status': 'accepted',
      'sessionId': sessionRef.id,
    });

    return sessionRef.id;
  });
}
