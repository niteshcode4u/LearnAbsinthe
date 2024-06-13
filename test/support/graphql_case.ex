defmodule LearnAbsintheWeb.GraphQlCase do
  use ExUnit.CaseTemplate

  using do
    quote do
      use LearnAbsintheWeb.ConnCase, async: false

      import LearnAbsintheWeb.GraphQlHelpers
    end
  end
end
