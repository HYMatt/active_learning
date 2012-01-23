% select points with probability above a given threshold.
%
% function test_ind = probability_treshold_selection_function(data, ...
%           responses, train_ind, probability_function, threshold)
%
% where
%                   data: an (n x d) matrix of input data
%              responses: an (n x 1) vector of responses
%              train_ind: a list of indices into data/responses
%                         indicating the training points
%   probability_function: a function handle providing a probability function
%              threshold: a value in [0, 1]; points with
%                         probability greater than or equal to this
%                         (for any class) are selected
%
%   test_ind: a list of indices into data/responses indicating
%             the points to test
%
% copyright (c) roman garnett, 2011--2012

function test_ind = probability_treshold_selection_function(data, ...
          responses, train_ind, probability_function, threshold)

  test_ind = identity_selection_function(responses, train_ind);
  probabilities = ...
      probability_function(data, responses, train_ind, test_ind);

  test_ind = any(probabilities >= threshold, 2);

end
