defmodule LearnAbsintheWeb.Graphql.Posts.QueriesTest do
  use LearnAbsintheWeb.GraphQlCase

  describe "get_post" do
    test "returns post when found" do
      {:ok, post} = LearnAbsinthe.create_post()

      query = """
      {
        getPost (postId: #{post.id}) {
          title
          description
          comments
        }
      }
      """

      response = post_graph_query(%{query: query})["data"]["getPost"]

      assert response["title"] == post.title
      assert response["description"] == post.description
      assert response["comments"] == post.comments
    end

    test "return not_found error when no post" do
      query = """
      {
        getPost (postId: 99) {
          id
          title
        }
      }
      """

      assert hd(post_graph_query(%{query: query})["errors"])["message"] == "not_found"
    end
  end
end
