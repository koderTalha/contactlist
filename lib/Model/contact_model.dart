class CONTACT {
  final int id;
  final String name;
  final String number;

  CONTACT({required this.id, required this.name, required this.number});

  Map<String, dynamic> toMap(){
    return{
      'id':id,
      'name': name,
      'number':number,
    };
  }
}
