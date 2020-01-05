defmodule MRFContrib.RewritePolicy do
  @behaviour Pleroma.Web.ActivityPub.MRF
  @moduledoc "Rewrite strings (configurable)"

  @builtins %{
    invidious: ~r{href="https://.*youtube.com/watch?.*v=([A-Za-z0-9]+).*"|href="https://.*youtu.be/([A-Za-z0-9]+).*"}
  }

  @impl true
  def filter(%{"type" => "Create", "object" => %{"content" => content}} = message) do
    filters = Pleroma.Config.get([:mrf_rewrite, :rules], [])

    content =
      Enum.reduce(filters, content, fn rule, content ->
        sub(content, rule)
      end)

    message = put_in(message, ["object", "content"], content)
    {:ok, message}
  end

  def filter(object), do: {:ok, object}

  def sub(message, {%Regex{} = from, to}) do
    Regex.replace(from, message, to)
  end

  def sub(message, {from, to}) when is_binary(from) do
    String.replace(message, from, to)
  end

  def sub(message, {:invidious, instance}) do
    sub(message, {@builtins[:invidious], "href=\"#{instance}/watch?v=\\1\""})
  end

  def sub(message, _rule), do: message

  @impl true
  def describe do
    {:ok, %{mrf_rewrite: Pleroma.Config.get(:mrf_rewrite) |> Enum.into(%{})}}
  end
end
