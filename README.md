# subblock_multiplication

## Complexity

Before explaining a complexity of matrix multiplication, we are going to describe application of tensor product as a method of matrix multiplication. Define matrix multiplication as Tensor product when we do AB=C such below:
$$\sum\limits_{i=1}^m \sum\limits_{j=1}^n \sum\limits_{k=1}^p A_{ij}B_{jk}C{ki}.$$

A X B X D=sigma(i,j) (a_ir * b_jr*c_ij) when d_ij is component of group consisting of 0 or 1. 

In this circumstance, multiplication complexity means the rank of Tensor product depending on the dimension of A&B. Until now, many scholars had tried to find a asymptotically  smaller upper bound of Rank by using Schonage’s theorem. Strassen 2.807, Bini 2.7951, copper smith and winograd 2.376. 

## APA (Arbitrary-Precision-Approximation)
This idea was first introduced by bini allowing small error term to reduce complexity. Before, there is only algebraic method only for exact matrix multiplication. Consequently we can have more computational information at one multiplication. By adjusting the e, we can approximate the result to the exact value relatively reducing time complexity(figure). Especially, bini introduce matrix multiplication algorithm when the first matrix A has a zero block on the index (2,1). 

C=A*B + e*D, D goes to 0 as e is very small. 

Code below:
