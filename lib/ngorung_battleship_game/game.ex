defmodule NgorungBattleshipGame.Game do
  @moduledoc """
  Game server - day la server cua game
  """

  use GenServer
  alias NgorungBattleshipGame.Player

  defstruct [
    id: nil,
    players: [],
    channels: [],
    rounds: []
  ]

  # Cac API

  def start_link(id) do
    GenServer.start_link(__MODULE__, [id], name: ref(id))
  end

  def join(id, %Player{} = player, pid) do
    case GenServer.whereis(ref(id)) do
      nil ->
        {:error, "Game khong ton tai"}
      game ->
        GenServer.call(game, {:join, player, pid})
    end
  end

  # Server

  def init(id), do: {:ok, %NgorungBattleshipGame.Game{id: id}}

  def handle_call({:join, player, pid}, _from, game) do
    cond do
      length(game.players) == 2 ->
        {:reply, {:error, "Khong co nguoi choi nao dang o day"}, game}
      Enum.member?(game.players, player) ->
        {:reply, {:error, "Nguoi choi da vao"}, game}
      true ->
        Process.monitor(pid)
        game = %{game | players: [player | game.players], channels: [pid | game.channels]}

        {:reply, {:ok, self}, game}
    end
  end

  def handle_info({:DOWN, _ref, :process, _pid, _reson}, game) do
    {:stop, :normal, game}
  end

  @doc """
  Generates global reference
  """

  def ref(id), do: {:global, {:game, id}}
end
