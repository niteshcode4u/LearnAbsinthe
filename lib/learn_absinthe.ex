defmodule LearnAbsinthe do
  @moduledoc """
  LearnAbsinthe keeps the contexts that define your domain
  and business logic.

  Contexts are also responsible for managing your data, regardless
  if it comes from the database, an external API or others.
  """

  @names ~w(Ramesh Mishra Nitesh Raghav Mango Apple Margo Mike Somename)
  @post_title ~w(LearningAbsinthe GraphQlDemo CuriousmMeetup SomethingNew ForgotTheName)
  @description "This description is for absinthe meet up"

  def create_author(author_params \\ nil) do
    # Just for testing purpose
    author_params =
      author_params || %{first_name: Enum.random(@names), last_name: Enum.random(@names)}

    {:ok, LearnAbsinthe.Workers.AuthorWorker.create_author(author_params)}
  end

  def create_post(post_params \\ nil) do
    # Just for testing purpose else it should get from auth token
    author = create_author() |> elem(1) |> Map.values() |> hd()

    post_params = if is_nil(post_params) do
      %{title: Enum.random(@post_title), description: @description, author_id: author.id}
    else
      Map.put(post_params, :author_id, author.id)
    end


    {:ok, LearnAbsinthe.Workers.PostWorker.create_post(post_params)}
  end

  @spec update_post(%{:comment => any(), :id => any(), optional(any()) => any()}) :: {:ok, any()}
  def update_post(post_params) do
    case get_post_by_id(post_params.id) do
      {:error, "not_found"} ->
        {:error, "not_found"}

      {:ok, existing_post} ->
        post_comments =
          if post_params.comment,
            do: existing_post.comments ++ List.wrap(post_params.comment),
            else: existing_post.comments

        post_params = Map.put(post_params, :comments, post_comments)
        params_to_update = Map.merge(existing_post, post_params)

        {:ok, LearnAbsinthe.Workers.PostWorker.update_post(params_to_update)}
    end
  end

  @spec get_post_by_id(String.t()) :: map()
  def get_post_by_id(post_id) do
    case  LearnAbsinthe.Workers.PostWorker.get_post(to_string(post_id)) do
      nil -> {:error, "not_found"}
      post -> {:ok, post}
    end
  end

  @spec list_post() :: list()
  def list_post do
    {:ok, LearnAbsinthe.Workers.PostWorker.list_post()}
  end
end
