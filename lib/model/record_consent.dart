class consent_record{
  int id;
  String uuid;
  bool val;
  String name;
  String description;
  bool primary;

  consent_record({
    required this.id,
    required this.uuid,
    required this.val,
    required this.name,
    required this.description,
    required this.primary
});
}