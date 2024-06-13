defmodule LearnAbsinthe.Workers.AuthorWorker do
  use GenServer
  alias LearnAbsinthe.Utils.Author

  def start_link(opts \\ []) do
    GenServer.start_link(__MODULE__, opts, name: __MODULE__)
  end

  @impl GenServer
  def init(_), do: {:ok, %{}}

  def get_author(manager \\ __MODULE__, author_id) do
    GenServer.call(manager, {:fetch, author_id})
  end

  def create_author(manager \\ __MODULE__, author) do
    GenServer.call(manager, {:create, author})
  end

  @impl true
  def handle_call({:fetch, author_id}, _from, state) do
    author = state["#{author_id}"]
    {:reply, author, state}
  end

  @impl true
  def handle_call({:create, author}, _from, state) do
    author_struct = Author.new(author)
    new_state = Map.put(state, "#{author_struct.id}", author_struct)
    {:reply, new_state, new_state}
  end
end
