


model_df <- tidy_books %>%
  count(document, word, sort = TRUE) %>%
  pivot_wider(names_from = word, values_from = n, 
              values_fill = list(n = 0)) %>% 
  inner_join(tidy_books, by = c("document" = "document")) %>% 
  select(-gutenberg_id, -document, -word.y) %>% 
  mutate(title = factor(title))

books_split <- initial_split(model_df)
train <- training(books_split)
test <- testing(books_split)

book_folds <- vfold_cv(train)

logistic_spec <- logistic_reg(penalty = tune(), mixture = 1) %>% 
  set_engine("glmnet") %>% 
  set_mode("classification")

lambda_grid <- grid_regular(penalty(), levels = 10)

logistic_rec <- recipe(title ~ ., data = model_df) %>% 
  step_normalize(all_predictors())

wf <- workflow() %>% 
  add_model(logistic_spec) %>%
  add_recipe(logistic_rec)

lambda_cv <- tune_grid(wf,
                       resamples = book_folds,
                       grid = lambda_grid,
                       metrics = metric_set(roc_auc, sens, spec))
