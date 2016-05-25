ExUnit.start

Mix.Task.run "ecto.create", ~w(-r NgorungBattleshipGame.Repo --quiet)
Mix.Task.run "ecto.migrate", ~w(-r NgorungBattleshipGame.Repo --quiet)
Ecto.Adapters.SQL.begin_test_transaction(NgorungBattleshipGame.Repo)

