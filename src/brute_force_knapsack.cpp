#include <Rcpp.h>
using namespace Rcpp;

// [[Rcpp::export]]
List brute_force_cpp(IntegerVector w, NumericVector v, double W) {
  int n = w.size();
  int total = pow(2, n);
  double best_value = 0;
  std::vector<int> best_elements;

  for (int combination = 1; combination < total; combination++) {
    int combination_weight = 0;
    double combination_value = 0;
    std::vector<int> elements;
    int temp = combination;

    for (int j = 0; j < n; j++) {
      if (temp % 2 == 1) {
        combination_weight += w[j];
        combination_value += v[j];
        elements.push_back(j + 1);
      }
      temp = temp / 2;
    }

    if (combination_weight <= W && combination_value > best_value) {
      best_value = combination_value;
      best_elements = elements;
    }
  }

  return List::create(_["value"] = best_value, _["elements"] = best_elements);
}
