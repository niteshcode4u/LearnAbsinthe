defmodule LearnAbsintheWeb.Graphql.Posts.Mutations do
  use Absinthe.Schema.Notation

  input_object :post_create_input do
    field :title, non_null(:string)
    field :description, non_null(:string)
  end

  input_object :post_upadte_input do
    field :id, non_null(:id)
    field :title, :string
    field :description, :string
    field :comment, :string
  end

  object :post_mutations do
    field :create_post, non_null(:post) do
      arg(:post, non_null(:post_create_input))

      resolve(&LearnAbsintheWeb.Graphql.Posts.Resolver.create_post/3)
    end

    field :update_post, non_null(:post) do
      arg(:post, non_null(:post_upadte_input))

      resolve(&LearnAbsintheWeb.Graphql.Posts.Resolver.update_post/3)
    end
  end
end
