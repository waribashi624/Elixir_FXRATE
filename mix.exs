defmodule Getrate.Mixfile do
  use Mix.Project

  def project do
    [app: :getrate,
     version: "0.0.1",
     elixir: "~> 1.2",
     #build_embedded: Mix.env == :prod,
     #start_permanent: Mix.env == :prod,
     escript: [ main_module: Getrate ],
     deps: deps]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    [applications: [:logger, :httpotion, :tzdata]]
  end

  # Dependencies can be Hex packages:
  #
  #   {:mydep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:mydep, git: "https://github.com/elixir-lang/mydep.git", tag: "0.1.0"}
  #
  # Type "mix help deps" for more examples and options
  defp deps do
    [
      {:httpotion, "~> 3.0.0"},
      {:floki, "~> 0.8.1"},
      {:tzdata, "== 0.1.8", override: true}
    ]
  end
end
