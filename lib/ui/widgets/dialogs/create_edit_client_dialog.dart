import 'package:flutter/material.dart';
import 'package:moonable/models/cliente_model.dart';
import 'package:provider/provider.dart';

import '../../../providers/conf/imputs_decoration.dart';
import '../../../providers/clients_provider.dart';
import '../../../settings/constants.dart';

class CreateEditClientDialog extends StatefulWidget {
  final Client? client;
  const CreateEditClientDialog({super.key, required this.client});

  @override
  State<CreateEditClientDialog> createState() => _CreateEditClientDialogState();
}

class _CreateEditClientDialogState extends State<CreateEditClientDialog> {
  DateTime birth = DateTime(2005, 1, 1);
  DateTime expiration = DateTime(2023, 1, 1);
  
  Client tmpClient = clienteDummy;
  bool isActive = false;
  List<String> ibans = [];
  String iban = '';
  late bool isDarkMode;
  TextEditingController ibanTextController = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey();

  @override
  void initState() {
    tmpClient = clienteDummy;
    super.initState();
    if (widget.client != null) {
      tmpClient = widget.client!;
    }
    if (tmpClient.ibanWallet.isNotEmpty) {
      ibans = tmpClient.ibanWallet;
    }
    if (tmpClient.tierStatus == 'Approved') {
      isActive = true;
    } else {
      isActive = false;
    }
    
  }

