function [accuracy] = shrinklda_xval(data, classlabels,  nfolds)
  % shrinkage LDA classification with cross-validation
  % Input: data ... input data <num_trials x num_features>
  %        classlabels ... input classlabels <num_trials x 1>
  %        nfolds ... number of cross-validation folds
  % Output: accuracy ... classification accuracies of all cross-validation
  

  num_trials = size(data, 1);
  num_features = size(data, 2);
  
  [trainsets, testsets] = xvalidation(num_trials, nfolds, nfolds);

  xval_runs = length(trainsets);
  
  accuracy = zeros(1, xval_runs);
  features = zeros(xval_runs, num_features);

  for index = 1 : xval_runs

    train_data = data(trainsets{index}, :);
    train_cl = classlabels(trainsets{index});
    
    test_data = data(testsets{index}, :);
    test_cl = classlabels(testsets{index});
  
%     [~, ~, ~, inmodel, ~, ~, ~] = stepwisefit(train_data, train_cl, 'penter', swlda_penter, 'premove', swlda_premove, 'maxiter', swlda_maxiter, 'display', 'off');
%     cc = train_sc(train_data(:, inmodel), train_cl, 'LD3');
%     r = test_sc(cc, test_data(:, inmodel), 'LD3', test_cl);

% Calculate linear discriminant coefficients
        model_lda = lda_train(train_data,train_cl);

      % Predict class membership
      [predicted_classes, linear_scores] = lda_predict(model_lda,test_data);
  
      % Calculate classification accuracy
 
      
    accuracy(index) = sum(predicted_classes==test_cl)/length(test_cl);
    

    clear train_data train_cl test_data test_cl inmodel ;
    
  end

end

