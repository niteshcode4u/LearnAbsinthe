defmodule LearnAbsinthe.Utils.Post do
  @type t :: %__MODULE__{}

  defstruct id: nil,
            title: nil,
            description: nil,
            author: %LearnAbsinthe.Utils.Author{},
            comments: [],
            created_at: nil

  @spec new(map()) :: %__MODULE__{}
  def new(fields) do
    {author_id, fields} = Map.pop(fields, :author_id)

    fields =
      fields
      |> add_id()
      |> add_author(author_id)
      |> add_timestamp()

    struct!(__MODULE__, fields)
  end

  defp add_id(fields), do: Map.put(fields, :id, System.unique_integer([:monotonic, :positive]))

  defp add_author(fields, author_id),
    do: Map.put(fields, :author, LearnAbsinthe.Utils.Author.get_author_by_id(author_id))

  defp add_timestamp(fields), do: Map.put(fields, :created_at, DateTime.utc_now())
end
