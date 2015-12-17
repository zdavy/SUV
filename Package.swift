import PackageDescription

let package = Package(
    dependencies: [
      .Package(url: "../libUV", Version(0,0,1),
      .Package(url: "https://github.com/bppr/Swiftest.git", Version(0,1,4))],
    targets: [
      Target(name: "SUV"),
      Target(name: "Spec", dependencies: [.Target(name: "SUV")]),
      Target(name: "Example", dependencies: [.Target(name: "SUV")])
    ])
