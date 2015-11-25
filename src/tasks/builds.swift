import Swish
import SwishBuildSwift

Swish.Swift.lib("SUV") { SUV in
  SUV.sources = [(path: "./src/SUV", pattern: "*.swift")]
  SUV.imports = ["./lib/libUV"]
}

Swish.Swift.app("echo", ["SUV"]) { echo in
  echo.sources = [(path: "./examples/echoserver", pattern: "*.swift")]
}

Swish.task("build", ["SUV:build"])
Swish.task("echo", ["SUV:build", "echo:build", "echo:run"])
