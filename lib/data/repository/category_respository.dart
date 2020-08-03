import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:inventoryapp/data/data.dart';

class CategoryRepository {
  final categoryCollection = Firestore.instance.collection('categories');
  Future<List<Category>> getAllData() async {
    List<Category> categories = [];
    await categoryCollection
        .getDocuments()
        .then((QuerySnapshot querySnapshot) {
          querySnapshot.documents.forEach((ds) {
            categories.add(Category.fromDocumentSnapshot(ds));
          });
        });

    return categories;
  }

  Future<void> createCategory({
    @required name,
  }) async {
    Category category = Category(
      name: name,
    );
    await categoryCollection.add(category.toDocument());
  }

  Future<void> updateCategory({
    @required Category category
  }) async {
    await categoryCollection.document(category.id).updateData(category.toDocument());
  }

  Future<void> deleteCategory(Category category) async {
    return categoryCollection.document(category.id).delete();
  }
}
