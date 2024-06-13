defmodule LearnAbsinthe.Workers.PostWorker do
  use GenServer
  alias LearnAbsinthe.Utils.Post

  def start_link(opts \\ []) do
    GenServer.start_link(__MODULE__, opts, name: __MODULE__)
  end

  @impl GenServer
  def init(_), do: {:ok, %{}}

  def get_post(manager \\ __MODULE__, post_id) do
    GenServer.call(manager, {:fetch, post_id})
  end

  def list_post(manager \\ __MODULE__) do
    GenServer.call(manager, :state)
  end

  def create_post(manager \\ __MODULE__, post) do
    GenServer.call(manager, {:create, post})
  end

  def update_post(manager \\ __MODULE__, params_to_update) do
    GenServer.call(manager, {:update, params_to_update})
  end

  @impl true
  def handle_call(:state, _from, state) do
    {:reply, Map.values(state), state}
  end

  @impl true
  def handle_call({:fetch, post_id}, _from, state) do
    post = state["#{post_id}"]
    {:reply, post, state}
  end

  @impl true
  def handle_call({:create, post}, _from, state) do
    post_struct = Post.new(post)
    new_state = Map.put(state, "#{post_struct.id}", post_struct)
    {:reply, post_struct, new_state}
  end

  @impl true
  def handle_call({:update, params_to_update}, _from, state) do
    {_post_to_update, remaining_state} = Map.pop(state, params_to_update.id)

    new_state = Map.put(remaining_state, "#{params_to_update.id}", params_to_update)
    {:reply, params_to_update, new_state}
  end
end
