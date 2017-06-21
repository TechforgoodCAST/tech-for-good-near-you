defmodule TechForGoodNearYou.Web.LatLon do

  def get_lat_lon(""), do: {:ok, %{}}

  def get_lat_lon(postcode) do
    case HTTPoison.get(request_url(postcode)) do
      {:ok, response} -> {:ok, grab_lat_lon(response)}
      {:error, reason} -> {:error, reason}
    end
  end

  defp request_url(postcode), do: "https://api.postcodes.io/postcodes/#{String.replace(postcode, " ", "")}"

  defp grab_lat_lon(response) do
    response
    |> Map.get(:body)
    |> Poison.decode!
    |> Map.get("result")
    |> Map.take(["latitude", "longitude"])
  end
end
