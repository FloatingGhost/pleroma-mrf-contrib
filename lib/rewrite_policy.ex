defmodule MRFContrib.RewritePolicy do
  @behavior Pleroma.Web.ActivityPub.MRF

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

  def sub(message, {from, to}) do
    String.replace(message, from, to)
  end
end
