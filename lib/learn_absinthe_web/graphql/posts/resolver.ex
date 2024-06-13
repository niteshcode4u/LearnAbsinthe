defmodule LearnAbsintheWeb.Graphql.Posts.Resolver do
  @spec create_post(any(), %{:post => any(), optional(any()) => any()}, any()) :: {:ok, any()}
  def create_post(_post, %{post: post_params}, _resolution) do
    LearnAbsinthe.create_post(post_params)
  end

  @spec create_post(any(), %{:post => any(), optional(any()) => any()}, any()) :: {:ok, any()}
  def update_post(_post, %{post: post_params}, _resolution) do
    LearnAbsinthe.update_post(post_params)
  end

  @spec get_post(any(), %{:post_id => any(), optional(any()) => any()}, any()) :: {:ok, any()}
  def get_post(_post, %{post_id: post_id}, _resolution) do
    LearnAbsinthe.get_post_by_id(post_id)
  end

  @spec list_post(any(), any(), any()) :: {:ok, any()}
  def list_post(_post, _params, _resolution) do
    LearnAbsinthe.list_post()
  end
end
