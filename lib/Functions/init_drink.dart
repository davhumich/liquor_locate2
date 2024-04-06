
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:liquor_locate2/Models/drink_model.dart';

Future<List<Drink>> initDrinks () async {
    List<Drink> drinks = [];
    try {
        final QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('drinks').get();

        for (var doc in querySnapshot.docs) {

        String id = doc.id;
        String img = doc['img'];
        String name = doc['Name'];
        String size = doc['Size'];

      
          drinks.add(Drink(id, size, img, name)); 
        }
    }
    catch(e){
       print('Error fetching drinks: $e');
    }
    return drinks;

           
}