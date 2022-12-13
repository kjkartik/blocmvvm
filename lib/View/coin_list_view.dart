import 'dart:convert';

import 'package:blocmvvm/Model/coin_model.dart';
import 'package:blocmvvm/Res/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import '../ViewModel/Bloc/bloc_.dart';
import '../ViewModel/Bloc/event_.dart';
import '../ViewModel/Bloc/state.dart';

class CoinListView extends StatefulWidget {
  const CoinListView({Key? key}) : super(key: key);

  @override
  State<CoinListView> createState() => _CoinListViewState();
}

class _CoinListViewState extends State<CoinListView> {
  @override
  void initState() {
    connectToServer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: InkWell(
          child: const Text("CoinList"),
          onTap: () {
            context.read<CoinListBloc>().add(ViewCoinList());
          },
        ),
      ),
      body: BlocBuilder<CoinListBloc, CoinListState>(
        builder: (context, state) {
          if (state is Loading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is Loaded) {
            return StreamBuilder(
                stream: channel_home.stream,
                builder: (context, snapshot) {
                  return ListView.builder(
                      itemCount: 15,
                      itemBuilder: (context, index) {
                        if(snapshot.hasData){
                  var list = json.decode(snapshot.data as String);
                          if(state.data.data!.uSDT![index].symbol!.toLowerCase() == list["s"].toString().toLowerCase() ){
                            state.data.data!.uSDT![index].price = list["p"];
                          }
                        }




                     // //
                     //


                     return Container(
                          margin: EdgeInsets.only(top: 6),
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          width: width,
                          height: height / 16,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  const CircleAvatar(
                                    child: Text("imag"),
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(state.data.data!.uSDT![index].name
                                          .toString()),
                                      Text("pair")
                                    ],
                                  ),
                                ],
                              ),
                              Text(state.data.data!.uSDT![index].price
                                  .toString()),
                              Text("Percentage")
                            ],
                          ),
                        );
                      });
                });
          } else if (state is ErrorOccurd) {
            return Center(
              child: Column(
                children: [
                  Text(
                    "error---> " + state.error.toString(),
                    style: TextStyle(color: Colors.red),
                  ),
                  InkWell(
                    child: Text("Retry"),
                    onTap: () {
                      context.read<CoinListBloc>().add(ViewCoinList());
                    },
                  )
                ],
              ),
            );
          } else {
            return Container(
              child: Text("Initial Data"),
            );
          }
        },
      ),
    );
  }
}

WebSocketChannel channel_home =
    IOWebSocketChannel.connect("wss://stream.binance.com:9443/ws/stream?");

Future<void> connectToServer() async {
  var subRequest = {
    'method': "SUBSCRIBE",
    'params': tickerList,
    'id': 1,
  };
  var jsonString = json.encode(subRequest);
  channel_home.sink.add(jsonString);
}

List<String> tickerList = [
  "btcusdt@ticker",
  "ethusdt@ticker",
  "winusdt@ticker",
  "dentusdt@ticker",
  "xrpusdt@ticker",
  "etcusdt@ticker",
  "dogeusdt@ticker",
  "bnbusdt@ticker",
  "yfiusdt@ticker",
  "cakeusdt@ticker",
  "vetusdt@ticker",
  "maticusdt@ticker",
  "trxusdt@ticker",
  "eosusdt@ticker",
  "usdcusdt@ticker",
  "neoeth@ticker",
  "xmrbtc@ticker",
  "wintrx@ticker",
  "yfiiusdt@ticker",
  "aaveusdt@ticker",
  "dotusdt@ticker",
  "sandusdt@ticker",
  "maticbtc@ticker",
  "polybtc@ticker",
  "yfiibtc@ticker",
  "bnbbtc@ticker",
  "yfibtc@ticker",
  "aavebtc@ticker",
  "ltcbtc@ticker",
  "cakebtc@ticker",
  "eosbtc@ticker",
  "jstbtc@ticker",
  "chzbtc@ticker",
  "polybtc@ticker",
  "solbtc@ticker",
  "ksmbtc@ticker",
  "compbtc@ticker",
  "dashbtc@ticker",
  "axsbtc@ticker",
  "btgbtc@ticker",
  "lunabtc@ticker",
  "dasheth@ticker",
  "avaxeth@ticker",
  "axseth@ticker",
  "etceth@ticker",
  "doteth@ticker",
  "linketh@ticker",
  "omgeth@ticker",
  "sandeth@ticker",
  "waveseth@ticker",
  "nanoeth@ticker",
  "ezeth@ticker",
  "manaeth@ticker",
  "enjeth@ticker",
  "lsketh@ticker",
  "aaveeth@ticker",
  "mtleth@ticker",
  "adaeth@ticker",
  "iotaeth@ticker",
  "xrpeth@ticker",
  "shibusdt@ticker",
];
