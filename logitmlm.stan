data {
  int<lower=0> N;
  int<lower=1> K;
  int<lower=1> J;
  int<lower=1> L;
  int<lower=1,upper=J> jj[N];  // group for individual
  matrix[N,K] x;
  matrix[J,L] u;
  int<lower=0,upper=1> y[N];
}
parameters {
  corr_matrix[K] Omega;
  vector<lower=0>[K] tau;
  matrix[L,K] gamma;
  vector[K] beta[J];
  real<lower=0> sigma;
}
model {
  matrix[K,K] Sigma_beta;
  Sigma_beta = diag_matrix(tau) * Omega * diag_matrix(tau);
  tau ~ normal(0,10); // cauchy(0,2);
  Omega ~ lkj_corr(5);
  for (l in 1:L){
    gamma[l] ~ normal(0,10);
  }
  for (j in 1:J){
    beta[j] ~ multi_normal((u[j] * gamma)', Sigma_beta);
  }
  for (n in 1:N){
    y[n] ~  bernoulli_logit(x[n] * beta[jj[n]]);
  }
}


