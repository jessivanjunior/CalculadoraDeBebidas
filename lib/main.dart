import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(MyApp());
}

class Product {
  double ml;
  int quantidade;
  double preco;

  Product({required this.ml, required this.quantidade, required this.preco});
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          color: Colors.amber,
        ),
        primaryColor: Colors.black,
        brightness: Brightness.dark,
      ),
      home: ProductComparisonApp(),
    );
  }
}

class ProductComparisonApp extends StatefulWidget {
  @override
  _ProductComparisonAppState createState() => _ProductComparisonAppState();
}

class _ProductComparisonAppState extends State<ProductComparisonApp> {
  List<TextEditingController> _mlControllers =
      List.generate(3, (index) => TextEditingController());
  List<TextEditingController> _quantidadeControllers =
      List.generate(3, (index) => TextEditingController());
  List<TextEditingController> _precoControllers =
      List.generate(3, (index) => TextEditingController());

  String _resultado = '';
  double precoUnidade = 9999;
  double precoLitro = 9999;
  int posicao = 0;



  void _calcularBebidaMaisCantajosa() {


    for (int i = 0; i < 3; i++) {

      var produto = Product(
        ml: double.tryParse(_mlControllers[i].text) ?? 0,
        quantidade: int.tryParse(_quantidadeControllers[i].text) ?? 0,
        preco: double.tryParse(_precoControllers[i].text) ?? 0,
      );

      //(produto.preco);
      //print(produto.quantidade);
      //print(produto.ml);
      //print('melhor preço $precoUnidade');
      //print(produtos);
      //produtos.add(produto);
      precoUnidade = (produto.preco / produto.quantidade);
      print(precoUnidade);
      //na formula da regra de 3 temos que: (A * B) / C = X
      //onde precoUnidade=B, ml=A e C=1000,
      //sendo assim: precoFinal = (precoUnidade * 1000) / mL

      if (precoLitro > (precoUnidade * 1000 / produto.ml) ) {
        precoLitro = (precoUnidade * 1000 / produto.ml);
        posicao = i;
        print(precoLitro);
      }

      //precoUnidade preço por unidade, ou seja, é o valor pela quantidade de mls
      //se  precounidade = quantidade
      //        x        = 1000
    }

    setState(() {
      _resultado =
          '${String.fromCharCode(65 + posicao)} com um preço de R\$${NumberFormat("#.00").format(precoLitro)} por litro.';
      precoLitro = 9999;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarIconBrightness: Brightness.dark,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(32),
          ),
        ),
        title: Text(
          'Calculadora de Bebidas',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
          ),
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Spacer(),
                Text(
                  "Adicione os valores das bebidas",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.amber,
                    fontWeight: FontWeight.bold,
                    fontSize: 23,
                  ),
                ),
                Spacer(),
                Text(
                  "Exemplo:\n 6 latas custam 30 reais, tendo 350mL cada lata",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),

                for (int i = 0; i < 3; i++)
                  Row(
                    children: [
                      Text('${String.fromCharCode(65 + i)}:'), // A, B, C
                      SizedBox(width: 10),
                      Expanded(
                        child: TextField(
                          controller: _quantidadeControllers[i],
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(labelText: 'Unidades'),
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: TextField(
                          controller: _precoControllers[i],
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(labelText: 'Preço'),
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: TextField(
                            controller: _mlControllers[i],
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(labelText: 'mLs')),
                      ),
                    ],
                  ),
                SizedBox(height: 20),
                Spacer(),
                Text(
                  "A bebida mais vantajosa é:",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.amber,
                  ),
                ),
                SizedBox(height: 30),
                Center(
                  child: Text(_resultado,
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                ),
                Spacer(),
                Center(
                  child: ElevatedButton(
                    onPressed: _calcularBebidaMaisCantajosa,
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.amber),
                    child: Text('Calcular',
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold)),
                  ),
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
