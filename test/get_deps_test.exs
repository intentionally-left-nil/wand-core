defmodule GetDepsTest do
  use ExUnit.Case, async: true
  import Mox
  import ExUnit.CaptureIO

  setup :verify_on_exit!

  test "prints config" do
    stub_project()
    expected = [["mox","~> 0.3.2",[["only","test"]]],["ex_doc",">= 0.0.0",[["only","dev"]]]]
    result = capture_io(fn -> Mix.Tasks.Wand.GetDeps.run([]) end) |> Wand.Poison.decode!()
    assert result == expected
  end

  def stub_project() do
    config = [
      deps: [
        {:mox, "~> 0.3.2", [only: :test]},
        {:ex_doc, ">= 0.0.0", [only: :dev]}
      ]
    ]
    expect(WandCore.ProjectMock, :config, fn() -> config end)
  end
end