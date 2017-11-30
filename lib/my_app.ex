defmodule MyApp do
  use Application

  def start(_type, _args) do
    IO.puts "starting"
		host = System.get_env("HOSTNAME")
		IO.puts "Hostname: #{host}"
		{:ok,  pid} = Task.start_link(__MODULE__, :loop, [])
		connect_nodes()
		{:ok, pid}
  end

	def loop do
		# monitor_nodes()
		loop2()
	end

	def loop2 do
		receive do
			{:job, id} ->
				IO.puts "Executing job ID #{id} on node #{inspect Node.self}"
				:timer.sleep(1000)
		end
		loop2()
	end

	defp monitor_nodes() do
		nodes = get_nodes()
		Enum.each nodes, fn node ->
			Node.monitor(node, true)
			IO.puts "Monitoring node #{node}"
		end
	end

	defp connect_nodes() do
		nodes = get_nodes()
		Enum.each nodes, fn node ->
			if Node.connect(node) do
				IO.puts "Connected to node #{node}"
			end
		end
	end

	defp get_nodes() do
		nodes = System.get_env("NODES")
		case nodes do
			nil ->
				[]
			_ ->
				nodes = String.split(nodes, ",")
				Enum.map nodes, fn node ->
					String.to_atom node
				end
		end
	end

	defp get_active_nodes() do
		node = System.get_env("NODE_NAME")
		nodes = Node.list()
		nodes ++ String.to_atom(node)
	end

	defp get_random_node() do
		Enum.random get_active_nodes()
	end
end
