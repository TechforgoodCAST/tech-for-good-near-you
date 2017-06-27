defmodule Mix.Tasks.Phx.ElmCompile do
  use Mix.Task

  def run(_argv) do
    Mix.shell.cmd("cd assets && npm run build-elm", stderr_to_stdout: true)
  end
end
