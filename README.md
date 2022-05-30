# Apple Notarization Scripts
I primarily develop software using [CMake](https://cmake.org/), not creating a project in Xcode from the start, to better enable supporting multiple platforms beyond Apple's; CMake can produce Xcode projects, so Xcode can still be used. So, I created these command line scripts to fit into my CMake, command-line-based workflow.

All the scripts require that the Xcode command line tools be installed. [This page explains how to get the command line tools](https://developer.apple.com/library/archive/technotes/tn2339/_index.html).

The scripts also assume that your credentials for notarization are available from a keychain item named `AC_PASSWORD`. [This page explains how to create the keychain item](https://developer.apple.com/documentation/security/notarizing_macos_software_before_distribution/customizing_the_notarization_workflow).

The file(s) you submit for notarization must have been signed with a certificate provided by Apple, from having paid for the [Apple Developer Enrollment](https://developer.apple.com/support/enrollment/). The method by which you sign can vary, based on your development workflow, and will not be explained here.

## Usage
`notarize.sh` takes one argument, the file to submit. **It must be an actual file, not an unpackaged application bundle ("Application.app"), such as a DMG disk image, or a ZIP archive.**
```sh
./notarize.sh Application.dmg
```

`log.sh` takes one argument, the submission id, which is provided after the `id:` line in the output of these scripts. A handy tip is to pipe the output of `log.sh` to `less`, so you can easily review the log to check for any issues; even if the submission succeeds, it's still recommended to always review the log for every submission, as it's an easy way to catch if all your binaries and libraries are properly Universal Binary (both `x86_64` and `arm64`, as of the time this was written):
```sh
./log.sh vvvvvvvv-wwww-xxxx-yyyy-zzzzzzzzzzzz | less
```

`staple.sh` takes one argument, the name of the file you previously submitted. Stapling is recommended before distribution, as it allows your software to function if ran for the first time on a system not connected to the internet at the time of running. Without stapling, macOS will check online to see if the software had been successfully notarized, and will fail the check if no internet connection is available:
```sh
./staple Application.dmg
```

`history.sh` requires no special consideration; just run it, and it will display your complete history of submissions:
```sh
./history.sh
```

After `notarize.sh` and `staple.sh` have been run for your software, and notarization was successful, your software is ready for distribution.
