defmodule TechForGoodNearYou.Web.ElmControllerTest do
  use TechForGoodNearYou.Web.ConnCase

  test "GET /", %{conn: conn} do
    conn = get conn, "/"
    assert html_response(conn, 200) =~ "Tech for Good Near You!"
  end
end
