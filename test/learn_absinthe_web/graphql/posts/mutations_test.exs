defmodule LearnAbsintheWeb.Graphql.Posts.MutationsTest do
  use LearnAbsintheWeb.GraphQlCase

  describe "post mutation" do
    test "creates a new post" do
      mutation = """
        mutation {createPost (post: {
            title: "Test title",
            description: "Test description for this meet up"
          }
          ){
            id
            title
            description
        }}
      """

      response = post_graph_query(%{query: mutation})["data"]["createPost"]

      assert %{
               "description" => "Test description for this meet up",
               "title" => "Test title"
             } = response
    end

    test "update an existing post" do
      # post set up
      {:ok, post} = LearnAbsinthe.create_post()

      assert post.comments == []

      mutation = """
        mutation {
          updatePost(post: {
            id: #{post.id},
            comment: "Adding comment to test update post"
          }){
              comments
            }
        }
      """

      response = post_graph_query(%{query: mutation})["data"]["updatePost"]

      assert ["Adding comment to test update post"] == response["comments"]
    end

    test "returns not found when post doesn't exist" do
      mutation = """
        mutation {
          updatePost(post: {
            id: 99,
            comment: "Adding comment to test update post"
          }){
              comments
            }
        }
      """

       assert hd(post_graph_query(%{query: mutation})["errors"])["message"] == "not_found"
    end
  end
end
