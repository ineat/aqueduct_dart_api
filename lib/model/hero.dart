import 'package:heroes/heroes.dart';

class Hero extends ManagedObject<_Hero> implements _Hero {}

class _Hero {
  @primaryKey
  int id;

  @Column(unique: true)
  String name;

  @Column()
  String real_name;

  @Column()
  String description;

  @Column()
  String thumb;

  @Column()
  String img;

}