# Super Resolution through NE

* main process of the program, including 

   * read in image 
   * transfer to yiq
   * calculate the derivative of the matrix 
   * get the patch
   * find k-nearest neighbours
   * calculate the weights and reconstruct images

* make.m:  read images and get features	
* Knnsearch.m & Knn_search.m: find k-nearest neighbours
* Recover,m:  Reconstruct images	
* derivative.m:  calculate the derivative of the matrix
* patchup.m:  patch the matrix up
* getmeans.m:  calculate means of vectors in matrix
* make_train.m:  get basic images by simple interpolation
