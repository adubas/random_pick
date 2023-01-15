defmodule RandomPick.Repo.Migrations.CreateLotteriesParticipants do
  use Ecto.Migration

  def change do
    create table(:lotteries_participants, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :lottery_id, references(:lotteries, type: :binary_id), null: false
      add :user_id, references(:users, type: :binary_id), null: false

      timestamps()
    end

    create unique_index(:lotteries_participants, [:lottery_id, :user_id])
  end
end
