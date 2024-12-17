printf("Now collect error rate\n");
printf("Depth Training Test\n");

ig_err_rates = [];
for depth = 1:6
  fh = str2func(sprintf("car%d", depth));
  training_err = 0;
  for r = 1:rows(S)
    l = fh(S(r, :));
    if strcmp(S{r, 7}, l) == 0
      training_err = training_err + 1;
    end
  end
  test_err = 0;
  for r = 1:rows(T)
    l = fh(S(r, :));
    if strcmp(S{r, 7}, l) == 0
      test_err = test_err + 1;
    end
  end
  printf("%-5d %-8d %-8d\n", depth, training_err/rows(S), ...
	 test_err/rows(S));
  ig_error_rates(depth, :) = [training_err/rows(S), test_err/rows(S)];
end
