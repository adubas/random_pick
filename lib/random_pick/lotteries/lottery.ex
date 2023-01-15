defmodule RandomPick.Lotteries.Lottery do
  @moduledoc """
    This is the lottery schema and changeset rules
  """

  use Ecto.Schema

  import Ecto.Changeset

  alias RandomPick.Lotteries.LotteryParticipants
  alias RandomPick.Users.User

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  @required_fields [:name, :deadline_date, :draw_date, :owner_id]
  @optinal_fields [:description, :available, :winner_id]
  @fields @required_fields ++ @optinal_fields

  schema "lotteries" do
    field :name, :string
    field :description, :string
    field :deadline_date, :utc_datetime
    field :draw_date, :utc_datetime
    field :available, :boolean, default: true

    belongs_to :owner, User
    belongs_to :winner, User

    many_to_many :participants, User, join_through: LotteryParticipants

    timestamps()
  end

  def changeset(lottery \\ %__MODULE__{}, params) do
    lottery
    |> cast(params, @fields)
    |> validate_required(@required_fields)
    |> assoc_constraint(:owner)
    |> assoc_constraint(:winner)
  end
end
