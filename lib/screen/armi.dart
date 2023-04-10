import 'dart:ffi';
import 'dart:io';
import 'dart:async';
import 'dart:math';

import 'package:csv/csv.dart';

// dot은 행렬의 제곱의 합
double dot(List<dynamic> A, List<double> B) {
  double sumDot = 0;

  for (int i = 0; i < A.length; i++) {
    sumDot += A[i] * B[i];
  }
  return sumDot;
}

// norm은 행렬의 제곱의 루트값
double norm(List<double> A) {
  double getNorm = 0;

  for (int i = 0; i < A.length; i++) {
    getNorm += A[i] * A[i];
  }

  return sqrt(getNorm);
}

// 리스트의 norm을 구하기
double Listnorm(List<dynamic> A) {
  double getNorm = 0;

  for (int i = 0; i < A.length; i++) {
    getNorm += A[i] * A[i];
  }
  return getNorm;
}

List<int> armiReturn(List<double> checkd) {
  // 질병 예측행렬 csv read
  String src = 'bin/armi_test.csv';

  // String csvText = File(src).readAsStringSync();

  // List<List<dynamic>> data = const CsvToListConverter().convert(csvText);

  List<List<dynamic>> data = [
    [0.87, 0.9, 0.9, 0.9, -0.51, 0.53],
    [0.9, 0.89, 0.9, 0.9, -0.38, 0.65],
    [0.88, 0.9, 0.9, 0.9, -0.47, 0.57],
    [0.88, 0.9, 0.9, 0.9, -0.47, 0.57],
    [0.88, 0.9, 0.9, 0.9, -0.47, 0.57],
    [0.88, 0.9, 0.9, 0.9, -0.47, 0.57],
    [-0.28, -0.53, -0.46, -0.47, 0.9, 0.3],
    [-0.28, -0.53, -0.46, -0.47, 0.9, 0.3],
    [-0.28, -0.53, -0.46, -0.47, 0.9, 0.3],
    [-0.28, -0.53, -0.46, -0.47, 0.9, 0.3],
    [-0.28, -0.53, -0.46, -0.47, 0.9, 0.3],
    [-0.28, -0.53, -0.46, -0.47, 0.9, 0.3],
    [0.68, 0.46, 0.53, 0.52, 0.35, 0.9],
    [0.68, 0.46, 0.53, 0.52, 0.35, 0.9],
    [0.68, 0.46, 0.53, 0.52, 0.35, 0.9],
    [0.68, 0.46, 0.53, 0.52, 0.35, 0.9],
    [0.68, 0.46, 0.53, 0.52, 0.35, 0.9],
    [0.89, 0.75, 0.79, 0.79, 0.02, 0.9],
    [0.9, 0.85, 0.87, 0.87, -0.27, 0.72],
    [0.9, 0.85, 0.87, 0.87, -0.27, 0.72],
    [0.9, 0.9, 0.91, 0.91, -0.42, 0.62],
    [0.85, 0.9, 0.89, 0.89, -0.56, 0.48],
    [0.85, 0.9, 0.89, 0.89, -0.56, 0.48],
    [0.85, 0.9, 0.89, 0.89, -0.56, 0.48],
    [0.85, 0.9, 0.89, 0.89, -0.56, 0.48],
    [0.88, 0.9, 0.9, 0.9, -0.48, 0.55],
    [0.9, 0.89, 0.9, 0.9, -0.38, 0.65],
    [0.88, 0.9, 0.9, 0.9, -0.48, 0.56],
    [0.88, 0.9, 0.9, 0.9, -0.48, 0.56],
    [0.88, 0.9, 0.9, 0.9, -0.48, 0.56],
    [0.88, 0.9, 0.9, 0.9, -0.48, 0.56],
  ];
  // 질병 값
  List<double> disease = checkd;

  // 질병 예측행렬의 norm 구하기
  double getListNorm = 0;
  for (int i = 0; i < data.length; i++) {
    getListNorm += Listnorm(data[i]);
  }

  getListNorm = sqrt(getListNorm);

  // print(norm(dotb));
  // print(getListNorm);

  // 질병 예측행렬과 질병의 코사인 유사도 구한 후 리스트로 저장
  List<List<double>> consineList =
      List.generate(data.length, (index) => List.empty(growable: true));

  for (int i = 0; i < data.length; i++) {
    consineList[i] = [dot(data[i], disease) / (norm(disease) * getListNorm)];
  }
  // print(consineList);

  // 코사인 유사도가 가장 큰 값과 위치를 저장
  double getMax = consineList[0][0];
  int maxNum = 0;

  for (int i = 0; i < consineList.length; i++) {
    if (getMax < consineList[i][0]) {
      getMax = consineList[i][0];
      maxNum = i;
    }
  }

  // print(getMax);
  // print(maxNum);

  // 제품 예측행렬 csv read
  String srcProd = 'bin/armi_prod.csv';

  // String csvTextProd = File(srcProd).readAsStringSync();
  // List<List<dynamic>> dataProd =
  //     const CsvToListConverter().convert(csvTextProd);

  List<List<dynamic>> dataProd = [
    [1.03, 1.19, 0.98, 1.27, 0.54, 0.99, 1.18, 0.76, 0.74, 1, 1.04],
    [0.98, 0.77, 1.07, 0.81, 1.06, 0.95, 0.74, 1, 1.01, 0.93, 0.92],
    [1.03, 1.43, 0.9, 1.54, 0.18, 0.99, 1.44, 0.59, 0.54, 1.01, 1.1],
    [0.99, 1.01, 1, 1.08, 0.73, 0.96, 0.99, 0.84, 0.83, 0.95, 0.98],
    [1.02, 0.87, 1.09, 0.93, 1, 0.98, 0.84, 0.99, 0.99, 0.97, 0.98],
    [0.65, 0.98, 0.54, 1.06, -0.01, 0.62, 0.99, 0.31, 0.27, 0.64, 0.71],
    [0.51, 0.95, 0.35, 1.04, -0.3, 0.48, 0.98, 0.1, 0.04, 0.51, 0.59],
    [1.01, 1.16, 0.96, 1.25, 0.52, 0.97, 1.16, 0.75, 0.72, 0.98, 1.02],
    [0.99, 1.05, 0.98, 1.12, 0.65, 0.95, 1.04, 0.8, 0.78, 0.95, 0.99],
    [0.97, 1.03, 0.96, 1.1, 0.64, 0.93, 1.01, 0.78, 0.77, 0.93, 0.96],
    [1.07, 0.69, 1.23, 0.72, 1.4, 1.04, 0.64, 1.21, 1.24, 1.01, 0.98],
    [0.97, 1.03, 0.96, 1.1, 0.64, 0.93, 1.01, 0.79, 0.77, 0.93, 0.97],
    [1, 1.02, 1, 1.09, 0.72, 0.96, 1.01, 0.83, 0.82, 0.96, 0.99],
    [0.66, 0.99, 0.54, 1.07, -0.01, 0.62, 1, 0.31, 0.27, 0.65, 0.71],
    [0.64, 0.97, 0.52, 1.05, -0.03, 0.61, 0.98, 0.29, 0.25, 0.63, 0.69],
    [0.98, 1.03, 0.98, 1.1, 0.68, 0.95, 1.01, 0.81, 0.8, 0.95, 0.98],
    [0.96, 1.03, 0.94, 1.11, 0.6, 0.92, 1.02, 0.76, 0.74, 0.92, 0.96],
    [1.04, 0.93, 1.1, 0.98, 0.97, 1.01, 0.9, 0.98, 0.98, 0.99, 1],
    [1.04, 0.93, 1.1, 0.98, 0.96, 1, 0.9, 0.98, 0.98, 0.99, 1],
    [1.04, 0.93, 1.09, 0.98, 0.96, 1, 0.9, 0.97, 0.98, 0.99, 1],
    [1, 0.84, 1.08, 0.89, 1.01, 0.97, 0.81, 0.98, 0.99, 0.95, 0.96],
    [1, 0.66, 1.14, 0.69, 1.28, 0.97, 0.62, 1.12, 1.15, 0.94, 0.92],
    [1.02, 1.05, 1.03, 1.13, 0.73, 0.99, 1.04, 0.86, 0.84, 0.98, 1.02],
    [1.01, 0.56, 1.19, 0.58, 1.46, 0.98, 0.51, 1.21, 1.25, 0.95, 0.91],
    [0.84, 0.92, 0.83, 0.98, 0.52, 0.81, 0.91, 0.66, 0.65, 0.81, 0.84],
    [1.02, 0.87, 1.09, 0.92, 1.01, 0.98, 0.84, 0.99, 1, 0.97, 0.98],
    [1.02, 0.85, 1.1, 0.9, 1.03, 0.99, 0.82, 1.01, 1.02, 0.97, 0.98],
    [1.06, 0.96, 1.12, 1.01, 0.97, 1.02, 0.93, 0.99, 0.99, 1.01, 1.03],
    [1, 0.81, 1.09, 0.85, 1.06, 0.97, 0.77, 1.01, 1.02, 0.95, 0.95],
    [1.07, 1, 1.12, 1.06, 0.93, 1.03, 0.97, 0.98, 0.98, 1.03, 1.04],
    [1.06, 0.94, 1.11, 1, 0.97, 1.02, 0.92, 0.99, 0.99, 1.01, 1.02],
  ];

  // print(dataProd);

  // 질병의 예측행렬과 입력된 질병의 코사인 유사도를 기준으로 제품 예측행렬의 행을 리스트로 저장
  List<dynamic> prod = dataProd[maxNum];
  // print(prod);

  // 저장된 제품 예측행렬의 첫번째, 두번째, 세번째 큰 값의 위치와 값을 변수로 저장
  num one = prod[0], two = -1, three = -1;
  int oneloc = 0, twoloc = 0, threeloc = 0;

  for (int i = 0; i < prod.length; i++) {
    if (prod[i] > one) {
      three = two;
      two = one;
      one = prod[i];
      oneloc = i;
    } else if (prod[i] > two && prod[i] < one) {
      three = two;
      two = prod[i];
    } else if (prod[i] > three && prod[i] < two) {
      three = prod[i];
    }
  }

  for (int i = 0; i < prod.length; i++) {
    if (prod[i] == two) {
      twoloc = i;
    }
    if (prod[i] == three) {
      threeloc = i;
    }
  }
  // print('${one}, ${oneloc}');

  // print('${two}, ${twoloc}');
  // print('${three}, ${threeloc}');

  List<int> prodGetNum = [oneloc, twoloc, threeloc];
  // print(prodGetNum);
  return prodGetNum;
}
