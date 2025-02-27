# Releasing the connector service

> Note: This is for internal use within Elastic. Only Elastic members can release the connector service.

The version scheme we use is **MAJOR.MINOR.PATCH.BUILD** and stored in the [VERSION](https://github.com/elastic/connectors-ruby/blob/main/VERSION) file at the root of this repository.

## RubyGem Account

When releasing Gems, you will be asked for an Email and Password. Look into the Vault in the `ent-search-team/rubygem` secret.

## Unified release

**MAJOR.MINOR.PATCH** should match the Elastic and Enterprise Search version it targets and the *BUILD* number should be set to **0** the day the Connector service release is created to be included with the Enterprise Search distribution.

For example, when shipping for `8.1.2`, the version is `8.1.2.0`.

To release the connector service:

1. Make sure all tests and linter pass with `make lint test`
2. Run `make release_service release_utility`
3. Set the [VERSION](../VERSION) file to the new/incremented version on the release branch
4. PR these changes to the appropriate connector service release branch

Two Gems will be published to RubyGems: [connectors_service](https://rubygems.org/gems/connectors_service) and [connectors_utility](https://rubygems.org/gems/connectors_utility)

Take care of the branching (minor releases only):

- Increment the VERSION on main to match the next minor release
- Create a new maintenance branch

After the Elastic unified release is complete

- Update the **BUILD** version ([example PR](https://github.com/elastic/connectors-ruby/pull/81)). Note that the Connectors project does not immediately bump to the next **PATCH** version. That won't happen until that patch release's FF date.

## In-Between releases

Sometimes, we need to release connector service independently from Enterprise Search.
For instance, if someone wants to use the project as an HTTP Service and we have a bug fix we want them to have as soon as possible.

In that case, we increment the **BUILD** number, and follow the same release process than for the unified release.

So `8.1.2.1`, `8.1.2.2` etc. On the next unified release, the version will be bumped to the next **PATCH** value, and **BUILD** set to `0`

**In-Between releases should never introduce new features since they will eventually be merged into the next PATCH release. New features are always done in Developer previews**

## Developer preview releases

For developer previews, we are adding a `pre` tag using an ISO8601 date. You can use `make build_service build_utility`, and the gems will be generated in directory `.gems/`
