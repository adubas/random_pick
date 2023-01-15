defmodule RandomPick.Lotteries.LotteryParticipants do
  @moduledoc """
    This is the in between table of the participants(user) of each lottery schema and changeset rules
  """

  use Ecto.Schema

  import Ecto.Changeset

  alias RandomPick.Lotteries.Lottery
  alias RandomPick.Users.User

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  @fields [:user_id, :lottery_id]

  schema "lotteries_participants" do
    belongs_to :user, User
    belongs_to :lottery, Lottery

    timestamps()
  end

  def changeset(lottery_participants \\ %__MODULE__{}, params) do
    lottery_participants
    |> cast(params, @fields)
    |> validate_required(@fields)
    |> assoc_constraint(:user)
    |> assoc_constraint(:lottery)
    |> unique_constraint(:lottery_id, name: :lotteries_participants_lottery_id_user_id_index)
  end
end
