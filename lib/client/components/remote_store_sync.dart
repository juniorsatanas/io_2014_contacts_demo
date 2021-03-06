library contacts.remote_store_sync;

import 'dart:async';
import 'dart:html';

import 'package:io_2014_contacts_demo/client/src/contact.dart';
import 'package:io_2014_contacts_demo/client/src/sync.dart';
import 'package:polymer/polymer.dart';
import 'package:redstone_mapper/mapper.dart';

@CustomTag('remote-store-sync')
class RemoteStoreSync extends PolymerElement implements Sync {

  final String basePath = "/services/contact";

  RemoteStoreSync.created()
      : super.created();

  Future<List<Contact>> load() =>
    HttpRequest.request("$basePath/load")
      .then((HttpRequest req) => decodeJson(req.response, Contact));

  Future<Contact> add(Contact contact) {
    return HttpRequest.request("$basePath/add", method: "POST",
        sendData: encodeJson(contact),
        requestHeaders: {"Content-type": "application/json"}).then((req) {
      return decodeJson(req.response, Contact);
    });
  }

  Future<bool> delete(Contact contact) =>
    HttpRequest.request("$basePath/delete/${contact.id}",
        method: "DELETE").then((HttpRequest req) => req.responseText == "true");

}
