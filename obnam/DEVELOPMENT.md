# Workflow

* edit Dockerfile on workstation
* build Docker image:
  * `docker build -t maxhq/obnam .`
* test Docker image:
  * `docker run -ti maxhq/obnam --version`
  * `docker run -ti --entrypoint /bin/bash maxhq/obnam`
* Commit and push to GitHub:
  * `git commit -a`
  * `git push`
  * `git tag 1.19.1`
  * `git push --tags`

