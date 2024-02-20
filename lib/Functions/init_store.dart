
import 'package:cloud_firestore/cloud_firestore.dart';

Future<String> initStore(String storeId) async {
    String storeName;

    try {
        CollectionReference storesCollection = FirebaseFirestore.instance.collection('stores');
        DocumentSnapshot storeSnapshot = await storesCollection.doc(storeId).get();

        if (storeSnapshot.exists){
            storeName = storeSnapshot['Name'];
        }
        else{
            storeName = "Store Not Found";
        }

    }
    catch(e){
        storeName = 'Error initializing store: $e';
        print('Error initializing store: $e');
    }

    return storeName;

}