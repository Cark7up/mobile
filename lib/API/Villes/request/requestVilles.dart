class RequestVille {
  //creation d'une requette argument
  final String name;

  const RequestVille({required this.name}); // instencier l'id de l'app steam

  Map<String, dynamic> toMap() {
    //argument appler pour la requette
    final querryParameters = {
      'name': '$name',
      'count': '10',
      'language' : 'fr',
      'format':'json'
    };
    return querryParameters;
  }

  String getName() {
    return name;
  }
}