require 'rails_helper'
# rubocop:disable LineLength

describe GithubWebhooksController do
  describe '#github_pull_request' do
    it 'returns the file contents given a repo, filename, and commit sha' do
      body = {
        "action": 'synchronize',
        "number": 19,
        "pull_request": {
          "url": 'https://api.github.com/repos/gemfarmer/github_webhook/pulls/19',
          "id": 97_183_997,
          "html_url": 'https://github.com/gemfarmer/github_webhook/pull/19',
          "diff_url": 'https://github.com/gemfarmer/github_webhook/pull/19.diff',
          "patch_url": 'https://github.com/gemfarmer/github_webhook/pull/19.patch',
          "issue_url": 'https://api.github.com/repos/gemfarmer/github_webhook/issues/19',
          "number": 19,
          "state": 'open',
          "locked": false,
          "title": 'Changes to trigger pull request review',
          "user": {
            "login": 'gemfarmer',
            "id": 4_803_473,
            "avatar_url": 'https://avatars.githubusercontent.com/u/4803473?v=3',
            "gravatar_id": '',
            "url": 'https://api.github.com/users/gemfarmer',
            "html_url": 'https://github.com/gemfarmer',
            "followers_url": 'https://api.github.com/users/gemfarmer/followers',
            "following_url": 'https://api.github.com/users/gemfarmer/following{/other_user}',
            "gists_url": 'https://api.github.com/users/gemfarmer/gists{/gist_id}',
            "starred_url": 'https://api.github.com/users/gemfarmer/starred{/owner}{/repo}',
            "subscriptions_url": 'https://api.github.com/users/gemfarmer/subscriptions',
            "organizations_url": 'https://api.github.com/users/gemfarmer/orgs',
            "repos_url": 'https://api.github.com/users/gemfarmer/repos',
            "events_url": 'https://api.github.com/users/gemfarmer/events{/privacy}',
            "received_events_url": 'https://api.github.com/users/gemfarmer/received_events',
            "type": 'User',
            "site_admin": false
          },
          "body": '',
          "created_at": '2016-12-08T19:23:59Z',
          "updated_at": '2016-12-08T19:40:12Z',
          "closed_at": nil,
          "merged_at": nil,
          "merge_commit_sha": '42da0556cc91631b49c80675398742a3ecc072c0',
          "assignee": nil,
          "assignees": [

          ],
          "milestone": nil,
          "commits_url": 'https://api.github.com/repos/gemfarmer/github_webhook/pulls/19/commits',
          "review_comments_url": 'https://api.github.com/repos/gemfarmer/github_webhook/pulls/19/comments',
          "review_comment_url": 'https://api.github.com/repos/gemfarmer/github_webhook/pulls/comments{/number}',
          "comments_url": 'https://api.github.com/repos/gemfarmer/github_webhook/issues/19/comments',
          "statuses_url": 'https://api.github.com/repos/gemfarmer/github_webhook/statuses/90e60db2cde7a69b96e7fe7fa88217616b68c474',
          "head": {
            "label": 'gemfarmer:pull-review',
            "ref": 'pull-review',
            "sha": '90e60db2cde7a69b96e7fe7fa88217616b68c474',
            "user": {
              "login": 'gemfarmer',
              "id": 4_803_473,
              "avatar_url": 'https://avatars.githubusercontent.com/u/4803473?v=3',
              "gravatar_id": '',
              "url": 'https://api.github.com/users/gemfarmer',
              "html_url": 'https://github.com/gemfarmer',
              "followers_url": 'https://api.github.com/users/gemfarmer/followers',
              "following_url": 'https://api.github.com/users/gemfarmer/following{/other_user}',
              "gists_url": 'https://api.github.com/users/gemfarmer/gists{/gist_id}',
              "starred_url": 'https://api.github.com/users/gemfarmer/starred{/owner}{/repo}',
              "subscriptions_url": 'https://api.github.com/users/gemfarmer/subscriptions',
              "organizations_url": 'https://api.github.com/users/gemfarmer/orgs',
              "repos_url": 'https://api.github.com/users/gemfarmer/repos',
              "events_url": 'https://api.github.com/users/gemfarmer/events{/privacy}',
              "received_events_url": 'https://api.github.com/users/gemfarmer/received_events',
              "type": 'User',
              "site_admin": false
            },
            "repo": {
              "id": 71_174_655,
              "name": 'github_webhook',
              "full_name": 'gemfarmer/github_webhook',
              "owner": {
                "login": 'gemfarmer',
                "id": 4_803_473,
                "avatar_url": 'https://avatars.githubusercontent.com/u/4803473?v=3',
                "gravatar_id": '',
                "url": 'https://api.github.com/users/gemfarmer',
                "html_url": 'https://github.com/gemfarmer',
                "followers_url": 'https://api.github.com/users/gemfarmer/followers',
                "following_url": 'https://api.github.com/users/gemfarmer/following{/other_user}',
                "gists_url": 'https://api.github.com/users/gemfarmer/gists{/gist_id}',
                "starred_url": 'https://api.github.com/users/gemfarmer/starred{/owner}{/repo}',
                "subscriptions_url": 'https://api.github.com/users/gemfarmer/subscriptions',
                "organizations_url": 'https://api.github.com/users/gemfarmer/orgs',
                "repos_url": 'https://api.github.com/users/gemfarmer/repos',
                "events_url": 'https://api.github.com/users/gemfarmer/events{/privacy}',
                "received_events_url": 'https://api.github.com/users/gemfarmer/received_events',
                "type": 'User',
                "site_admin": false
              },
              "private": false,
              "html_url": 'https://github.com/gemfarmer/github_webhook',
              "description": nil,
              "fork": false,
              "url": 'https://api.github.com/repos/gemfarmer/github_webhook',
              "forks_url": 'https://api.github.com/repos/gemfarmer/github_webhook/forks',
              "keys_url": 'https://api.github.com/repos/gemfarmer/github_webhook/keys{/key_id}',
              "collaborators_url": 'https://api.github.com/repos/gemfarmer/github_webhook/collaborators{/collaborator}',
              "teams_url": 'https://api.github.com/repos/gemfarmer/github_webhook/teams',
              "hooks_url": 'https://api.github.com/repos/gemfarmer/github_webhook/hooks',
              "issue_events_url": 'https://api.github.com/repos/gemfarmer/github_webhook/issues/events{/number}',
              "events_url": 'https://api.github.com/repos/gemfarmer/github_webhook/events',
              "assignees_url": 'https://api.github.com/repos/gemfarmer/github_webhook/assignees{/user}',
              "branches_url": 'https://api.github.com/repos/gemfarmer/github_webhook/branches{/branch}',
              "tags_url": 'https://api.github.com/repos/gemfarmer/github_webhook/tags',
              "blobs_url": 'https://api.github.com/repos/gemfarmer/github_webhook/git/blobs{/sha}',
              "git_tags_url": 'https://api.github.com/repos/gemfarmer/github_webhook/git/tags{/sha}',
              "git_refs_url": 'https://api.github.com/repos/gemfarmer/github_webhook/git/refs{/sha}',
              "trees_url": 'https://api.github.com/repos/gemfarmer/github_webhook/git/trees{/sha}',
              "statuses_url": 'https://api.github.com/repos/gemfarmer/github_webhook/statuses/{sha}',
              "languages_url": 'https://api.github.com/repos/gemfarmer/github_webhook/languages',
              "stargazers_url": 'https://api.github.com/repos/gemfarmer/github_webhook/stargazers',
              "contributors_url": 'https://api.github.com/repos/gemfarmer/github_webhook/contributors',
              "subscribers_url": 'https://api.github.com/repos/gemfarmer/github_webhook/subscribers',
              "subscription_url": 'https://api.github.com/repos/gemfarmer/github_webhook/subscription',
              "commits_url": 'https://api.github.com/repos/gemfarmer/github_webhook/commits{/sha}',
              "git_commits_url": 'https://api.github.com/repos/gemfarmer/github_webhook/git/commits{/sha}',
              "comments_url": 'https://api.github.com/repos/gemfarmer/github_webhook/comments{/number}',
              "issue_comment_url": 'https://api.github.com/repos/gemfarmer/github_webhook/issues/comments{/number}',
              "contents_url": 'https://api.github.com/repos/gemfarmer/github_webhook/contents/{+path}',
              "compare_url": 'https://api.github.com/repos/gemfarmer/github_webhook/compare/{base}...{head}',
              "merges_url": 'https://api.github.com/repos/gemfarmer/github_webhook/merges',
              "archive_url": 'https://api.github.com/repos/gemfarmer/github_webhook/{archive_format}{/ref}',
              "downloads_url": 'https://api.github.com/repos/gemfarmer/github_webhook/downloads',
              "issues_url": 'https://api.github.com/repos/gemfarmer/github_webhook/issues{/number}',
              "pulls_url": 'https://api.github.com/repos/gemfarmer/github_webhook/pulls{/number}',
              "milestones_url": 'https://api.github.com/repos/gemfarmer/github_webhook/milestones{/number}',
              "notifications_url": 'https://api.github.com/repos/gemfarmer/github_webhook/notifications{?since,all,participating}',
              "labels_url": 'https://api.github.com/repos/gemfarmer/github_webhook/labels{/name}',
              "releases_url": 'https://api.github.com/repos/gemfarmer/github_webhook/releases{/id}',
              "deployments_url": 'https://api.github.com/repos/gemfarmer/github_webhook/deployments',
              "created_at": '2016-10-17T19:41:56Z',
              "updated_at": '2016-10-17T19:41:56Z',
              "pushed_at": '2016-12-08T19:40:12Z',
              "git_url": 'git://github.com/gemfarmer/github_webhook.git',
              "ssh_url": 'git@github.com:gemfarmer/github_webhook.git',
              "clone_url": 'https://github.com/gemfarmer/github_webhook.git',
              "svn_url": 'https://github.com/gemfarmer/github_webhook',
              "homepage": nil,
              "size": 64,
              "stargazers_count": 0,
              "watchers_count": 0,
              "language": nil,
              "has_issues": true,
              "has_downloads": true,
              "has_wiki": true,
              "has_pages": false,
              "forks_count": 0,
              "mirror_url": nil,
              "open_issues_count": 19,
              "forks": 0,
              "open_issues": 19,
              "watchers": 0,
              "default_branch": 'master'
            }
          },
          "base": {
            "label": 'gemfarmer:master',
            "ref": 'master',
            "sha": 'b0b50800ee737d086e0411a21cd0432832c7756b',
            "user": {
              "login": 'gemfarmer',
              "id": 4_803_473,
              "avatar_url": 'https://avatars.githubusercontent.com/u/4803473?v=3',
              "gravatar_id": '',
              "url": 'https://api.github.com/users/gemfarmer',
              "html_url": 'https://github.com/gemfarmer',
              "followers_url": 'https://api.github.com/users/gemfarmer/followers',
              "following_url": 'https://api.github.com/users/gemfarmer/following{/other_user}',
              "gists_url": 'https://api.github.com/users/gemfarmer/gists{/gist_id}',
              "starred_url": 'https://api.github.com/users/gemfarmer/starred{/owner}{/repo}',
              "subscriptions_url": 'https://api.github.com/users/gemfarmer/subscriptions',
              "organizations_url": 'https://api.github.com/users/gemfarmer/orgs',
              "repos_url": 'https://api.github.com/users/gemfarmer/repos',
              "events_url": 'https://api.github.com/users/gemfarmer/events{/privacy}',
              "received_events_url": 'https://api.github.com/users/gemfarmer/received_events',
              "type": 'User',
              "site_admin": false
            },
            "repo": {
              "id": 71_174_655,
              "name": 'github_webhook',
              "full_name": 'gemfarmer/github_webhook',
              "owner": {
                "login": 'gemfarmer',
                "id": 4_803_473,
                "avatar_url": 'https://avatars.githubusercontent.com/u/4803473?v=3',
                "gravatar_id": '',
                "url": 'https://api.github.com/users/gemfarmer',
                "html_url": 'https://github.com/gemfarmer',
                "followers_url": 'https://api.github.com/users/gemfarmer/followers',
                "following_url": 'https://api.github.com/users/gemfarmer/following{/other_user}',
                "gists_url": 'https://api.github.com/users/gemfarmer/gists{/gist_id}',
                "starred_url": 'https://api.github.com/users/gemfarmer/starred{/owner}{/repo}',
                "subscriptions_url": 'https://api.github.com/users/gemfarmer/subscriptions',
                "organizations_url": 'https://api.github.com/users/gemfarmer/orgs',
                "repos_url": 'https://api.github.com/users/gemfarmer/repos',
                "events_url": 'https://api.github.com/users/gemfarmer/events{/privacy}',
                "received_events_url": 'https://api.github.com/users/gemfarmer/received_events',
                "type": 'User',
                "site_admin": false
              },
              "private": false,
              "html_url": 'https://github.com/gemfarmer/github_webhook',
              "description": nil,
              "fork": false,
              "url": 'https://api.github.com/repos/gemfarmer/github_webhook',
              "forks_url": 'https://api.github.com/repos/gemfarmer/github_webhook/forks',
              "keys_url": 'https://api.github.com/repos/gemfarmer/github_webhook/keys{/key_id}',
              "collaborators_url": 'https://api.github.com/repos/gemfarmer/github_webhook/collaborators{/collaborator}',
              "teams_url": 'https://api.github.com/repos/gemfarmer/github_webhook/teams',
              "hooks_url": 'https://api.github.com/repos/gemfarmer/github_webhook/hooks',
              "issue_events_url": 'https://api.github.com/repos/gemfarmer/github_webhook/issues/events{/number}',
              "events_url": 'https://api.github.com/repos/gemfarmer/github_webhook/events',
              "assignees_url": 'https://api.github.com/repos/gemfarmer/github_webhook/assignees{/user}',
              "branches_url": 'https://api.github.com/repos/gemfarmer/github_webhook/branches{/branch}',
              "tags_url": 'https://api.github.com/repos/gemfarmer/github_webhook/tags',
              "blobs_url": 'https://api.github.com/repos/gemfarmer/github_webhook/git/blobs{/sha}',
              "git_tags_url": 'https://api.github.com/repos/gemfarmer/github_webhook/git/tags{/sha}',
              "git_refs_url": 'https://api.github.com/repos/gemfarmer/github_webhook/git/refs{/sha}',
              "trees_url": 'https://api.github.com/repos/gemfarmer/github_webhook/git/trees{/sha}',
              "statuses_url": 'https://api.github.com/repos/gemfarmer/github_webhook/statuses/{sha}',
              "languages_url": 'https://api.github.com/repos/gemfarmer/github_webhook/languages',
              "stargazers_url": 'https://api.github.com/repos/gemfarmer/github_webhook/stargazers',
              "contributors_url": 'https://api.github.com/repos/gemfarmer/github_webhook/contributors',
              "subscribers_url": 'https://api.github.com/repos/gemfarmer/github_webhook/subscribers',
              "subscription_url": 'https://api.github.com/repos/gemfarmer/github_webhook/subscription',
              "commits_url": 'https://api.github.com/repos/gemfarmer/github_webhook/commits{/sha}',
              "git_commits_url": 'https://api.github.com/repos/gemfarmer/github_webhook/git/commits{/sha}',
              "comments_url": 'https://api.github.com/repos/gemfarmer/github_webhook/comments{/number}',
              "issue_comment_url": 'https://api.github.com/repos/gemfarmer/github_webhook/issues/comments{/number}',
              "contents_url": 'https://api.github.com/repos/gemfarmer/github_webhook/contents/{+path}',
              "compare_url": 'https://api.github.com/repos/gemfarmer/github_webhook/compare/{base}...{head}',
              "merges_url": 'https://api.github.com/repos/gemfarmer/github_webhook/merges',
              "archive_url": 'https://api.github.com/repos/gemfarmer/github_webhook/{archive_format}{/ref}',
              "downloads_url": 'https://api.github.com/repos/gemfarmer/github_webhook/downloads',
              "issues_url": 'https://api.github.com/repos/gemfarmer/github_webhook/issues{/number}',
              "pulls_url": 'https://api.github.com/repos/gemfarmer/github_webhook/pulls{/number}',
              "milestones_url": 'https://api.github.com/repos/gemfarmer/github_webhook/milestones{/number}',
              "notifications_url": 'https://api.github.com/repos/gemfarmer/github_webhook/notifications{?since,all,participating}',
              "labels_url": 'https://api.github.com/repos/gemfarmer/github_webhook/labels{/name}',
              "releases_url": 'https://api.github.com/repos/gemfarmer/github_webhook/releases{/id}',
              "deployments_url": 'https://api.github.com/repos/gemfarmer/github_webhook/deployments',
              "created_at": '2016-10-17T19:41:56Z',
              "updated_at": '2016-10-17T19:41:56Z',
              "pushed_at": '2016-12-08T19:40:12Z',
              "git_url": 'git://github.com/gemfarmer/github_webhook.git',
              "ssh_url": 'git@github.com:gemfarmer/github_webhook.git',
              "clone_url": 'https://github.com/gemfarmer/github_webhook.git',
              "svn_url": 'https://github.com/gemfarmer/github_webhook',
              "homepage": nil,
              "size": 64,
              "stargazers_count": 0,
              "watchers_count": 0,
              "language": nil,
              "has_issues": true,
              "has_downloads": true,
              "has_wiki": true,
              "has_pages": false,
              "forks_count": 0,
              "mirror_url": nil,
              "open_issues_count": 19,
              "forks": 0,
              "open_issues": 19,
              "watchers": 0,
              "default_branch": 'master'
            }
          },
          "_links": {
            "self": {
              "href": 'https://api.github.com/repos/gemfarmer/github_webhook/pulls/19'
            },
            "html": {
              "href": 'https://github.com/gemfarmer/github_webhook/pull/19'
            },
            "issue": {
              "href": 'https://api.github.com/repos/gemfarmer/github_webhook/issues/19'
            },
            "comments": {
              "href": 'https://api.github.com/repos/gemfarmer/github_webhook/issues/19/comments'
            },
            "review_comments": {
              "href": 'https://api.github.com/repos/gemfarmer/github_webhook/pulls/19/comments'
            },
            "review_comment": {
              "href": 'https://api.github.com/repos/gemfarmer/github_webhook/pulls/comments{/number}'
            },
            "commits": {
              "href": 'https://api.github.com/repos/gemfarmer/github_webhook/pulls/19/commits'
            },
            "statuses": {
              "href": 'https://api.github.com/repos/gemfarmer/github_webhook/statuses/90e60db2cde7a69b96e7fe7fa88217616b68c474'
            }
          },
          "merged": false,
          "mergeable": nil,
          "mergeable_state": 'unknown',
          "merged_by": nil,
          "comments": 0,
          "review_comments": 0,
          "commits": 5,
          "additions": 9,
          "deletions": 0,
          "changed_files": 1
        },
        "before": '3f01d0a79af1e860d55455dc15fdf9da150e0220',
        "after": '90e60db2cde7a69b96e7fe7fa88217616b68c474',
        "repository": {
          "id": 71_174_655,
          "name": 'github_webhook',
          "full_name": 'gemfarmer/github_webhook',
          "owner": {
            "login": 'gemfarmer',
            "id": 4_803_473,
            "avatar_url": 'https://avatars.githubusercontent.com/u/4803473?v=3',
            "gravatar_id": '',
            "url": 'https://api.github.com/users/gemfarmer',
            "html_url": 'https://github.com/gemfarmer',
            "followers_url": 'https://api.github.com/users/gemfarmer/followers',
            "following_url": 'https://api.github.com/users/gemfarmer/following{/other_user}',
            "gists_url": 'https://api.github.com/users/gemfarmer/gists{/gist_id}',
            "starred_url": 'https://api.github.com/users/gemfarmer/starred{/owner}{/repo}',
            "subscriptions_url": 'https://api.github.com/users/gemfarmer/subscriptions',
            "organizations_url": 'https://api.github.com/users/gemfarmer/orgs',
            "repos_url": 'https://api.github.com/users/gemfarmer/repos',
            "events_url": 'https://api.github.com/users/gemfarmer/events{/privacy}',
            "received_events_url": 'https://api.github.com/users/gemfarmer/received_events',
            "type": 'User',
            "site_admin": false
          },
          "private": false,
          "html_url": 'https://github.com/gemfarmer/github_webhook',
          "description": nil,
          "fork": false,
          "url": 'https://api.github.com/repos/gemfarmer/github_webhook',
          "forks_url": 'https://api.github.com/repos/gemfarmer/github_webhook/forks',
          "keys_url": 'https://api.github.com/repos/gemfarmer/github_webhook/keys{/key_id}',
          "collaborators_url": 'https://api.github.com/repos/gemfarmer/github_webhook/collaborators{/collaborator}',
          "teams_url": 'https://api.github.com/repos/gemfarmer/github_webhook/teams',
          "hooks_url": 'https://api.github.com/repos/gemfarmer/github_webhook/hooks',
          "issue_events_url": 'https://api.github.com/repos/gemfarmer/github_webhook/issues/events{/number}',
          "events_url": 'https://api.github.com/repos/gemfarmer/github_webhook/events',
          "assignees_url": 'https://api.github.com/repos/gemfarmer/github_webhook/assignees{/user}',
          "branches_url": 'https://api.github.com/repos/gemfarmer/github_webhook/branches{/branch}',
          "tags_url": 'https://api.github.com/repos/gemfarmer/github_webhook/tags',
          "blobs_url": 'https://api.github.com/repos/gemfarmer/github_webhook/git/blobs{/sha}',
          "git_tags_url": 'https://api.github.com/repos/gemfarmer/github_webhook/git/tags{/sha}',
          "git_refs_url": 'https://api.github.com/repos/gemfarmer/github_webhook/git/refs{/sha}',
          "trees_url": 'https://api.github.com/repos/gemfarmer/github_webhook/git/trees{/sha}',
          "statuses_url": 'https://api.github.com/repos/gemfarmer/github_webhook/statuses/{sha}',
          "languages_url": 'https://api.github.com/repos/gemfarmer/github_webhook/languages',
          "stargazers_url": 'https://api.github.com/repos/gemfarmer/github_webhook/stargazers',
          "contributors_url": 'https://api.github.com/repos/gemfarmer/github_webhook/contributors',
          "subscribers_url": 'https://api.github.com/repos/gemfarmer/github_webhook/subscribers',
          "subscription_url": 'https://api.github.com/repos/gemfarmer/github_webhook/subscription',
          "commits_url": 'https://api.github.com/repos/gemfarmer/github_webhook/commits{/sha}',
          "git_commits_url": 'https://api.github.com/repos/gemfarmer/github_webhook/git/commits{/sha}',
          "comments_url": 'https://api.github.com/repos/gemfarmer/github_webhook/comments{/number}',
          "issue_comment_url": 'https://api.github.com/repos/gemfarmer/github_webhook/issues/comments{/number}',
          "contents_url": 'https://api.github.com/repos/gemfarmer/github_webhook/contents/{+path}',
          "compare_url": 'https://api.github.com/repos/gemfarmer/github_webhook/compare/{base}...{head}',
          "merges_url": 'https://api.github.com/repos/gemfarmer/github_webhook/merges',
          "archive_url": 'https://api.github.com/repos/gemfarmer/github_webhook/{archive_format}{/ref}',
          "downloads_url": 'https://api.github.com/repos/gemfarmer/github_webhook/downloads',
          "issues_url": 'https://api.github.com/repos/gemfarmer/github_webhook/issues{/number}',
          "pulls_url": 'https://api.github.com/repos/gemfarmer/github_webhook/pulls{/number}',
          "milestones_url": 'https://api.github.com/repos/gemfarmer/github_webhook/milestones{/number}',
          "notifications_url": 'https://api.github.com/repos/gemfarmer/github_webhook/notifications{?since,all,participating}',
          "labels_url": 'https://api.github.com/repos/gemfarmer/github_webhook/labels{/name}',
          "releases_url": 'https://api.github.com/repos/gemfarmer/github_webhook/releases{/id}',
          "deployments_url": 'https://api.github.com/repos/gemfarmer/github_webhook/deployments',
          "created_at": '2016-10-17T19:41:56Z',
          "updated_at": '2016-10-17T19:41:56Z',
          "pushed_at": '2016-12-08T19:40:12Z',
          "git_url": 'git://github.com/gemfarmer/github_webhook.git',
          "ssh_url": 'git@github.com:gemfarmer/github_webhook.git',
          "clone_url": 'https://github.com/gemfarmer/github_webhook.git',
          "svn_url": 'https://github.com/gemfarmer/github_webhook',
          "homepage": nil,
          "size": 64,
          "stargazers_count": 0,
          "watchers_count": 0,
          "language": nil,
          "has_issues": true,
          "has_downloads": true,
          "has_wiki": true,
          "has_pages": false,
          "forks_count": 0,
          "mirror_url": nil,
          "open_issues_count": 19,
          "forks": 0,
          "open_issues": 19,
          "watchers": 0,
          "default_branch": 'master'
        },
        "sender": {
          "login": 'gemfarmer',
          "id": 4_803_473,
          "avatar_url": 'https://avatars.githubusercontent.com/u/4803473?v=3',
          "gravatar_id": '',
          "url": 'https://api.github.com/users/gemfarmer',
          "html_url": 'https://github.com/gemfarmer',
          "followers_url": 'https://api.github.com/users/gemfarmer/followers',
          "following_url": 'https://api.github.com/users/gemfarmer/following{/other_user}',
          "gists_url": 'https://api.github.com/users/gemfarmer/gists{/gist_id}',
          "starred_url": 'https://api.github.com/users/gemfarmer/starred{/owner}{/repo}',
          "subscriptions_url": 'https://api.github.com/users/gemfarmer/subscriptions',
          "organizations_url": 'https://api.github.com/users/gemfarmer/orgs',
          "repos_url": 'https://api.github.com/users/gemfarmer/repos',
          "events_url": 'https://api.github.com/users/gemfarmer/events{/privacy}',
          "received_events_url": 'https://api.github.com/users/gemfarmer/received_events',
          "type": 'User',
          "site_admin": false
        }
      }

      files_changed = [{ sha: '441daba07da0dbef4522dd0363298806039a1a07',
                         filename: 'jp.md',
                         status: 'modified',
                         additions: 3,
                         deletions: 0,
                         changes: 3,
                         blob_url:         'https://github.com/gemfarmer/github_webhook/blob/90e60db2cde7a69b96e7fe7fa88217616b68c474/jp.md',
                         raw_url:         'https://github.com/gemfarmer/github_webhook/raw/90e60db2cde7a69b96e7fe7fa88217616b68c474/jp.md',
                         contents_url:         'https://api.github.com/repos/gemfarmer/github_webhook/contents/jp.md?ref=90e60db2cde7a69b96e7fe7fa88217616b68c474',
                         patch:         "@@ -4,3 +4,6 @@\n 18Fers combating hunger in crazy ways\n 18Fers combating hunger in many crazy ways\n 18Fers combating hunger in crazy ways\n+18Fers combating hunger in crazy ways\n+18Fers combating hunger in many crazy ways\n+18Fers combating hunger in crazy ways" }]

      subject.request.headers['X-Hub-Signature'] = 'sha1=6d8791a385f55e1fcd3d469e9ec751601401374f'
      subject.request.headers['Content-Type'] = 'application/json'
      subject.request.headers['X-GitHub-Event'] = 'pull_request'

      pull_request_files = instance_double(PullRequestFiles)
      expect(PullRequestFiles).to receive(:new).
        with('gemfarmer/github_webhook', '90e60db2cde7a69b96e7fe7fa88217616b68c474').
        and_return(pull_request_files)
      expect(pull_request_files).to receive(:changed_files).and_return(files_changed)

      # expect(GithubFileContents).to receive(:new).with('gemfarmer/github_webhook', )



      file = "#{Rails.root}/spec/support/jp.md"

      contents_response = {
        name: 'jp.md',
        path: 'jp.md',
        sha: 'b2ac6162d16f4c66edaa08493c2a0b29451b4d4b',
        size: 286,
        url:       'https://api.github.com/repos/gemfarmer/github_webhook/contents/jp.md?ref=90e60db2cde7a69b96e7fe7fa88217616b68c474',
        html_url:       'https://github.com/gemfarmer/github_webhook/blob/90e60db2cde7a69b96e7fe7fa88217616b68c474/jp.md',
        git_url:       'https://api.github.com/repos/gemfarmer/github_webhook/git/blobs/b2ac6162d16f4c66edaa08493c2a0b29451b4d4b',
        download_url:       'https://raw.githubusercontent.com/gemfarmer/github_webhook/90e60db2cde7a69b96e7fe7fa88217616b68c474/second.md',
        type: 'file',
        content: Base64.encode64(File.read(file)),
        encoding: 'base64',
        _links: {
          self:         'https://api.github.com/repos/gemfarmer/github_webhook/contents/jp.md?ref=90e60db2cde7a69b96e7fe7fa88217616b68c474',
          git:         'https://api.github.com/repos/gemfarmer/github_webhook/git/blobs/b2ac6162d16f4c66edaa08493c2a0b29451b4d4b',
          html:         'https://github.com/gemfarmer/github_webhook/blob/90e60db2cde7a69b96e7fe7fa88217616b68c474/jp.md'
        }
      }

      response_body = double('Sawyer::Resource', contents_response)

      allow(Octokit).to receive(:contents).with('gemfarmer/github_webhook', path: 'jp.md', ref: '90e60db2cde7a69b96e7fe7fa88217616b68c474').and_return(response_body)

      # stub_request(:get, "https://api.github.com/repos/gemfarmer/github_webhook/contents/jp.md?ref=90e60db2cde7a69b96e7fe7fa88217616b68c474").
      #    with(:headers => {'Accept'=>'application/vnd.github.v3+json', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'Authorization'=>'Basic Z2VtZmFybWVyLWxpbnRlcjpUYW1tYW40NzIy', 'Content-Type'=>'application/json', 'User-Agent'=>'Octokit Ruby Gem 4.6.2'}).
      #    to_return(:status => 200, :body => contents_response.to_json, :headers => {})
      # Octokit.create_pull_request_comment(
      #    repo_name,
      #    pull_request_number,
      #    error_message,
      #    last_commit,
      #    filename,
      #    line
      #  )

      3.times do |line_num|
        expect(Octokit).to receive(:create_pull_request_comment).with(
          'gemfarmer/github_webhook',
          19,
          'Consider replacing `crazy` with `chaotic`, `unusual`, `complex`, or `incredible`.',
          '90e60db2cde7a69b96e7fe7fa88217616b68c474',
          'jp.md',
          line_num + 1
        )
      end

      3.times do |line_num|
        expect(Octokit).to receive(:create_pull_request_comment).with(
          'gemfarmer/github_webhook',
          19,
          'Consider replacing `dropdown` with `drop-down menu` or `drop down`.',
          '90e60db2cde7a69b96e7fe7fa88217616b68c474',
          'jp.md',
          line_num + 1
        )
      end

      post :create, body
    end
  end
end

# rubocop:enable LineLength
