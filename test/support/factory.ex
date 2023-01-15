defmodule RandomPick.Factory do
  @moduledoc false

  use ExMachina.Ecto, repo: RandomPick.Repo

  alias RandomPick.Lotteries.{Lottery, LotteryParticipants}
  alias RandomPick.Users.User

  def user_factory do
    %User{
      name: Faker.Person.name(),
      email: Faker.Internet.email(),
      password: Faker.Lorem.characters(12) |> to_string()
    }
  end

  def lottery_factory do
    %Lottery{
      name: Faker.Lorem.characters(10) |> to_string(),
      description: Faker.Lorem.characters(50) |> to_string(),
      deadline_date: DateTime.add(DateTime.now!("Etc/UTC"), 604_800, :second),
      draw_date: DateTime.add(DateTime.now!("Etc/UTC"), 2_592_000, :second),
      available: true,
      owner: build(:user)
    }
  end

  def lottery_participant_factory do
    %LotteryParticipants{
      user: build(:user),
      lottery: build(:lottery)
    }
  end
end
