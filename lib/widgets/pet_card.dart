import 'package:flutter/material.dart';
import 'package:pets_movil/models/models.dart';

class PetCard extends StatelessWidget {
  final Pet pet;

  const PetCard({super.key, required this.pet});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        margin: const EdgeInsets.only(top:30, bottom: 50),
        width: double.infinity,
        height: 400,
        decoration: _cardBorder(),
        child: Stack(
          alignment: Alignment.bottomLeft,
          children: [
            _backgroundImage(pet.picture),
            _PetDetails(
              title: pet.name,
              subTitle: pet.id!
            ),
            Positioned(
              top: 0,
              right: 0,
              child: _PriceTag(
                reward: pet.reward,
              )
              ),
            if(!pet.found)
            Positioned(
              top: 0,
              right: 272,
              child: _NotFund()
              ),
          ],
        ),
      ),
    );
  }

  BoxDecoration _cardBorder() => BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(25),
    boxShadow: const [
      BoxShadow(
        color: Colors.black12,
        offset: Offset(0, 7),
        blurRadius: 10
      )
    ]
  );
}

class _NotFund extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: FittedBox(
        fit: BoxFit.contain,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            'Perdido',
            style: TextStyle( color: Colors.white, fontSize: 20 ),
          ),
        ),
      ),
      width: 100,
      height: 70,
      decoration: BoxDecoration(
        color: Colors.yellow[800],
        borderRadius: BorderRadius.only( topLeft: Radius.circular(25), bottomRight: Radius.circular(25) )
      ),
    );
  }
}

class _PriceTag extends StatelessWidget {
  final int? reward;
  const _PriceTag({
    this.reward
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FittedBox(
        fit: BoxFit.contain,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Text(' Rec: $reward',style: TextStyle(color: Colors.white, fontSize: 20),),
        ),
      ),
      width: 100,
      height: 70,
      alignment: Alignment.center,
      decoration: const BoxDecoration(
        color: Colors.indigo,
        borderRadius: BorderRadius.only(topRight: Radius.circular(25),bottomLeft: Radius.circular(25))
      ),
    );
  }
}

class _PetDetails extends StatelessWidget {
  final String title;
  final String subTitle ;
  const _PetDetails({
    required this.title, required this.subTitle
  });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 50),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        width: double.infinity,
        height: 80,
        decoration: _buildBoxDecoration(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text( title , style: const TextStyle(fontSize: 20,color: Colors.white, fontWeight: FontWeight.bold),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            ),
            Text(subTitle, style: const TextStyle(fontSize: 15,color: Colors.white),
            )
          ],
        ),
      ),
    );
  }

  BoxDecoration _buildBoxDecoration() => const BoxDecoration(
    color: Colors.indigo,
    borderRadius: BorderRadius.only(bottomLeft: Radius.circular(25),topRight: Radius.circular(25))
  );
}

class _backgroundImage extends StatelessWidget {
  final String? url;
  const _backgroundImage(this.url) ;
  
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(25),
      child: Container(
        width: double.infinity,
        height: 400,
        child: url == null 
        ? 
        const Image(image: AssetImage('assets/jar-loading.gif'), fit: BoxFit.cover, )
        :
        FadeInImage(
          //TODO prod sin imagen
          placeholder: const AssetImage('assets/jar-loading.gif'), 
          image: NetworkImage(url!),
          fit: BoxFit.cover,
          ),
      ),
    );
  }
}