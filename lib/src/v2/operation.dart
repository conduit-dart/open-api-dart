import 'package:conduit_codable/conduit_codable.dart';
import 'package:conduit_codable/cast.dart' as cast;
import 'package:conduit_open_api/src/object.dart';
import 'package:conduit_open_api/src/v2/parameter.dart';
import 'package:conduit_open_api/src/v2/response.dart';

/// Represents a HTTP operation (a path/method pair) in the OpenAPI specification.
class APIOperation extends APIObject {
  APIOperation();

  @override
  Map<String, cast.Cast> get castMap => {
        "tags": cast.List(cast.string),
        "consumes": cast.List(cast.string),
        "produces": cast.List(cast.string),
        "schemes": cast.List(cast.string),
        "security": cast.List(cast.Map(cast.string, cast.List(cast.string))),
      };

  String summary = "";
  String description = "";
  String id;
  bool deprecated = false;

  List<String> tags = [];
  List<String> schemes = [];
  List<String> consumes = [];
  List<String> produces = [];
  List<APIParameter> parameters = [];
  List<Map<String, List<String>>> security = [];
  Map<String, APIResponse> responses = {};

  void decode(KeyedArchive object) {
    super.decode(object);

    tags = object.decode("tags");
    summary = object.decode("summary");
    description = object.decode("description");
    id = object.decode("operationId");
    consumes = object.decode("consumes");
    produces = object.decode("produces");
    deprecated = object.decode("deprecated") ?? false;
    parameters = object.decodeObjects("parameters", () => APIParameter());
    responses = object.decodeObjectMap("responses", () => APIResponse());
    schemes = object.decode("schemes");
    security = object.decode("security");
  }

  void encode(KeyedArchive object) {
    super.encode(object);

    object.encode("tags", tags);
    object.encode("summary", summary);
    object.encode("description", description);
    object.encode("operationId", id);
    object.encode("consumes", consumes);
    object.encode("produces", produces);
    object.encode("deprecated", deprecated);

    object.encodeObjects("parameters", parameters);
    object.encodeObjectMap("responses", responses);
    object.encode("security", security);
  }
}
