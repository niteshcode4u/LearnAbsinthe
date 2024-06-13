defmodule LearnAbsinthe.Utils.Author do
  @type t :: %__MODULE__{}

  defstruct id: nil,
            first_name: nil,
            last_name: nil

  @spec new(map() | Keyword.t()) :: %__MODULE__{}
  def new(fields),
    do: struct!(__MODULE__, Map.put(fields, :id, System.unique_integer([:monotonic, :positive])))

  def get_author_by_id(author_id), do: LearnAbsinthe.Workers.AuthorWorker.get_author(author_id)
end
