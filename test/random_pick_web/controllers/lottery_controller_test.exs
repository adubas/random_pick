defmodule RandomPickWeb.LotteryControllerTest do
  use RandomPickWeb.ConnCase, async: true

  import RandomPick.Factory

  alias Ecto.UUID
  alias RandomPick.Lotteries.Lottery
  alias RandomPick.Repo

  describe "POST /create_lottery" do
    test "returns error when params are invalid", %{conn: conn} do
      params = %{
        "name" => nil,
        "description" => nil,
        "deadline_date" => to_string(Date.utc_today()),
        "draw_date" => to_string(Date.utc_today()),
        "owner_id" => UUID.generate()
      }

      path = Routes.lottery_path(conn, :create, params)

      assert %{
               "errors" => %{
                 "deadline_date" => ["is invalid"],
                 "draw_date" => ["is invalid"],
                 "name" => ["can't be blank"]
               }
             } =
               conn
               |> post(path)
               |> json_response(:bad_request)
    end

    test "returns error when owner doesn't exist", %{conn: conn} do
      params = %{
        "name" => "Lottery",
        "description" => "this is a lottery",
        "deadline_date" => to_string(DateTime.now!("Etc/UTC")),
        "draw_date" => to_string(DateTime.now!("Etc/UTC")),
        "owner_id" => UUID.generate()
      }

      path = Routes.lottery_path(conn, :create, params)

      assert %{
               "errors" => %{
                 "owner" => ["does not exist"]
               }
             } =
               conn
               |> post(path)
               |> json_response(:bad_request)
    end

    test "returns lottery id when param are valid", %{conn: conn} do
      owner = insert(:user)
      deadline = DateTime.now!("Etc/UTC")
      draw = DateTime.now!("Etc/UTC")

      params = %{
        "name" => "Lottery",
        "description" => "this is a lottery",
        "deadline_date" => to_string(deadline),
        "draw_date" => to_string(draw),
        "owner_id" => owner.id
      }

      path = Routes.lottery_path(conn, :create, params)

      assert %{"id" => id} =
               conn
               |> post(path)
               |> json_response(:ok)

      lottery = Lottery |> Repo.get_by(id: id)

      assert lottery.name == "Lottery"
      assert lottery.description == "this is a lottery"
      assert DateTime.to_date(lottery.deadline_date) == DateTime.to_date(deadline)
      assert DateTime.to_date(lottery.draw_date) == DateTime.to_date(draw)
    end
  end
end
