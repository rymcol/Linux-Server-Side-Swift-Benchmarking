import PackageDescription

let package = Package(
    name: "VaporPress",
    targets: [],
    dependencies: [
        .Package(url: "https://github.com/vapor/engine.git", majorVersion: 1, minor: 0),
        .Package(url: "https://github.com/vapor/routing.git", majorVersion: 1, minor: 0),
        .Package(url: "https://github.com/vapor/json.git", majorVersion: 1, minor: 0),
    ],
    exclude: [
        "Config",
        "Database",
        "Localization",
        "Public",
        "Resources",
        "Tests",
        ]
)
