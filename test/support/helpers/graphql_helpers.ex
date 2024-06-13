defmodule LearnAbsintheWeb.GraphQlHelpers do
  import Phoenix.ConnTest
  import Plug.Conn

  # Required by the post function from Phoenix.ConnTest
  @endpoint LearnAbsintheWeb.Endpoint

  def post_graph_query(options, response \\ 200) do
    build_conn()
    |> put_resp_content_type("application/json")
    |> post("/graphql", options)
    |> json_response(response)
  end
end
