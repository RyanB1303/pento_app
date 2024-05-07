defmodule PentoWeb.WrongLive do
  use PentoWeb, :live_view

  def mount(_params, _session, socket) do
    # initial state
    {:ok,
     assign(socket,
       score: 0,
       message: "Guess a number.",
       secret_number: :rand.uniform(10) |> to_string(),
       answered_correctly: false
     )}
  end

  def handle_event(
        "guess",
        %{"number" => guess},
        %{assigns: %{secret_number: guess}} = socket
      ) do
    message_correct = "You won! The number was: #{guess}"
    score_correct = socket.assigns.score + 5

    {
      :noreply,
      assign(
        socket,
        score: score_correct,
        message: message_correct,
        answered_correctly: true
      )
    }
  end

  def handle_event(
        "guess",
        %{"number" => guess},
        %{assigns: %{secret_number: secret_number}} = socket
      ) do
    message_wrong = "Your guess: #{guess}. Wrong. Guess again."
    score_wrong = socket.assigns.score - 1

    {
      :noreply,
      assign(
        socket,
        score: score_wrong,
        message: message_wrong
      )
    }
  end
end
