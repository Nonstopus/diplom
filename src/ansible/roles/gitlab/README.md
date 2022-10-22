#Gitlab install role

## Variables

| Variable | Value | Description |
| :--- | :--- | :--- |
| `gitlab_domain` | `gitlab.you.domain` | GitLab domain |
| `gitlab_external_url` | `https://{{ gitlab_domain }}/` | external Gitlab URL |
| `gitlab_git_data_dir` | `/var/opt/gitlab/git-data` | Data directory |
| `gitlab_edition` | `gitlab-ce` | Gitlab edition |
| `gitlab_version` |   | Gitlab version |
| `gitlab_backup_path` | `/var/opt/gitlab/backups` | Backup dir |
| `gitlab_repository_installation_script_url` |  | Installation script url |
| `gitlab_pass` | `` | Gitlab root password |
| `reg_runner_token` | `` | Gitlab runner token |
|`gitlab_dependencies` | `curl`,`tzdata`,`perl`, `gnupg2` | Gitlab dependencies |