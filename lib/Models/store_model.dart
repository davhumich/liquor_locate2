/*

Model for a Store

*/

class Store {

  String id = "";
  String name = "";
  String address = "";
  double rating = 0;
  String logoString = "";
  
  Store(this.id, this.name, this.address, this.rating, this.logoString);

  Store.empty();
}