# Subblock Multiplication

## Included Codes
Within this repository, we have included:
 - FDM
 - Naive
 - Strassen
 - Bini
 - Index Multiplication
 - Subblock Method.

## Further Explanation of Bini's Algorithm 
### Complexity

Before explaining the complexity of matrix multiplication, we describe the application of tensor product as a method of matrix multiplication. For a matrix multiplication of the form $AB=C$, we can define matrix multiplication as a tensor product of the form such as below:

$$A \otimes B \otimes D = \sum\limits_{i=1}^m \sum\limits_{j=1}^n \sum\limits_{k=1}^p A_{ij}B_{jk}D_{ki}.$$

where $D_{ki} \in \{0,1\}$.

In this case, multiplication time complexity indicates the rank of the Tensor product depending on the dimensions of A and B. Until now, many scholars had tried to find an asymptotically  smaller upper bound rank by using Schoenghage’s theorem. The respective time complexities are:
 - Strassen $\mathcal{O}(n^{2.807})$
 - Bini $\mathcal{O}(n^{2.7951})$
 - Coppersmith and Winograd $\mathcal{O}(n^{2.376})$ .


### APA (Arbitrary-Precision-Approximation)
This idea was first introduced by Bini; it allows small error terms to reduce complexity. Previously, it was necessary to carry out specific multiplication operations for each element. However, in this case, we can reduce the number of operations by carrying out bulk operations for multiple elements. By adjusting the error term, we can approximate the result to the exact value, relatively reducing time complexity. 

$$ C=A\*B + \epsilon\*D,\ D \rightarrow 0\ \mathrm{as}\ \epsilon \rightarrow 0. $$

Specifically, Bini introduced a matrix multiplication algorithm where the first matrix A has a zero block on the index (2,1). 


The code for this is titled **binio.m**.

