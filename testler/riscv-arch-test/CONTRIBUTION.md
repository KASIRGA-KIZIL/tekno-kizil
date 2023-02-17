# Contributing to RISC-V Architecture Tests

Your inputs are welcome and greatly appreciated! We want to make contributing to this project as easy and transparent as possible, whether it's:

- Reporting a bug
- Discussing the current state of the code
- Submitting a fix
- Proposing new features
- Becoming a maintainer

## We develop with Github
We use github to host code, to track issues and feature requests, as well as accept pull requests.

## We use a simple git flow where all code changes happen through Pull Requests

Pull requests are the best way to propose changes to the codebase. We actively welcome your pull requests:

1. Fork the repo and create your branch from `master`.
2. If you have added new tests, please ensure they adhere to the latest TestFormatSpec and that you have run them on the RVI approved reference
   models (if support in those models is available).
3. If you have updated any test-macros make sure to update the documentation as well.
4. If you have updated the docs, ensure that they render correctly in the respective format.
5. Make sure to create an entry in the CHANGELOG.md. Please refer to the section on versioning below
   to choose an appropriate version number.
6. Ensure the existing tests are not broken and still pass on the the RVI approved reference models.
7. Please include a comment with the SPDX license identifier in all source files, for example:
   ```
   // SPDX-License-Identifier: BSD-3-Clause
   ```
8. Issue that pull request!

## Versioning

When issuing pull requests, an entry in the CHANGELOG.md is mandatory. The arch-test-repo adheres to
the [`Semantic Versioning`](https://semver.org/spec/v2.0.0.html) scheme. Following guidelines must
be followed while assigning a new version number :

- Patch-updates: all doc updates (like typos, more clarification,etc) and updates to unratified extensions.
- Minor-updates: Updates to ratified extensions OR migration of extensions to ratified OR changes in docs regarding policies or spec.
- Major-updates: Changes to the framework flow (backward compatible or incompatible).

Note: You can have either a patch or minor or major update.
Note: In case of a conflict, the maintainers will decide the final version to be assigned.

## Any contributions you make will be under the permissive open-source License
In short, when you submit code changes, your submissions are understood to be under a permissive open source license like BSD-3, Apache-2.0 and CC, etc that covers the project. Feel free to contact the maintainers if that's a concern.

## Report bugs using Github's [issues](https://github.com/riscv/riscv-arch-test/issues)
We use GitHub issues to track public bugs. Report a bug by [opening a new issue](https://github.com/riscv/riscv-arch-test/issues/new); it's that easy!

## Write bug reports with detail, background, and sample code

**Great Bug Reports** tend to have:

- A quick summary and/or background
- Steps to reproduce
  - Be specific!
  - Give sample code if you can. 
- What you expected would happen
- What actually happens
- Notes (possibly including why you think this might be happening, or stuff you tried that didn't work)

## License
By contributing, you agree that your contributions will be licensed under its permissive open source
licenses.

