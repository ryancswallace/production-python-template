# Template for Production Python Projects

TODO

### Configuring GUI-only GitHub Project Settings
* Settings > General > Default branch: `main`
* Settings > General > Enable release immutability > Enable
* Settings > General > Features > Disable any unused features. For example:
  * Disable: Wikis, Sponsorships, Projects
  * Enable: Issues, Preserve this repository, Discussions
* Settings > Rules > Rulesets > Create ruleset "protect-version-tags" protecting tags "v*" from creation, update, deletion except bypass list of repository admin and maintainers
* Settings > Rules > Rulesets > Create ruleset "protect-main-branch" protecting default branch with rules
  * Restrict updates
  * Restrict deletions
  * Require pull request before merging
    * Required approvals: 1
    * Dismiss stale pull request approvals when new commits are pushed
    * Require review from Code Owners
  * Require status checks to pass
    * Do not require status checks on creation
    * Required checks  # TODO
  * Block force pushes
  * Require code scanning results
    * CodeQL
      * Security alerts: High or higher
      * Alerts: errors
* Settings > Actions > General > Allow <account/organization>, and select non-<account/organization>, actions and reusable workflows
  * Under Allow or block specified actions and reusable workflows > enter `actions/*, github/codeql-action/*`
  * Allow actions created by GitHub > Enable
* Settings > Actions > General > Approval for running fork pull request workflows from contributors > Require approval for all external contributors
* Settings > Actions > General > Workflow permissions > Read and write permissions
* Settings > Actions > General > Allow GitHub Actions to create and approve pull requests > Enabled
* Settings > Advanced security > Private vulnerability reporting > Enabled
* Settings > Advanced security > Dependency graph > Enabled
* Settings > Advanced security > Dependabot > Alerts > Enabled
* Settings > Advanced security > Dependabot > Security updates > Enabled
* Settings > Advanced security > Dependabot > Grouped security updates > Enabled (matter of preference)
* Settings > Advanced security > Secret Protection > Enable
* Settings > Advanced security > Secret Protection > Push protection > Enable
* Settings > Email notifications > Enter address (preferably a mailing list with maintainers)
* Settings > Pages > Build and deployment > Source > GitHub Actions
* Homepage > Edit repository details (gear icon) > Complete
  * Description
  * Website (e.g., enable "Use your GitHub Pages website")
  * Topics
  * Include in the home page > Enable
    * Releases
    * Packages
    * Deployments