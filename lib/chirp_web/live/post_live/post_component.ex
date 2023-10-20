defmodule ChirpWeb.PostLive.PostComponent do
  use ChirpWeb, :live_component

  alias Chirp.Timeline

  @impl true
  def render(assigns) do
    ~H"""
      <div id={@id} class="post">
        <div class="row">
          <div class="column column-10">
            <div class="post-avatar"></div>
          </div>
          <div class="column column-90 post-body">
            <b>@<%= @post.username %></b>
            <br />
            <%= @post.body %>
          </div>
        </div>

        <div class="row">
          <div class="column">
            <a href="#" phx-click="like" phx-target={@myself}>
              <i class="far fa-heart"></i> <%= @post.likes_count %>
            </a>
          </div>
          <div class="column">
            <a href="#" phx-click="repost" phx-target={@myself}>
              <i class="far fa-retweet"></i> <%= @post.reposts_count %>
            </a>
          </div>
          <div class="column">
            <.link patch={~p"/posts/#{@post}/edit"}>
              <i class="far fa-edit"></i>
              Edit
            </.link>
            <.link
              phx-click={JS.push("delete", value: %{id: @post.id}) |> hide("##{@id}")}
              data-confirm="Are you sure?"
              >
              Delete
            </.link>
          </div>
        </div>
      </div>
    """
  end

  @impl true
  def handle_event("like", _, socket) do
    Chirp.Timeline.inc_likes(socket.assigns.post)
    {:noreply, socket}
  end

  @impl true
  def handle_event("repost", _, socket) do
    Chirp.Timeline.inc_reposts(socket.assigns.post)
    {:noreply, socket}
  end
end
