import 'package:aqueduct/aqueduct.dart';
import 'package:heroes/heroes.dart';
import 'package:heroes/model/hero.dart';

class HeroesController extends ResourceController {

  HeroesController(this.context);

  final ManagedContext context;

  @Operation.get()
  Future<Response> getAllHeroes({@Bind.query('name') String name}) async {
    final heroQuery = Query<Hero>(context);
    if(name != null) {
      heroQuery.where((hero) => hero.name).contains(name, caseSensitive: false);
    }
    final heroes = await heroQuery.fetch();

    return Response.ok(heroes);
  }

  @Operation.get('id')
  Future<Response> getHeroByID(@Bind.path('id') int id) async {
    final heroQuery = Query<Hero>(context)
      ..where((hero) => hero.id).equalTo(id);
    final hero = await heroQuery.fetchOne();

    if (hero == null) {
      return Response.notFound();
    }

    return Response.ok(hero);
  }

  @Operation.post()
  Future<Response> createHero(@Bind.body() Hero newHero) async {
    final heroQuery = Query<Hero>(context)
      ..values = newHero;
    final insertedHero = await heroQuery.insert();
    
    if(insertedHero == null) {
      return Response.forbidden();
    }
    
    return Response.ok(insertedHero);
  }

  @Operation.delete('id')
  Future<Response> deleteHero(@Bind.path('id') int id) async {
    final heroQuery = Query<Hero>(context)
      ..where((hero) => hero.id).equalTo(id);

    await heroQuery.delete();

    return Response.accepted();
  }

}
