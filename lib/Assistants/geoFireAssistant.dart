<<<<<<< HEAD
import 'package:rider_app/Models/nearbyAvailableDrivers.dart';
=======
import 'package:ojir_clientapp/Models/nearbyAvailableDrivers.dart';
>>>>>>> 5c0bd2cd30637bd8042f6668b7b79d3af25aedff

class GeoFireAssistant
{
  static List<NearbyAvailableDrivers> nearByAvailableDriversList = [];

  static void removeDriverFromList(String key)
  {
    int index = nearByAvailableDriversList.indexWhere((element) => element.key == key);
    nearByAvailableDriversList.removeAt(index);
  }

  static void updateDriverNearbyLocation(NearbyAvailableDrivers driver)
  {
    int index = nearByAvailableDriversList.indexWhere((element) => element.key == driver.key);

    nearByAvailableDriversList[index].latitude = driver.latitude;
    nearByAvailableDriversList[index].longitude = driver.longitude;
  }
}