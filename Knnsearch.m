% Find the nearest neighbours
load('feature.mat')
neighbours = Knn_search(feature_train, feature_dst, 'K', 5, 'NSMethod', 'kdtree');
save data.mat
