import 'dart:math';

import 'package:energiapp/components/device_location_input.dart';
import 'package:energiapp/components/error_snackbar.dart';
import 'package:energiapp/core/models/device_form_data.dart';
import 'package:energiapp/core/providers/device_list_provider.dart';
import 'package:energiapp/core/services/auth/auth_state_firebase_service.dart';
import 'package:energiapp/utils/validators/device_form_validator.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class DeviceFormWidget extends StatefulWidget {
  // TODO: Aproveitar o mesmo form pra atualizar, pra isso basta adicionar um DeviceModel que irá receber opcionalmente, caso não seja nulo, o formulário irá aparecer os valores recebidos, e o botão ao invés de adicionar, terá atualizar. Pode se basear no Shopping App da Udemy.
  const DeviceFormWidget({super.key});

  @override
  State<DeviceFormWidget> createState() => _DeviceFormWidgetState();
}

class _DeviceFormWidgetState extends State<DeviceFormWidget> {
  final _formKey = GlobalKey<FormState>();
  final _formData = DeviceFormData();
  bool _isLoading = false;
  final _macController = TextEditingController();
  // variavel que vai retornar um LatLng do google maps API
  LatLng? _pickedPosition;

  void _selectPosition(LatLng position) {
    if (mounted) setState(() => _pickedPosition = position);
  }

  @override
  void dispose() {
    super.dispose();
    _macController.dispose();
  }

  Future<void> _submitForm() async {
    // 1 - Validar o Formulário, se não tiver válido vai fazer mais nada
    final isValid = _formKey.currentState?.validate() ?? false;
    if (!isValid) return;
    if (_pickedPosition == null) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.red,
            title: const Text(
              'Erro',
              style: TextStyle(color: Colors.white),
            ),
            content: const Text(
              'Falta preencher a localização do dispositivo. \nVocê pode pegar sua localização atual ou buscar uma localização no mapa',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            actions: [
              TextButton(
                child: const Text(
                  'FECHAR',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          );
        },
      );
      // ErrorSnackbar.show(context, 'Preencha a localização');
      return;
    }
    // 2 - Pegar o user que tá logado agora
    if (mounted) setState(() => _isLoading = true);
    final user = await Provider.of<AuthStateFirebaseService>(
      context,
      listen: false,
    ).loggedUserData;
    // 3 - Criar dispositivo com base nos dados enviados pelo Formulário
    await Provider.of<DeviceListProvider>(
      context,
      listen: false,
    ).createDevice(
      _formData.name,
      _formData.macAdress,
      _pickedPosition!,
      user!,
    );
    if (mounted)
      setState(() {
        _isLoading = false;
        _formKey.currentState?.reset();
        _pickedPosition = null;
        Navigator.of(context).pop();
      });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            Container(
              margin: const EdgeInsets.symmetric(vertical: 20),
              child: Text(
                'Detalhes do Dispositivo',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ),
            Container(
              margin: const EdgeInsets.all(12),
              width: double.infinity,
              constraints: const BoxConstraints(maxWidth: 600),
              child: TextFormField(
                controller: _macController,
                decoration: const InputDecoration(
                  labelText: 'ID do dispositivo',
                  counterText: "", //não aparecer o contador
                ),
                keyboardType: TextInputType.text,
                showCursor: false,
                maxLength: 17, // Considerando os dois pontos da máscara
                onChanged: (value) {
                  /**
                   *! Remove caracteres não permitidos em endereços MAC:
                   *! ^: Dentro dos colchetes ([]), o ^ representa a negação. Ou seja, a expressão regular está procurando por caracteres que NÃO estão na lista especificada.
                   *! a-fA-F0-9: Esta é a lista de caracteres permitidos na expressão regular. Isso inclui letras minúsculas de 'a' a 'f', letras maiúsculas de 'A' a 'F' e os dígitos de '0' a '9'.
                   *! Portanto, a expressão regular [^a-fA-F0-9] coincide com qualquer caractere que não seja uma letra minúscula de 'a' a 'f', uma letra maiúscula de 'A' a 'F' ou um dígito de '0' a '9'. A função replaceAll substitui todos esses caracteres por uma string vazia, efetivamente removendo-os do valor original.

                   *! Essa substituição é usada para garantir que o valor de value contenha apenas caracteres válidos para um endereço MAC (dígitos hexadecimais) antes de aplicar a máscara. Isso ajuda a evitar que caracteres inválidos sejam incluídos no resultado final.
                   */
                  value = value.replaceAll(RegExp(r'[^a-fA-F0-9]'), '');
                  // Adiciona a máscara
                  if (value.length > 2) {
                    value =
                        '${value.substring(0, 2)}-${value.substring(2, min(value.length, 4))}${value.length > 4 ? '-${value.substring(4, min(value.length, 6))}' : ''}${value.length > 6 ? '-${value.substring(6, min(value.length, 8))}' : ''}${value.length > 8 ? '-${value.substring(8, min(value.length, 10))}' : ''}${value.length > 10 ? '-${value.substring(10, min(value.length, 12))}' : ''}';
                  }
                  /**
                   *! Atualiza o texto no controlador
                   *! garante que o valor do TextEditingController seja atualizado com o novo texto (após aplicar a máscara) e que o cursor permaneça no final do texto. Essa técnica é comumente usada ao manipular dinamicamente o texto em um campo de texto no Flutter.
                   */
                  _macController.value = _macController.value.copyWith(
                    text: value,
                    selection: TextSelection.collapsed(offset: value.length),
                  );

                  _formData.macAdress = _macController.text;
                },
                validator: (value) {
                  final String mac = value ?? '';
                  return DeviceFormValidator().macValidator(mac);
                },
              ),
            ),
            Container(
              margin: const EdgeInsets.all(12),
              width: double.infinity,
              constraints: const BoxConstraints(maxWidth: 600),
              child: TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Apelido do dispositivo',
                ),
                onChanged: (value) => _formData.name = value,
                validator: (value) {
                  final String name = value ?? '';
                  return DeviceFormValidator().nameValidator(name);
                },
              ),
            ),
            const SizedBox(height: 30),
            // passando como parametro o método que vai atribuir ao pickedposition
            // o valor retornado da API do google maps
            DeviceLocationInput(onSelectPosition: _selectPosition),
            const SizedBox(height: 30),
            _isLoading
                ? const SizedBox(
                    height: 60,
                    width: 60,
                    child: CircularProgressIndicator(),
                  )
                : Container(
                    margin: const EdgeInsets.all(12),
                    width: double.infinity,
                    height: 60,
                    constraints: const BoxConstraints(maxWidth: 600),
                    child: ElevatedButton.icon(
                      icon: const Icon(Icons.add_circle),
                      label: const Text(
                        'Adicionar Dispositivo',
                        style: TextStyle(fontSize: 20),
                      ),
                      onPressed: () => _submitForm(),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
