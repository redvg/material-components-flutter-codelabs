// Copyright 2018-present the Flutter authors. All Rights Reserved.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'model/product.dart';
import 'model/data.dart';

import 'supplemental/asymmetric_view.dart';

class HomePage extends StatelessWidget {

  List<Card> _buildSampleCards(int count){

    return List.generate(count, (int index) => 
        
        Card(

            child: Column(

              crossAxisAlignment: CrossAxisAlignment.start,

              children: <Widget>[

                AspectRatio(

                  aspectRatio: 18.0 / 11.0,

                  child: Image.asset('assets/diamond.png'),
                ),

                new Padding(

                  padding: EdgeInsets.fromLTRB(16.0, 12.0, 16.0, 8.0),

                  child: Column(

                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: <Widget>[

                      Text('FOO'),

                      SizedBox(height: 8.0,),

                      Text('this is card number $index'),
                    ],
                  ),
                ),
              ],
            ),
          ),);

  }
  
  Card _buildProductCard(context, product){
    
    final ThemeData theme = Theme.of(context);

    final NumberFormat formatter = NumberFormat.simpleCurrency(
      
      locale: Localizations.localeOf(context).toString(),
    );

    return Card(

            elevation: 0.0,

            child: Column(

              crossAxisAlignment: CrossAxisAlignment.center,

              children: <Widget>[

                AspectRatio(

                  aspectRatio: 18.0 / 11.0,

                  child: Image.asset(
                    
                    product.assetName, 
                    
                    package: product.assetPackage,
                    
                    fit: BoxFit.fitWidth,),
                ),

                Expanded(

                  child: Padding(

                    padding: EdgeInsets.fromLTRB(16.0, 12.0, 16.0, 8.0),

                    child: Column(

                      crossAxisAlignment: CrossAxisAlignment.center,

                      mainAxisAlignment: MainAxisAlignment.end,

                      children: <Widget>[

                        Text(

                          product.name,

                          style: theme.textTheme.button,

                          maxLines: 1,

                          softWrap: false,

                          overflow: TextOverflow.ellipsis,
                        ),

                        SizedBox(height: 8.0,),

                        Text(

                          formatter.format(product.price),

                          style: theme.textTheme.caption,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
  }
  
  List<Card> _createProductGrid(BuildContext context){

    List<Product> products = getProducts(Category.all);

    if (products == null || products.isEmpty) return const <Card>[];


    return products.map((product) { return _buildProductCard(context, product);}).toList();
  }

  Widget _buildProductGrid(context){

    return GridView.count(
        
        crossAxisCount: 2,
        
        padding: EdgeInsets.all(16.0),
        
        childAspectRatio: 8.0 / 9.0,

        children: _createProductGrid(context),

        );
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      
      appBar: AppBar(

        brightness: Brightness.dark,

        title: Text('Shrine'),

        leading: IconButton(

          icon: Icon(Icons.menu),

          onPressed: (){},
        ),

        actions: <Widget>[

          IconButton(
            
            icon: Icon(Icons.search),

            onPressed: (){},),

          IconButton(
            
            icon: Icon(Icons.tune),

            onPressed: (){},),
        ], 
      ),

      body: AsymmetricView(products: getProducts(Category.all)), //call _buildProductGrid() to get GridView
    );
  }
}
