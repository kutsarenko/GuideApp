import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:new_guide_app/data/excursion_data.dart';

class DatabaseService {
  CollectionReference excursionCollection =
      FirebaseFirestore.instance.collection("Excursions");

  CollectionReference historyCollection =
      FirebaseFirestore.instance.collection("History");

  CollectionReference typeOfExcursion = FirebaseFirestore.instance.collection("Type of Excursion");

  Future createNewExcursion(String excursionType, String date, String time,
      String participantNumbers, String price, String uid) async {
    return await excursionCollection.add({
      "excursionType": excursionType,
      "date": date,
      "time": time,
      "participantNumbers": participantNumbers,
      "price": price,
      "uid": uid,
    });
  }

  Future createNewHistory(String excursionType, String date, String time,
      String participantNumbers, String price, String uid) async {
    return await historyCollection.add({
      "date": date,
      "time": time,
      "excursionType": excursionType,
      "participantNumbers": participantNumbers,
      "price": price,
      "uid": uid,
    });
  }

  Future createNewType(String excursionType, ) async {
    return await typeOfExcursion.add({
      "excursionType": excursionType,
    });
  }

 

  Future moveToHistory(uid) async {
    await historyCollection.add(uid);
    removeExcursion(uid);
  }

  Future removeExcursion(uid) async {
    await excursionCollection.doc(uid).delete();
  }

  Future removeHistory(uid) async {
    await historyCollection.doc(uid).delete();
  }


  List<Excursion> excursionFromFirestore(QuerySnapshot snapshot) {
    if (snapshot != null) {
      return snapshot.docs.map((e) {
        return Excursion(
          excursionType: e.data()["excursionType"],
          date: e.data()["date"],
          time: e.data()["time"],
          participantNumbers: e.data()["participantNumbers"],
          price: e.data()["price"],
          uid: e.id,
          
        );
      }).toList();
    } else {
      return null;
    }
  }


  Stream<List<Excursion>> listExcursion() {
    return excursionCollection.snapshots().map(excursionFromFirestore);
  }

  Stream<List<Excursion>> listHistory() {
    return historyCollection.snapshots().map(excursionFromFirestore);
  }

   Stream<List<Excursion>> listTypes() {
    return excursionCollection.snapshots().map(excursionFromFirestore);
  }
}
