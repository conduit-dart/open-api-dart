// Copyright (c) 2017, joeconway. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:convert';
import 'dart:io';

import 'package:conduit_open_api/v2.dart';
import 'package:dcli/dcli.dart';
import 'package:test/test.dart';

void main() {
  group("Petstore spec", () {
    APIDocument? doc;
    Map<String, dynamic>? original;

    setUpAll(() {
      /// download sample api document if we don't already have it.
      final String config = fetchPetStoreExample();
      final file = File(config);
      final contents = file.readAsStringSync();
      original = json.decode(contents) as Map<String, dynamic>;
      doc = APIDocument.fromMap(original!);
    });

    test("Has all metadata", () {
      expect(doc!.version, "2.0");
      expect(doc!.info!.title, "Swagger Petstore");
      expect(doc!.info!.version, '1.0.0');
      expect(doc!.host, "petstore.swagger.io");
      expect(doc!.basePath, "/v1");
      expect(doc!.tags, isNull);
      expect(doc!.schemes!.first, "http");
    });

    test("Confirm top-level objects", () {
      expect(original!.containsKey("consumes"), true);
      expect(doc!.consumes!.first, "application/json");

      expect(original!.containsKey("produces"), true);
      expect(doc!.produces!.first, "application/json");
    });

    test("Has paths", () {
      expect(doc!.paths!.length, greaterThan(0));
      expect(doc!.paths!.length, original!["paths"].length);

      final Map<String, dynamic> originalPaths =
          original!["paths"] as Map<String, dynamic>;
      doc!.paths!.forEach((k, v) {
        expect(originalPaths.keys.contains(k), true);
      });
    });

    // test("Sample - Namespace", () {
    //   final namespacePath = doc!.paths!["/api/v1/namespaces"];

    //   final getNamespace = namespacePath!.operations["get"];
    //   expect(getNamespace!.description, contains("of kind Namespace"));
    //   expect(getNamespace.consumes, ["*/*"]);
    //   expect(getNamespace.produces, contains("application/json"));
    //   expect(getNamespace.produces, contains("application/yaml"));
    //   expect(getNamespace.parameters!.length, 8);
    //   expect(
    //       getNamespace.parameters!
    //           .firstWhere((p) => p!.name == "limit")!
    //           .location,
    //       APIParameterLocation.query);
    //   expect(
    //       getNamespace.parameters!.firstWhere((p) => p!.name == "limit")!.type,
    //       APIType.integer);
    //   expect(getNamespace.responses!.keys, contains("401"));
    //   expect(getNamespace.responses!.keys, contains("200"));

    //   final postNamespace = namespacePath.operations["post"];
    //   expect(postNamespace!.parameters!.length, 1);
    //   expect(postNamespace.parameters!.first!.name, "body");
    //   expect(
    //       postNamespace.parameters!.first!.location, APIParameterLocation.body);
    // });

    // test("Sample - Reference", () {
    //   final apiPath = doc!.paths!["/api/"];
    //   final apiPathGet = apiPath!.operations["get"];
    //   final response = apiPathGet!.responses!["200"];
    //   final schema = response!.schema;
    //   expect(schema!.description, contains("APIVersions lists the"));
    //   expect(schema.isRequired, ["versions", "serverAddressByClientCIDRs"]);
    //   expect(
    //       schema.properties!["serverAddressByClientCIDRs"]!.items!
    //           .properties!["clientCIDR"]!.description,
    //       contains("The CIDR"));
    // });

    test("Can encode as JSON", () {
      expect(json.encode(doc!.asMap()), isA<String>());
    });
  });
}

String fetchPetStoreExample() {
  const config = "test/specs/petstore-simple.json";
  if (!exists(config)) {
    if (!exists(dirname(config))) {
      createDir(dirname(config), recursive: true);
    }

    fetch(
        url:
            'https://raw.githubusercontent.com/OAI/OpenAPI-Specification/0f9d3ec7c033fef184ec54e1ffc201b2d61ce023/examples/v2.0/json/petstore.json',
        saveToPath: config);
  }
  return config;
}
