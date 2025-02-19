<h2 align="center">
    <a href="https://httpie.io" target="blank_">
        <img height="100" alt="nullplatform" src="https://nullplatform.com/favicon/android-chrome-192x192.png" />
    </a>
    <br>
    <br>
     Homebrew Tap Repository
    <br>
</h2>

## What is Homebrew?

Package manager for macOS (or Linux), see more at https://brew.sh

## What is a Tap?

A third-party (in relation to Homebrew) repository providing installable
packages (formulae) on macOS and Linux.

See more at https://docs.brew.sh/Taps

## How do I install packages from here?

```sh
brew install nullplatform/tap/<name>
```

You can also only add the tap which makes formulae within it
available in search results (`brew search` output):

```sh
brew tap nullplatform/tap
```

While you may search across taps, it is necessary to always use
fully qualified name (incl. the `nullplatform/tap/` prefix)
when referring to formulae in external taps such as this one
outside of search.

## What packages are available?

With the following commands, you can install the latest generally available version of each product:
```sh
# Formulae
brew install nullplatform/tap/cli
```

Pre-releases (including as alpha's, beta's, and release candidates) will not be available in this tap.
