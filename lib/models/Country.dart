class Country {
  String id;
  String name;
  String flag;
  String continent;

  Country({ String id, String name, String flag, String continent }) {
    this.id = id != null ? id : '';
    this.name = name;
    this.flag = flag;
    this.continent = continent;
  }

  Map<String, dynamic> toMap() {
    return {
      'id': '${this.id}',
      'name': '${this.name}',
      'flag': '${this.flag}',
      'continent': '${this.continent}',
    };
  }
}
