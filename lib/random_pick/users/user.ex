defmodule RandomPick.Users.User do
  @moduledoc """
    This is the application User schema and changeset rules
  """

  use Ecto.Schema

  import Ecto.Changeset

  alias RandomPick.Lotteries.{Lottery, LotteryParticipants}

  @primary_key {:id, :binary_id, autogenerate: true}

  @fields [:name, :email, :password]

  schema "users" do
    field :name, :string
    field :email, :string
    field :password, :string

    many_to_many :participated_lotteries, Lottery, join_through: LotteryParticipants
    has_many :won_lotteries, Lottery, foreign_key: :winner_id
    has_many :owned_lotteries, Lottery, foreign_key: :owner_id

    timestamps()
  end

  def changeset(user \\ %__MODULE__{}, params) do
    user
    |> cast(params, @fields)
    |> validate_required(@fields)
    |> unique_constraint(:email)
  end
end
