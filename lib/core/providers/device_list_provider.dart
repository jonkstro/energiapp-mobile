import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:energiapp/core/models/device_model.dart';
import 'package:energiapp/core/models/user_model.dart';
import 'package:energiapp/utils/location_util.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class DeviceListProvider with ChangeNotifier {
  final String _userId;
  List<DeviceModel> _items = [];
  // Vamos receber no create do Provider no main o userId
  DeviceListProvider([
    this._userId = '',
    this._items = const [],
  ]);

  List<DeviceModel> get items => [..._items];

  int get itemsCount => _items.length;

  Future<void> loadDevices() async {
    // 1 - Limpar a lista para não carregar várias vezes
    _items.clear();
    // 2 - Carregar os dispositivos do Firestore
    final store = FirebaseFirestore.instance;
    // filtrando só os que tem o campo userId igual o que estamos recebendo do main
    final docRef = store.collection('devices').where(
          'userId',
          isEqualTo: _userId,
        );
    final doc = await docRef.get();
    final data = doc.docs.map((e) {
      print('e.data()');
      print(e.data());
      // TODO: Ver o que tá retornando do map, pra poder adicionar novo Device no _items.add(Device(id:...))
    }).toList();
    print('data:');
    print(data);
    notifyListeners();
  }

  // Método que vai salvar no Firestore o dispositivo
  Future<DeviceModel> _saveDeviceOnFirestore(DeviceModel device) async {
    final store = FirebaseFirestore.instance;
    final docId = device.macAdress;
    // 1 - Adicionar o dispositivo no Firestore
    final docRef = store.collection('devices').doc(docId).withConverter(
          fromFirestore: _fromFirestore,
          toFirestore: _toFirestore,
        );
    await docRef.set(device);
    final doc = await docRef.get();
    return doc.data()!;
  }

  // Criar o dispositivo para depois salvar no Firestore, conforme dados do form
  Future<void> createDevice(
    String name,
    String macAdress,
    LatLng position,
    UserModel user,
  ) async {
    // 1 - Definindo o dispositivo conforme os dados que recebemos do Form
    final device = DeviceModel(
      id: Random().nextDouble().toString(),
      name: name,
      macAdress: macAdress,
      location: DeviceLocation(
          adress: await LocationUtil.getAdressFrom(position),
          latitude: position.latitude,
          longitude: position.longitude),
      user: user,
      createdAt: DateTime.now(),
    );
    // 2 - Salvar ele no firestore
    final data = await _saveDeviceOnFirestore(device);
    // 3 - Adicionar na lista local o dado salvo
    _items.add(data);
    notifyListeners();
  }

  // TODO: Criar método de atualizar dispositivo existente
  // TODO: Criar método de deletar dispositivo existente

  //! Métodos de conversão do/para o Firestore
  // Método de como vai ser convertido pra enviar pro Firestore
  Map<String, dynamic> _toFirestore(
    DeviceModel device,
    SetOptions? options,
  ) {
    return {
      'id': device.id,
      'name': device.name,
      'macAdress': device.macAdress,
      'adress': device.location?.adress,
      'latitude': device.location?.latitude,
      'longitude': device.location?.longitude,
      'userId': device.user.id,
      'userName': device.user.name,
      'userEmail': device.user.email,
      'createdAt': device.createdAt.toIso8601String(),
    };
  }

  // Receber Map do Firebase e converter pro objeto que vai ser usado
  DeviceModel _fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> doc,
    SnapshotOptions? options,
  ) {
    final data = doc.data()!;
    return DeviceModel(
      id: doc.id,
      name: data['name'],
      macAdress: data['macAdress'],
      user: UserModel(
        id: data['userId'],
        name: data['userName'],
        email: data['userEmail'],
      ),
      createdAt: DateTime.parse(data['createdAt']),
    );
  }
}

