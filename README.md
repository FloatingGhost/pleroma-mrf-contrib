# MRF Contrib

A few contrib MRFs for Pleroma

## Installation

Add the following to your pleroma's `mix.exs`

```elixir
def deps do
  [
    {:mrfcontrib, git: "https://github.com/FloatingGhost/pleroma-mrf-contrib.git", tag: "v0.0.5"}
  ]
end
```

Then run `MIX_ENV=prod mix deps.get`

## Configuration 

### mrf\_rewrite

```elixir
# Append MRFContrib.RewritePolicy to your policy list
config :pleroma, :instance,
  rewrite_policy: [MRFContrib.RewritePolicy]

config :pleroma, :mrf_rewrite,
    rules: [
        {"replaceme", "replace with me"},
        {~r/[Rr]egex replace/, "replace with me"},
        {:invidious, "https://invidio.us"}
    ]
```

So basically your list of rules should consist of a list of tuples of the form illustrated above.
There are a few special rules you can invoke, the only one currently implemented is `:invidious`
which will rewrite youtube URLs to the specified invidious instance.