  @override
  Widget build(BuildContext context) {
    if (Theme.of(context).brightness == Brightness.dark) {
      isDarkMode = true;
    } else {
      isDarkMode = false;
    }
    return AlertDialog(
      content: SizedBox(
        height: 450,
        width: 340,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Agregar cliente',
              style: text22Title(context),
            ),
            const SizedBox(height: 30),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(right: 14),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Client type'),
                        const SizedBox(height: 10),
                        DropdownButton(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                          value: tmpClient.clientType,
                          isExpanded: true,
                          underline: Container(),
                          items: const [
                            DropdownMenuItem(
                              value: 'Individual',
                              child: Padding(
                                padding: EdgeInsets.only(left: 8.0),
                                child: Text('Individual'),
                              ),
                            ),
                            DropdownMenuItem(
                                value: 'Business',
                                child: Padding(
                                  padding: EdgeInsets.only(left: 8.0),
                                  child: Text('Business'),
                                )),
                            DropdownMenuItem(
                                value: '',
                                child: Padding(
                                  padding: EdgeInsets.only(left: 8.0),
                                  child: Text('Tipo de cliente'),
                                )),
                          ],
                          onChanged: (value) {
                            setState(() {
                              tmpClient.clientType = value!;
                            });
                          },
                        ),
                        if (tmpClient.clientType != '') ...[
                          if (tmpClient.clientType == 'Individual') ...[
                            const SizedBox(height: 10),
                            TextFormField(
                              initialValue: tmpClient.firstName,
                              decoration: InputsDeco.textFormDeco(
                                  isDarkMode: isDarkMode,
                                  context: context,
                                  label: 'First Name',
                                  icon: Icons.person),
                              onChanged: (value) => tmpClient.firstName = value,
                            ),
                            const SizedBox(height: 10),
                            TextFormField(
                              initialValue: tmpClient.lastName,
                              decoration: InputsDeco.textFormDeco(
                                isDarkMode: isDarkMode,
                                  context: context,
                                  label: 'Last Name',
                                  icon: Icons.assignment_ind),
                              onChanged: (value) => tmpClient.lastName = value,
                            ),
                          ],
                          if (tmpClient.clientType == 'Business') ...[
                            const SizedBox(height: 10),
                            TextFormField(
                              initialValue: tmpClient.businessName,
                              decoration: InputsDeco.textFormDeco(
                                isDarkMode: isDarkMode,
                                  context: context,
                                  label: 'Business Name',
                                  icon: Icons.business),
                              onChanged: (value) =>
                                  tmpClient.businessName = value,
                            ),
                          ],
                          const SizedBox(height: 10),
                          Wrap(
                            crossAxisAlignment: WrapCrossAlignment.center,
                            children: [
                              const SizedBox(width: 40),
                              SizedBox(
                                width: 230,
                                child: TextFormField(
                                  controller: ibanTextController,
                                  decoration: InputsDeco.textFormDeco(
                                    isDarkMode: isDarkMode,
                                      context: context,
                                      label: 'Add Iban/Wallet'),
                                  onChanged: (value) => setState(() {
                                    iban = value;
                                  }),
                                ),
                              ),
                              const SizedBox(width: 10),
                              IconButton(
                                  icon: Icon(
                                    Icons.add,
                                    color: (iban == '') ? null : Colors.green,
                                    size: (iban == '') ? 15 : 30,
                                  ),
                                  onPressed: (iban == '')
                                      ? null
                                      : () => setState(() {
                                            iban = '';
                                            ibans.add(
                                                ibanTextController.value.text);
                                            ibanTextController.clear();
                                          })),
                              if (ibans.isNotEmpty)
                                Column(
                                  children: [
                                    const SizedBox(height: 10),
                                    const Text('Mis Ibans / Wallets'),
                                    const Divider(),
                                    ...ibans
                                        .map(
                                          (e) => Padding(
                                            padding:
                                                const EdgeInsets.only(left: 40),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  children: [
                                                    Text(e),
                                                    const Spacer(),
                                                    IconButton(
                                                        onPressed: () =>
                                                            setState(() {
                                                              ibans.remove(e);
                                                            }),
                                                        icon: Icon(
                                                          Icons.remove,
                                                          color: Colors
                                                              .red.shade300,
                                                        ))
                                                  ],
                                                ),
                                                const Divider()
                                              ],
                                            ),
                                          ),
                                        )
                                        .toList()
                                  ],
                                )
                            ],
                          ),
                          const SizedBox(height: 10),
                          const SizedBox(height: 10),
                          TextFormField(
                            initialValue: tmpClient.countryResidency,
                            decoration: InputsDeco.textFormDeco(
                              isDarkMode: isDarkMode,
                                context: context,
                                label: 'Country resicency',
                                icon: Icons.public),
                            onChanged: (value) => setState(() {
                              tmpClient.countryResidency = value;
                            }),
                          ),
                          const SizedBox(height: 10),
                          TextFormField(
                            initialValue: tmpClient.nationality,
                            decoration: InputsDeco.textFormDeco(
                              isDarkMode: isDarkMode,
                                context: context,
                                label: 'Nationality',
                                icon: Icons.language),
                            onChanged: (value) => setState(() {
                              tmpClient.nationality = value;
                            }),
                          ),
                          const SizedBox(height: 10),
                          SizedBox(
                            width: 300,
                            height: 58,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Birth Date',
                                  style: text10mini(context),
                                ),
                                Row(
                                  children: [
                                    IconButton(
                                      icon: const Icon(Icons.calendar_month),
                                      color: primary(context),
                                      onPressed: () async {
                                        DateTime? newDate =
                                            await showDatePicker(
                                                context: context,
                                                initialDate: birth,
                                                firstDate: DateTime(1900),
                                                lastDate: DateTime(2100));
                                        if (newDate == null) return;

                                        setState(() => tmpClient.birth =
                                            newDate.toString());
                                      },
                                    ),
                                    const SizedBox(width: 10),
                                    Text(tmpClient.birth.toString())
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 10),
                          TextFormField(
                              initialValue: tmpClient.documentNumber,
                              decoration: InputsDeco.textFormDeco(
                                isDarkMode: isDarkMode,
                                  context: context,
                                  label: 'Document Number',
                                  icon: Icons.pregnant_woman_sharp),
                              onChanged: (value) => setState(() {
                                    tmpClient.documentNumber = value;
                                  })),
                          SizedBox(
                            width: 300,
                            height: 58,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Exp Date', style: text10mini(context)),
                                Row(
                                  children: [
                                    IconButton(
                                      icon: const Icon(Icons.calendar_month),
                                      color: primary(context),
                                      onPressed: () async {
                                        DateTime? newDate =
                                            await showDatePicker(
                                                context: context,
                                                initialDate: birth,
                                                firstDate: DateTime(1900),
                                                lastDate: DateTime(2100));
                                        if (newDate == null) return;

                                        setState(() =>
                                            tmpClient.expirationDate =
                                                newDate.toString());
                                      },
                                    ),
                                    const SizedBox(width: 10),
                                    Text(tmpClient.expirationDate)
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 10),
                          TextFormField(
                            initialValue: tmpClient.residenceLand,
                            decoration: InputsDeco.textFormDeco(
                              isDarkMode: isDarkMode,
                                context: context,
                                label: 'Residence Land',
                                icon: Icons.border_right_outlined),
                            onChanged: (value) => setState(() {
                              tmpClient.residenceLand = value;
                            }),
                          ),
                          const SizedBox(height: 10),
                          TextFormField(
                            initialValue: tmpClient.nationalityLand,
                            decoration: InputsDeco.textFormDeco(
                              isDarkMode: isDarkMode,
                                context: context,
                                label: 'Nationality Land',
                                icon: Icons.flight_sharp),
                            onChanged: (value) => setState(() {
                              tmpClient.nationalityLand = value;
                            }),
                          ),
                          const SizedBox(height: 10),
                          TextFormField(
                            initialValue: tmpClient.userAge,
                            decoration: InputsDeco.textFormDeco(
                              isDarkMode: isDarkMode,
                                context: context,
                                label: 'Client Age',
                                icon: Icons.sixty_fps_rounded),
                            onChanged: (value) => setState(() {
                              tmpClient.userAge = value;
                            }),
                          ),
                          const SizedBox(height: 10),
                          TextFormField(
                            initialValue: tmpClient.auxRiesgo,
                            decoration: InputsDeco.textFormDeco(
                              isDarkMode: isDarkMode,
                                context: context,
                                label: 'Auxiliar Riesgo',
                                icon: Icons.electric_rickshaw),
                            onChanged: (value) => setState(() {
                              tmpClient.auxRiesgo = value;
                            }),
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              const SizedBox(width: 40),
                              (isActive)
                                  ? Text('Approved',
                                      style: text14BodyM(context)
                                          .copyWith(color: Colors.green))
                                  : Text('Pending',
                                      style: text14BodyM(context)
                                          .copyWith(color: Colors.orange)),
                              const Spacer(),
                              Switch(
                                activeColor: Colors.green,
                                value: isActive,
                                onChanged: (value) => setState(() {
                                  isActive = value;
                                }),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          DropdownButtonFormField(
                            focusColor: Colors.transparent,
                            value: tmpClient.tier,
                            decoration: InputsDeco.textFormDeco(
                              isDarkMode: isDarkMode,
                                context: context,
                                label: 'Tier Status',
                                icon: Icons.alt_route),
                            isExpanded: false,
                            // value: tmpClient.tier,
                            items: const [
                              DropdownMenuItem(
                                value: 'Tier - 0',
                                child: Text('Tier - 0'),
                              ),
                              DropdownMenuItem(
                                value: 'Tier - 1',
                                child: Text('Tier - 1'),
                              ),
                              DropdownMenuItem(
                                value: 'Tier - 2',
                                child: Text('Tier - 2'),
                              ),
                              DropdownMenuItem(
                                value: 'OTC - 1',
                                child: Text('OTC 1'),
                              ),
                              DropdownMenuItem(
                                value: 'OTC - 2',
                                child: Text('OTC - 2'),
                              ),
                            ],
                            onChanged: (value) => tmpClient.tier = value!,
                          )
                        ]
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
      actions: [
        OutlinedButton(
          onPressed: () {
            Navigator.pop(context, false);
          },
          child: const Text('Cancelar'),
        ),
        if (tmpClient.clientType != '')
          FilledButton(
            onPressed: (widget.client != null)
                ? () async {
                    if (formKey.currentState!.validate()) {
                       tmpClient.ibanWallet = ibans;
                      if (isActive) {
                        tmpClient.tierStatus = 'Approved';
                      } else {
                        tmpClient.tierStatus = 'Pending';
                      }
                      await Provider.of<ClientsProvider>(context, listen: false)
                          .updateClient(tmpClient);
                      if (context.mounted) {
                        Navigator.pop(context, true);
                      }
                    }
                  }
                : () async {
                    if (formKey.currentState!.validate()) {
                      tmpClient.ibanWallet = ibans;
                      if (isActive) {
                        tmpClient.tierStatus = 'Approved';
                      } else {
                        tmpClient.tierStatus = 'Pending';
                      }
                      await Provider.of<ClientsProvider>(context, listen: false)
                          .createNewClient(tmpClient);
                
                      if (context.mounted) {
                        Navigator.pop(context, true);
                      }
                    }
                  },
            child: (widget.client != null)
            ? const Text('Actualizar')
            : const Text('Agregar'),
          ),
      ],
    );
  }
}
