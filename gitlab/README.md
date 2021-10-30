# Pre-setup

If you wish to create data volume and manage externally:

`docker volume create gitlab_data`
`docker volume create gitlab_logs`
`docker volume create gitlab_config`
`docker volume create gitlab_runner_config`

# Startup

Run `docker-compose up -d`

# Remove

Run `docker-compose down [-v]`

`-v` will enable automatic removal of docker volume(s) attached to the container

# Post-setup

## Default login

Once `gitlab` has been initialized, navigate to `http://localhost:5580` and login using `root`. As for the `password, run the following command

```bash
sudo docker exec -it gitlab-ee /bin/bash
grep 'Password:' /etc/gitlab/initial_root_password
```

This would print out the default password to use for the initial login

## Register gitlab-runner onto gitlab

Once login, navigate to the default `Monitoring` project > settings > CI/CD > Runners. Expand the `Runners` and take note of the `registration token` which we need it to register the `gitlab-runner` to this `gitlab` instance

Run the following command to register

```bash
docker exec -it gitlabee-runner bin/bash
# url is based on the container name
gitlab-runner register --non-interactive --url "http://gitlab-ee" --registration-token D2Nty7KU9iXDoRXVZewT --executor "docker" --docker-image alphine:latest --description "do-runner" --tag-list "docker" --run-untagged="true" --lo
cked="false" --access-level="not_protected"
```

# References

https://docs.gitlab.com/ee/install/docker.html
https://docs.gitlab.com/runner/register/index.html#docker
https://www.jamescoyle.net/how-to/docker-compose-files/3179-docker-compose-yml-for-gitlab-and-gitlab-runner