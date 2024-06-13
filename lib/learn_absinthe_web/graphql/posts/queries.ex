defmodule LearnAbsintheWeb.Graphql.Posts.Queries do
  @moduledoc """
  Query & structure for post
  """
  use Absinthe.Schema.Notation

  object :author do
    field :id, non_null(:id)
    field :first_name, non_null(:string)
    field :last_name, non_null(:string)
  end

  @desc "A post"
  object :post do
    field :id, non_null(:id)
    field :title, non_null(:string)
    field :description, non_null(:string)
    field :author, non_null(:author)
    field :comments, list_of(:string)
  end

  object :post_queries do
    field :get_post, :post do
      arg(:post_id, non_null(:id))

      resolve(&LearnAbsintheWeb.Graphql.Posts.Resolver.get_post/3)
    end

    field :get_posts, list_of(:post),
      resolve: &LearnAbsintheWeb.Graphql.Posts.Resolver.list_post/3
  end
end
