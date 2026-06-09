import ArgumentParser
import Logging

@main
struct Demo: ParsableCommand {
    static let configuration = CommandConfiguration(
        commandName: "demo",
        abstract: "Trivial executable that links two libraries resolved via SE-0292 registry."
    )

    @Argument(help: "A name to greet.")
    var name: String = "world"

    func run() throws {
        let log = Logger(label: "demo")
        log.info("Hello, \(name)!")
    }
}
