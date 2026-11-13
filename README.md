# swift-spr-renovate-demo

A minimal Swift package that gets its dependencies from a **Swift Package Registry** (SE-0292), not from `git clone`. It shows [Renovate](https://github.com/renovatebot/renovate) updating registry-form dependencies.

Renovate supports this from version 44.234.0, added in [renovatebot/renovate#43899](https://github.com/renovatebot/renovate/pull/43899).

## What's in this repo

- **`Package.swift`** declares two dependencies in the SE-0292 identity form, `.package(id: "scope.name", ...)`:
  - `apple.swift-argument-parser`
  - `apple.swift-log`
- **`.swiftpm/configuration/registries.json`** points SwiftPM at the open [Tuist Registry](https://tuist.dev/blog/2025/11/26/opening-registry) (`https://tuist.dev/api/registry/swift`). It mirrors popular Swift packages and needs no authentication.
- **`Package.resolved`** pins each dependency with the SE-0292 `"kind": "registry"` pin shape. The pins are old on purpose, so Renovate has something to update.

## What Renovate does

Renovate:

1. reads the `.package(id:)` dependencies from `Package.swift`,
2. finds the registry URL in `.swiftpm/configuration/registries.json`,
3. gets the versions from the registry's `GET /{scope}/{name}` endpoint,
4. opens a PR that updates the `from:` version in `Package.swift` and the `kind: "registry"` pin in `Package.resolved`.

See the [open Renovate PRs](https://github.com/bdolewski/swift-spr-renovate-demo/pulls) for the result.

A private registry with authentication needs a host rule with `hostType: "swift-package-registry"`. See the [swift-package-registry datasource docs](https://docs.renovatebot.com/modules/datasource/swift-package-registry/).

## Build locally

```bash
git clone https://github.com/bdolewski/swift-spr-renovate-demo
cd swift-spr-renovate-demo
swift build
swift run Demo "your name"
# prints: info demo: [Demo] Hello, your name!
```

`swift package resolve` gets both dependencies from the Tuist mirror. It needs no authentication.

## Why

[SE-0292](https://github.com/swiftlang/swift-evolution/blob/main/proposals/0292-package-registry.md) adds an HTTP package registry protocol to SwiftPM. Apple's preview registry, the Tuist public registry, and several private registry servers use it. Before 44.234.0, the Renovate `swift` manager only read `.package(url:)` dependencies.

## License

MIT. See `LICENSE`.
