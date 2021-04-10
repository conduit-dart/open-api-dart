# 1.0.0-b4
fix empty v3 path

# 1.0.0-b3
Improved the readme.
Merge branch 'master' of https://github.com/noojee/open-api-dart-1
Merge remote-tracking branch 'upstream/master'
NNBD (#1)
replace travis with github actions
work on nndb migration and migration to conduit_codable (#1)

# 1.0.0-b2
restored the kubenetes test file as we found a v2 version. reverted some fields to be nullable as the document uses null to know that they were not present in the original document.
Remove the curl commands as the unit tests now fetch the required files themselves.
changed components so that they return a non-nullable list.

# 1.0.0-b1
Completed work on migrating to conduit_codable and nnbd migration.
Added lint package and resolved all automated fixes.
renamed project to conduit_open_api
nnbd migration
# Changelog

## 2.0.1

- Fix bug when merging APIResponse bodies

# 2.0.0

- Update for Dart 2

## 1.0.2

- Adds `APIResponse.addHeader` and `APIResponse.addContent`.
- Adds `APIOperation.addResponse`.

## 1.0.1 

- Adds `APISchemaObject.isFreeForm` and related support for free-form schema objects.

## 1.0.0

- Adds support for OpenAPI 3.0
- Splits Swagger (2.0) and OpenAPI (3.0) into 'package:conduit_open_api/v2.dart' and 'package:conduit_open_api/v3.dart'.

## 0.9.1

- Moves shared properties from `APISchema`, `APIHeader` and `APIParameter` into `APIProperty`.

## 0.9.0

- Initial data structures
- Parsing specifications
- Writing specifications to disk
