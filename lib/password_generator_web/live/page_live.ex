defmodule PasswordGeneratorWeb.PageLive do
  use PasswordGeneratorWeb, :live_view
  import Gettext, only: [with_locale: 2]

  @impl true
  def mount(_params, session, socket) do
    locale = case session do
      %{"locale" => locale} -> locale
      _ -> "en"
    end

    socket =
      socket
      |> assign(locale: locale)

    {:ok, socket}
  end

  def render(assigns) do
    ~L"""
    <%= with_locale(@locale, fn -> %>
      <%= gettext "Hello World!" %></h2>
    <% end) %>
    """
  end
end
