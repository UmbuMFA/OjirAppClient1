<<<<<<< HEAD
class PlacePredictions {
  String? secondary_text;
  String? main_text;
  String? place_id;

  PlacePredictions({this.secondary_text, this.main_text, this.place_id});

  PlacePredictions.fromJson(Map<String, dynamic> json) {
=======
class PlacePredictions
{
  String secondary_text;
  String main_text;
  String place_id;

  PlacePredictions({this.secondary_text, this.main_text, this.place_id});

  PlacePredictions.fromJson(Map<String, dynamic> json)
  {
>>>>>>> 5c0bd2cd30637bd8042f6668b7b79d3af25aedff
    place_id = json["place_id"];
    main_text = json["structured_formatting"]["main_text"];
    secondary_text = json["structured_formatting"]["secondary_text"];
  }
<<<<<<< HEAD
}
=======
}
>>>>>>> 5c0bd2cd30637bd8042f6668b7b79d3af25aedff
