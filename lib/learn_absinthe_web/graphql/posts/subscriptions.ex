defmodule LearnAbsintheWeb.Graphql.Posts.Subscriptions do
  use Absinthe.Schema.Notation

  object :post_subscriptions do
    field :post_updated, non_null(:post) do
      arg(:post_id, non_null(:id))

      config(fn %{post_id: post_id} = _post, _context ->
        {:ok, topic: "post:#{post_id}"}
      end)

      trigger(:update_post, topic: fn post -> "post:#{post.id}" end)
    end
  end
end
