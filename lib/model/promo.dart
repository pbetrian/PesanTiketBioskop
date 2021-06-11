part of 'models.dart';

class Promo extends Equatable {
  final String title;
  final String subTitle;
  final int discount;

  Promo({@required this.title,@required this.discount,@required this.subTitle,});

  @override
  List<Object> get props => [title, subTitle, discount];
}

List<Promo> dummyPromos = [
  Promo(title: "Student Holiday",  discount: 50, subTitle: "Maximal only fot two people"),
  Promo(title: "Family Club", discount: 70, subTitle: "Maximal for three members"),
  Promo(title: "Subscripton Promo", discount: 40, subTitle: "Min one year"),
];