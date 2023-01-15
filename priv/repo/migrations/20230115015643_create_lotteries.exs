defmodule RandomPick.Repo.Migrations.CreateLotteries do
  use Ecto.Migration

  def change do
    create table(:lotteries, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :name, :string, null: false
      add :description, :string
      add :deadline_date, :utc_datetime, null: false
      add :draw_date, :utc_datetime, null: false
      add :available, :boolean, default: true, null: false
      add :owner_id, references(:users, type: :binary_id), null: false
      add :winner_id, references(:users, type: :binary_id)

      timestamps()
    end
  end
end
