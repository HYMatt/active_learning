k = 50;
pseudocount = 0.1;
weight_function = @(distances) (double(distances > 0));

weights = mknn_plus_mst_weights(data, k, weight_function);
max_weights = full(max(weights));

probability_function = @(data, responses, train_ind, test_ind) ...
    knn_probability_discrete(responses, train_ind, test_ind, weights, ...
                             pseudocount);

probability_bound = @(data, responses, train_ind, test_ind, num_positives) ...
    knn_probability_bound_discrete(responses, train_ind, test_ind, ...
        weights, max_weights, pseudocount, num_positives);

selection_functions = cell(max_lookahead, 1);
for i = 1:max_lookahead
    selection_functions{i} = @(data, responses, train_ind) ...
        optimal_search_bound_selection_function(data, responses, ...
            train_ind, probability_function, probability_bound, i);
end