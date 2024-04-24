import 'package:flutter/material.dart';

class SellScreen extends StatelessWidget {
  const SellScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Center(
          child: Image.asset(
            'assets/images/onboarding_images/logo.png',
            height: 50,
            fit: BoxFit.fill,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ProductNameWidget(),
                const sizedBoxSellerDash(),
                PriceWidget(),
                const sizedBoxSellerDash(),
                CategoriesDropWidget(),
                const sizedBoxSellerDash(),
                DescriptionWidget(),
                const sizedBoxSellerDash(),
                SellerWidget(),
                const sizedBoxSellerDash(),
                ImageLinkWidget(),
                const sizedBoxSellerDash(),
                AddProductButton(onPressed: () {}),
                const sizedBoxSellerDash(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class sizedBoxSellerDash extends StatelessWidget {
  const sizedBoxSellerDash({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.width / 25,
    );
  }
}

class AddProductButton extends StatelessWidget {
  final VoidCallback onPressed;

  const AddProductButton({
    Key? key,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        primary: Colors.blue,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      ),
      child: Text(
        'Add Product',
        style: TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class SellerWidget extends StatelessWidget {
  const SellerWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Name of Seller',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 10),
        Container(
            // height: MediaQuery.of(context).size.width / 9,
            width: MediaQuery.of(context).size.width,
            child: TextFormField()),
      ],
    );
  }
}

class PriceWidget extends StatelessWidget {
  const PriceWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Price',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 10),
        Container(
          width: MediaQuery.of(context).size.width,
          child: TextFormField(
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              suffixText: '₹',
            ),
          ),
        ),
      ],
    );
  }
}

class ProductNameWidget extends StatelessWidget {
  const ProductNameWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Name of Product',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 10),
        Container(
            // height: MediaQuery.of(context).size.width / 9,
            width: MediaQuery.of(context).size.width,
            child: TextFormField()),
      ],
    );
  }
}

class DescriptionWidget extends StatelessWidget {
  const DescriptionWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Description of Product',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 10),
        Container(
          width: MediaQuery.of(context).size.width,
          child: SingleChildScrollView(
            physics: NeverScrollableScrollPhysics(),
            child: TextFormField(
              maxLines: null, // Allow TextFormField to expand vertically
              decoration: InputDecoration(
                border: OutlineInputBorder(),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class CategoriesDropWidget extends StatefulWidget {
  @override
  _DropdownButtonWidgetState createState() => _DropdownButtonWidgetState();
}

class _DropdownButtonWidgetState extends State<CategoriesDropWidget> {
  String? _selectedCategory;
  List<String> _categories = [
    'Artisian',
    'Jewellery',
    'Natural Wellness',
    'Home Decor',
    'Regional Popular',
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Category',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10),
          InkWell(
            onTap: () {
              _showDropdownMenu(context);
            },
            child: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(5),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    _selectedCategory ?? 'Select category',
                    style: TextStyle(fontSize: 16),
                  ),
                  Icon(Icons.arrow_drop_down),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showDropdownMenu(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Select a category'),
          content: Container(
            width: double.maxFinite,
            height: MediaQuery.of(context).size.width,
            child: ListView.builder(
              itemCount: _categories.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text(_categories[index]),
                  onTap: () {
                    setState(() {
                      _selectedCategory = _categories[index];
                    });
                    Navigator.pop(context);
                  },
                );
              },
            ),
          ),
        );
      },
    );
  }
}

class ImageLinkWidget extends StatefulWidget {
  const ImageLinkWidget({Key? key}) : super(key: key);

  @override
  _ProductNameWidgetState createState() => _ProductNameWidgetState();
}

class _ProductNameWidgetState extends State<ImageLinkWidget> {
  List<Widget> _productFields = [];

  @override
  void initState() {
    super.initState();
    _productFields.add(_buildProductField());
  }

  Widget _buildProductField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Image Link',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: TextFormField(),
            ),
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                setState(() {
                  _productFields.add(_buildProductField());
                });
              },
            ),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: _productFields,
    );
  }
}
