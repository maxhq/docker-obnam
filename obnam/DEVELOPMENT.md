# Workflow

* Check for new Obnam version:
  * http://git.liw.fi/cgi-bin/cgit/cgit.cgi/obnam/tree/NEWS
  * https://packages.debian.org/source/sid/obnam
* Docker:
  * edit Dockerfile on workstation
  * build Docker image:
    * `docker build -t maxhq/obnam .`
  * test Docker image:
    * `docker run --rm -ti maxhq/obnam --version`
    * `docker run --rm -ti --entrypoint /bin/bash maxhq/obnam`
* Commit and push to GitHub:
  * `git commit -a`
  * `git push`
  * `git tag 1.19.1`
  * `git push --tags`

