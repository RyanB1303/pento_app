defmodule PentoWeb.WrongLive do
  use PentoWeb, :live_view

  def mount(_params, _session, socket) do
    # initial state
    {:ok, assign(socket, score: 0, message: "Make a guess:", time: time())}
  end

  def handle_event("guess", %{"number" => guess}, socket) do
    message = "Your guess: #{guess}. Wrong. Guess again. "
    score = socket.assigns.score - 1
    time_now = time()

    {
      :noreply,
      assign(
        socket,
        score: score,
        message: message,
        time: time_now
      )
    }
  end

  def time() do
    DateTime.utc_now() |> to_string
  end
end
