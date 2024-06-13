defmodule LearnAbsintheWeb.Graphql.Posts.SubscriptionsTest do
  use LearnAbsintheWeb.SubscriptionCase

  describe "post_created" do
    test "returns post when created" do
      # Set up
      {:ok, post} = LearnAbsinthe.create_post()
      socket = create_socket()

      update_post_subscription = """
        subscription {
          postUpdated(postId: #{post.id}){
            id
            comments
          }
        }
      """

      # Subscribe to a post update operation
      subscription_id = subscribe(socket, update_post_subscription)

      # Let's trigger the subscription by updating an existing post
      update_post_mutation = """
        mutation {
          updatePost(post: {
            id: #{post.id},
            comment: "Adding comment to test update post"
          }){
              id
              comments
            }
        }
      """

      post_graph_query(%{query: update_post_mutation})

      # Check if something has been pushed to the given subscription
      assert_push "subscription:data", %{result: response, subscriptionId: ^subscription_id}

      assert %{
               data: %{
                 "postUpdated" => %{
                   "id" => "#{post.id}",
                   "comments" => ["Adding comment to test update post"]
                 }
               }
             } == response
    end
  end
end
