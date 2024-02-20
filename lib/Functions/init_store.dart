
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:liquor_locate2/Models/store_model.dart';

Future<Store> initStore (String storeId) async {
    Store store = Store.empty();
    try {
        CollectionReference storesCollection = FirebaseFirestore.instance.collection('stores');
        DocumentSnapshot storeSnapshot = await storesCollection.doc(storeId).get();

        if (storeSnapshot.exists){
            store.name = storeSnapshot['Name'];
            store.logoString = storeSnapshot["Image"];
            store.rating = storeSnapshot["StarRating"];
            store.address = storeSnapshot["Address"];
        }
        else{
            store.name = "Store Not Found";
        }

    }
    catch(e){
        store.name = 'Error initializing store: $e';
    }
    return store;
}