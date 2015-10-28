import Swish
import SwishBuildSwift

Swish.Swift.lib("SUV") { SUV in
  SUV.sources = [(path: "./src/SUV", pattern: "*.swift")]
  SUV.imports = ["./lib/libUV"]
}

Swish.task("build", ["SUV:build"])
