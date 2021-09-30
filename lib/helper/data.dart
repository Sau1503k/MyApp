
import 'package:flutter/material.dart';
import 'package:MyApp/Classes/Categorys.dart';
import 'package:MyApp/helper/loadingimages.dart';




List<category> getCategoryModel(){
  List<category> mycategories = new List<category>();
  category Categories=new category();


  Categories =new category();
  Categories.Category="Dance";
  Categories.imageUrl="categories/Dance.png";
  mycategories.add(Categories);

  Categories =new category();
  Categories.Category="Sketch";
  Categories.imageUrl="categories/Sketch.png";
  mycategories.add(Categories);

  Categories =new category();
  Categories.Category="Music";
  Categories.imageUrl="categories/Music.png";
  mycategories.add(Categories);

  Categories =new category();
  Categories.Category="Drama";
  Categories.imageUrl="categories/Drama.png";
  mycategories.add(Categories);

  Categories =new category();
  Categories.Category="Painting";
  Categories.imageUrl="categories/Painting.png";
  mycategories.add(Categories);

  Categories =new category();
  Categories.Category="Gaming";
  Categories.imageUrl="categories/Gaming.png";
  mycategories.add(Categories);

  Categories =new category();
  Categories.Category="Sports";
  Categories.imageUrl="categories/Sports.png";
  mycategories.add(Categories);

  Categories =new category();
  Categories.Category="Photography";
  Categories.imageUrl="categories/Photography.png";
  mycategories.add(Categories);

  return mycategories;





}