/**
 * void addPlace(
    String title,
    File image,
    LatLng position,
  ) async {
    *!String address = await LocationUtil.getAdressFrom(position);
    final newPlace = Place(
       id: Random().nextDouble().toString(),
      title: title,
      image: image,
      *!location: PlaceLocation(
        *!address,
        *!latitude: position.latitude,
        *!longitude: position.longitude,
      ),
    );

    _items.add(newPlace);
    // Adicionar no SQLite
    DbUtil.insert(Constantes.tbName, {
      'id': newPlace.id,
      'title': newPlace.title,
      // Vamos adicionar só o path da imagem que já tá salvo na pasta do projeto
      'image': newPlace.image.path,
      'lat': position.latitude,
      'lng': position.longitude,
      'address': address,
    });
    notifyListeners();
  }
 */

/**
 * // ignore_for_file: public_member_api_docs, sort_constructors_first, no_leading_underscores_for_local_identifiers
*!  import 'dart:convert';
*!  import 'dart:math';
*!  
*!  import 'package:flutter/material.dart';
*!  import 'package:http/http.dart' as http;
*!  
*!  import 'package:shop/exceptions/http_exception.dart';
*!  import 'package:shop/models/product.dart';
*!  import 'package:shop/utils/constants.dart';
*!  
*!  class ProductList with ChangeNotifier {
*!    final String _token;
*!    final String _userId;
*!    // Não vamos mais iniciar mockado, pois agora vai ser pego do backend
*!    // final List<Product> _items = dummyProducts;
*!    List<Product> _items = [];
*!    ProductList([
*!      this._token = '',
*!      this._userId = '',
*!      this._items = const [],
*!    ]);
*!  
*!    List<Product> get items => [..._items];
*!    List<Product> get favoriteItems =>
*!        _items.where((prod) => prod.isFavorite).toList();
*!    int get itemsCount {
*!      return items.length;
*!    }
*!  
*!    // Carregar os produtos do backend. Esse método vai ser chamado na página inicial de
*!    // produtos: ProductsOverviewPage.
*!    Future<void> loadProducts() async {
*!      // limpar a lista de produtos antes de carregar pra evitar que duplique
*!      _items.clear();
*!  
*!      final response = await http.get(
*!        Uri.parse(
*!          '${Constants.BASE_URL}/produtos.json?auth=$_token',
*!        ),
*!      );
*!      // Vai dar dump se vier vazio no firebase
*!      if (response.body == 'null') return;
*!  
*!      // Vamos pegar os favoritos pelo userId
*!      final favResponse = await http.get(
*!        Uri.parse(
*!          '${Constants.BASE_URL}/userFavorite/$_userId.json?auth=$_token',
*!        ),
*!      );
*!      // Vamos listar os ids dos produtos favoritos marcados pelo userId
*!      // Se firebase retornar 'null' vai botar vazio
*!      Map<String, dynamic> _favData =
*!          favResponse.body == 'null' ? {} : jsonDecode(favResponse.body);
*!  
*!      Map<String, dynamic> data = jsonDecode(response.body);
*!      data.forEach((productId, productData) {
*!        final _isFavorite = _favData[productId] ?? false;
*!        // Vou adicionar na lista vazia os itens do backend que vai ser carregado
*!        _items.add(
*!          Product(
*!            id: productId,
*!            name: productData['name'],
*!            description: productData['description'],
*!            //Se vier int ele parseia pra double evitando quebrar a aplicação
*!            price: double.parse(productData['price'].toString()),
*!            imageUrl: productData['imageUrl'],
*!            isFavorite: _isFavorite,
*!          ),
*!        );
*!      });
*!      notifyListeners();
*!    }
*!  
*!    // Adicionar com base no formData da ProductFormPage
*!    Future<void> saveProduct(Map<String, Object> data) {
*!      bool hasId = data['id'] != null;
*!  
*!      final product = Product(
*!        id: hasId ? data['id'] as String : Random().nextDouble().toString(),
*!        name: data['name'] as String,
*!        description: data['description'] as String,
*!        price: data['price'] as double,
*!        imageUrl: data['imageUrl'] as String,
*!      );
*!  
*!      if (hasId) {
*!        // Vai retornar um Future<void> do método que tá chamando
*!        return updateProduct(product);
*!      } else {
*!        // Vai retornar um Future<void> do método que tá chamando
*!        return addProduct(product);
*!      }
*!    }
*!  
*!    Future<void> addProduct(Product product) async {
*!      // await vai esperar esse método até receber uma resposa
*!      final response = await http.post(
*!        // Obs.: Deve sempre ter ".json" no final senão o FIREBASE dá erro.
*!        // Outros backend (ex.: sprintboot) precisa não adicionar o ".json" no final.
*!        Uri.parse('${Constants.BASE_URL}/produtos.json?auth=$_token'),
*!        body: jsonEncode(
*!          {
*!            'name': product.name,
*!            'description': product.description,
*!            'price': product.price,
*!            'imageUrl': product.imageUrl,
*!          },
*!        ),
*!      );
*!  
*!      // O id criado pelo o firebase tá vindo como 'name'
*!      final id = jsonDecode(response.body)['name'];
*!      _items.add(
*!        // Adicionar em memória um produto identico ao do firebase
*!        Product(
*!          id: id,
*!          name: product.name,
*!          description: product.description,
*!          price: product.price,
*!          imageUrl: product.imageUrl,
*!        ),
*!      );
*!      notifyListeners();
*!    }
*!  
*!    Future<void> updateProduct(Product product) async {
*!      // Se não achar o indice ele retorna index = -1
*!      int index = _items.indexWhere((element) => element.id == product.id);
*!      if (index >= 0) {
*!        // método patch vai atualizar só o que tá sendo passado.
*!        // testar se o put funciona no backend do spring validando campos vazios
*!        await http.patch(
*!          // Obs.: Deve sempre ter ".json" no final senão o FIREBASE dá erro.
*!          // Outros backend (ex.: sprintboot) precisa não adicionar o ".json" no final.
*!          Uri.parse(
*!              '${Constants.BASE_URL}/produtos/${product.id}.json?auth=$_token'),
*!          body: jsonEncode(
*!            {
*!              'name': product.name,
*!              'description': product.description,
*!              'price': product.price,
*!              'imageUrl': product.imageUrl,
*!            },
*!          ),
*!        );
*!  
*!        // se for maior que -1 então é válido, logo atualizará pro product
*!        _items[index] = product;
*!        notifyListeners();
*!      }
*!    }
*!  
*!    Future<void> removeProduct(Product product) async {
*!      // Se não achar o indice ele retorna index = -1
*!      int index = _items.indexWhere((element) => element.id == product.id);
*!      if (index >= 0) {
*!        final Product product = _items[index];
*!        // primeiro vamos remover da lista, pra depois remover do backend. se der problema
*!        // no backend a gente adiciona o elemento de volta
*!        _items.remove(product);
*!        notifyListeners();
*!        final response = await http.delete(
*!          // Obs.: Deve sempre ter ".json" no final senão o FIREBASE dá erro.
*!          // Outros backend (ex.: sprintboot) precisa não adicionar o ".json" no final.
*!          Uri.parse(
*!              '${Constants.BASE_URL}/produtos/${product.id}.json?auth=$_token'),
*!        );
*!  
*!        // Se der algum erro no backend, vamos reinserir o item removido na mesma posição de antes
*!        if (response.statusCode >= 400) {
*!          _items.insert(index, product);
*!          notifyListeners();
*!          // vai estourar essa exception personalizada lá no componente product item
*!          throw HttpException(
*!            msg: "Não foi possível excluir o item: ${response.body}",
*!            statusCode: response.statusCode,
*!          );
*!        }
*!      }
*!    }
*!  }

 */
