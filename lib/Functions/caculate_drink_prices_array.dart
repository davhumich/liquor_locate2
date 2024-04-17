
import 'package:cloud_firestore/cloud_firestore.dart';

Future<List<double>> calculateDrinkPricesArray(String storeId) async {
  List<double> result = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];

  try {
        CollectionReference storesCollection = FirebaseFirestore.instance.collection('stores');
        DocumentSnapshot storeSnapshot = await storesCollection.doc(storeId).get();

        if (storeSnapshot.exists){
          result[0] = storeSnapshot['13Dclb3TMT1SgvVhLvnc'];
          result[1] = storeSnapshot['W5T0nl1jl45PMJffT7cP'];
          result[2] = storeSnapshot['Gjhxk23V6qZcwcJ8wi1Z'];
          result[3] = storeSnapshot['YfMF5XRlpm4LeDD9QFMu'];
          result[4] = storeSnapshot['HtBmjQGzhkHgD9WsR4Ht'];
          result[5] = storeSnapshot['jW1i3p0oNxz1IOiho1fl'];
          result[6] = storeSnapshot['xrZkvU4vkCLWz91huRW5'];
          result[7] = storeSnapshot['ALqxPbKR8OXZe7CRylO8'];
          result[8] = storeSnapshot['ArZ8dTSTcX5sfpxJhU8a'];
          result[9] = storeSnapshot['1lZPqTgMU15vPvOJywpD'];
          result[10] = storeSnapshot['RP2q71xhh6QrG4cOlnpq'];
          result[11] = storeSnapshot['sVTpE9VDB5edoudNQzUS'];
          result[12] = storeSnapshot['SANgPYCI0LkghwxqyRI1'];
          result[13] = storeSnapshot['oFSlBdobrnWAEi40XUIr'];
          result[14] = storeSnapshot['KgZMoroAxbA0XXGiBfSV'];
          result[15] = storeSnapshot['gWuSEH0CzDc9h491QmqI'];
          result[16] = storeSnapshot['u4PcjL0KC6OjihjnZtr7'];
          result[17] = storeSnapshot['bstkeb39hJ5iqYTWpHr6'];
          result[18] = storeSnapshot['IrMra8Cp7jlW7BMZQkVr'];
          result[19] = storeSnapshot['mHM3LOKLY3s7Wmh6ysrU'];
          result[20] = storeSnapshot['neam3wZ3sVcjVlAN5Pgd'];
          result[21] = storeSnapshot['AAhGJlhtkb0AAnp0MZeG'];
          result[22] = storeSnapshot['Nit5WaNkChWOfnjZJfzO'];
          result[23] = storeSnapshot['3accKb2rEFJvIkS0eYmc'];
          result[24] = storeSnapshot['8jIpblH2mxOccI58tKhz'];
          result[25] = storeSnapshot['QDTvdIoOlyaXzCwETTjg'];
          result[26] = storeSnapshot['Qrd0hEeRZNXL9dg5xxDi'];
          result[27] = storeSnapshot['t6orNtRpysTVQyn0FtNH'];
          result[28] = storeSnapshot['NmGy4LfF8EAM6DQAet8J'];
          result[29] = storeSnapshot['bRONeb54f28MDSIsMVJk'];
          result[30] = storeSnapshot['SmdOkwqS0JSGbkAhnhCB'];
          result[31] = storeSnapshot['vDLJxRSsABWLOsjcmGmx'];
          result[32] = storeSnapshot['mwfip1nPOrdCtVieyqLH'];
          result[33] = storeSnapshot['0dKoM86iz9hgAPWwZnwo'];
          result[34] = storeSnapshot['k5lmSKHThSFSTPKTwrxb'];
          result[35] = storeSnapshot['koivmG60qEQdYao0NAF6'];
          print(result);
        }
        else{
            return [];
        }

    }
    catch(e){
        return [];
    }

    return result;
  
}