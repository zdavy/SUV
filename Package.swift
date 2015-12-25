import PackageDescription

let package = Package(
    name: "SUV",
    dependencies: [
      .Package(url: "https://github.com/zachmokahn/libUV.git", Version(1,0,0)),
      .Package(url: "https://github.com/bppr/Swiftest.git", Version(0,1,5))],
    targets: [
      Target(name: "SUV"),
      Target(name: "Spec", dependencies: [.Target(name: "SUV")])
    ])
