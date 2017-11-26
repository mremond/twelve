defmodule MyApp.Mixfile do
  use Mix.Project

  def project do
    [app: :my_app,
     version: "0.1.0",
     elixir: "~> 1.5",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps(),
     package: package()]
  end

  def application do
    [
			mod: {MyApp, []},
			applications: [:logger]
		]
  end

  defp deps do
    [
       {:distillery, "~> 1.4.0"}
    ]
  end

  defp package do
    [description: "Elixir support for Kubernetes clustering",
     licenses: ["MIT"],
     maintainers: ["ProcessOne"],
     links: %{"GitHub": "https://github.com/processone/twelve"}]
  end

end
