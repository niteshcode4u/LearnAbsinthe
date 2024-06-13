defmodule LearnAbsintheWeb.Schema do
  use Absinthe.Schema

  import_types(LearnAbsintheWeb.Graphql.Posts.Queries)
  import_types(LearnAbsintheWeb.Graphql.Posts.Mutations)
  import_types(LearnAbsintheWeb.Graphql.Posts.Subscriptions)

  query do
    import_fields(:post_queries)
  end

  mutation do
    import_fields(:post_mutations)
  end

  subscription do
    import_fields(:post_subscriptions)
  end
end
