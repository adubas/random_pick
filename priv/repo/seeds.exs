alias RandomPick.Lotteries.{Lottery, LotteryParticipants}
alias RandomPick.Users.User
alias RandomPick.Repo

users_attrs = [
  %{
    name: "John",
    email: "john@mail.com",
    password: "password"
  },
  %{
    name: "Jane",
    email: "jane@mail.com",
    password: "password"
  },
  %{
    name: "Mary",
    email: "mary@mail.com",
    password: "password"
  },
  %{
    name: "Mark",
    email: "mark@mail.com",
    password: "password"
  },
  %{
    name: "Lena",
    email: "lena@mail.com",
    password: "password"
  },
  %{
    name: "Ryan",
    email: "ryan@mail.com",
    password: "password"
  }
]

[user1, user2, user3, user4, user5, user6] =
  users_attrs
  |> Enum.map(fn user ->
    user
    |> User.changeset()
    |> Repo.insert!()
  end)

lotteries_attrs = [
  %{
    name: "Lottery On Going",
    deadline_date: DateTime.add(DateTime.now!("Etc/UTC"), 604_800, :second),
    draw_date: DateTime.add(DateTime.now!("Etc/UTC"), 2_592_000, :second),
    owner_id: user1.id
  },
  %{
    name: "Lottery Finished",
    deadline_date: DateTime.add(DateTime.now!("Etc/UTC"), -2_592_000, :second),
    draw_date: DateTime.add(DateTime.now!("Etc/UTC"), -604_800, :second),
    available: false,
    owner_id: user1.id,
    winner_id: user3.id
  }
]

[lottery_ongoing, lottery_finished] =
  lotteries_attrs
  |> Enum.map(fn lottery ->
    lottery
    |> Lottery.changeset()
    |> Repo.insert!()
  end)

lottery_participants_attrs = [
  %{
    user_id: user2.id,
    lottery_id: lottery_finished.id
  },
  %{
    user_id: user3.id,
    lottery_id: lottery_finished.id
  },
  %{
    user_id: user4.id,
    lottery_id: lottery_finished.id
  },
  %{
    user_id: user5.id,
    lottery_id: lottery_finished.id
  },
  %{
    user_id: user2.id,
    lottery_id: lottery_ongoing.id
  },
  %{
    user_id: user3.id,
    lottery_id: lottery_ongoing.id
  },
  %{
    user_id: user6.id,
    lottery_id: lottery_ongoing.id
  }
]

lottery_participants_attrs
|> Enum.map(fn participant ->
  participant
  |> LotteryParticipants.changeset()
  |> Repo.insert!()
end)
