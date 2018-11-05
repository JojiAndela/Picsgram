module UsersHelper
  # Generate contextual button to add/remove friend or friend request.
  def friend_button(friend)
    if  friend != nil
      # Unfriend
      if current_user.friends.find_by(id: friend.id)
        link_to  "Unfriend", friend_path(friend.id), method: :delete,
        class: "btn btn-info", id: "unfriend"

          # Cancel Request
        elsif (friend_request = current_user.friend_requests.find_by(friend_id: friend.id)) && friend != nil
          link_to "Cancel Request", friend_request, method: :delete,
          class: "btn btn-danger", id: "cancel-request"

            # Accept/Reject Request
          elsif (friend_request = current_user.pending_requests.find_by(user_id: friend.id)) && friend != nil
            link_to( "Accept Request", friend_request, method: :patch,
              class: "btn btn-success") +
                link_to("Reject", friend_request, method: :delete,
                  class: "btn btn-danger")

                    # Add Friend
                  else
                    link_to ("Add Friend"),
                    friend_requests_path(friend_id: friend.id), method: :post,
                    class: "btn btn-primary", id: "add-friend"
      end
    end
  end



end
