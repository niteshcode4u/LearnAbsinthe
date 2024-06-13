defmodule LearnAbsintheWeb.ChannelCase do
  use ExUnit.CaseTemplate

  using do
    quote do
      # Import conveniences for testing with channels
      import Phoenix.ChannelTest
      import LearnAbsintheWeb.ChannelCase

      # The default endpoint for testing
      @endpoint LearnAbsintheWeb.Endpoint
    end
  end

  setup tags do
    LearnAbsinthe.DataCase.setup_sandbox(tags)
    :ok
  end
end
