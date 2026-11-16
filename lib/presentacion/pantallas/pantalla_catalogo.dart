import 'package:flutter/material.dart';

import '../../dependencias.dart';
import '../../dominio/dinero.dart';
import '../../dominio/producto.dart';
import '../tema.dart';
import 'pantalla_detalle.dart';

class PantallaCatalogo extends StatelessWidget {
  final Dependencias deps;
  const PantallaCatalogo({super.key, required this.deps});

  @override
  Widget build(BuildContext context) {
    final vm = deps.catalogo;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 72,
        title: const Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('Talavera Dolores'),
          Text('Artesanías de Dolores Hidalgo',
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w400, color: Colores.musgo)),
        ]),
      ),
      body: ListenableBuilder(
        listenable: vm,
        builder: (context, _) {
          if (vm.cargando) return const Center(child: CircularProgressIndicator());
          if (vm.error != null) {
            return Center(
              child: Column(mainAxisSize: MainAxisSize.min, children: [
                Text(vm.error!),
                FilledButton(onPressed: vm.cargar, child: const Text('Reintentar')),
              ]),
            );
          }
          final lista = vm.visibles;
          return Column(children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 8, 12, 4),
              child: TextField(
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.search, color: Colores.musgo),
                  hintText: 'Buscar productos',
                  isDense: true,
                ),
                onChanged: vm.buscar,
              ),
            ),
            SizedBox(
              height: 48,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 8),
                children: [
                  _Chip('Todo', vm.categoria == null, () => vm.elegirCategoria(null)),
                  for (final c in Categoria.values)
                    _Chip(c.nombre, vm.categoria == c, () => vm.elegirCategoria(c)),
                  _Chip('Solo AR 📱', vm.soloAr, vm.alternarSoloAr),
                ],
              ),
            ),
            Expanded(
              child: lista.isEmpty
                  ? const Center(child: Text('No encontramos productos con esos filtros.'))
                  : GridView.builder(
                      padding: const EdgeInsets.all(12),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.74,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 12,
                      ),
                      itemCount: lista.length,
                      itemBuilder: (_, i) => _Tarjeta(deps: deps, p: lista[i]),
                    ),
            ),
          ]);
        },
      ),
    );
  }
}

class _Chip extends StatelessWidget {
  final String texto;
  final bool activo;
  final VoidCallback alTocar;
  const _Chip(this.texto, this.activo, this.alTocar);

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 6),
        child: FilterChip(
          label: Text(texto),
          selected: activo,
          showCheckmark: false,
          labelStyle: TextStyle(color: activo ? Colors.white : Colores.tinta),
          onSelected: (_) => alTocar(),
        ),
      );
}

class _Tarjeta extends StatelessWidget {
  final Dependencias deps;
  final Producto p;
  const _Tarjeta({required this.deps, required this.p});

  @override
  Widget build(BuildContext context) => Card(
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: () => Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => PantallaDetalle(deps: deps, productoId: p.id)),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colores.salvia,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(child: Text(p.emoji, style: const TextStyle(fontSize: 52))),
                ),
              ),
              const SizedBox(height: 10),
              Text(p.nombre, maxLines: 2, overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontWeight: FontWeight.w600, color: Colores.tinta)),
              const SizedBox(height: 4),
              Row(children: [
                Text(formatearPesos(p.precioCentavos),
                    style: const TextStyle(fontWeight: FontWeight.w700, color: Colores.bosque)),
                const Spacer(),
                if (p.tieneModelo3d)
                  const Tooltip(
                    message: 'Ver en tu espacio',
                    child: Icon(Icons.view_in_ar, size: 20, color: Colores.dorado),
                  ),
              ]),
              if (p.existencias == 0) const Text('Agotado', style: TextStyle(color: Colors.red)),
            ]),
          ),
        ),
      );
}
