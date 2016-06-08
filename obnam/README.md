# Obnam docker image

This docker image contains the backup tool *Obnam* v1.91.1.

You can find it here:

* GitHub: [maxhq/dockerfiles](https://github.com/maxhq/dockerfiles/tree/master/obnam)
* Docker Hub: [maxhq/obnam](https://registry.hub.docker.com/u/maxhq/obnam/)

It is a modification of [vdemeester/obnam](https://registry.hub.docker.com/u/vdemeester/obnam/) with less magic, an option to set custom arguments and a bit more docs).

## Default usage

By default, the image will run `obnam` binary and backup */source* to */dest* (directories inside Docker container):

```bash
$ docker run --rm \
  -v <SOURCE>:/source:ro \
  -v <DEST>:/dest \
  maxhq/obnam
```

... executes the following command inside the Docker container:

```bash
$ obnam backup /source /dest
# Effectively this means:
# obnam backup <SOURCE> <DEST>
```

You have to replace `<SOURCE>` and `<DEST>` with your real host directories!

## Customization

If any arguments are given to the Docker container, those are passed on to `obnam` 1:1 and no magic takes place:

### Example 1: version

```bash
$ docker run maxhq/obnam --version
1.19.1
```

### Example 2: list keys

```bash
$ docker run --rm \
  -v <DEST>:/dest \
  maxhq/obnam list-keys -r /dest
```

... executes the following command inside the Docker container:

```bash
$ obnam list-keys -r /dest
# Effectively this means:
# obnam list-keys -r <DEST>
```

# Usage

## Configuration file

Example: you created an Obnam config file on your Docker host at **/home/tux/myobnam.cfg**. Obnam (in the container) searches several places for config files, firstly */etc/obnam.conf*. So the easiest way to pass your config is:

```bash
$ docker run --rm \
  -v /home/tux/myobnam.cfg:/etc/obnam.conf:ro \
  ...
```

## Local destination

Your Host filesystem:

* Source: **/home/tux/Documents**
* Target: **/mnt/mycloud**

You have to tell Docker to mount these source and destination host directories to */source* and */dest* respectively inside the Docker container. Let's mount the source as read-only to be sure it does not get messed up.

```bash
$ docker run --rm \
  -v /home/tux/Documents:/source:ro \
  -v /mnt/mycloud:/dest \
  maxhq/obnam
```

## Remote (SFTP) destination

To backup to an `sftp` target, we will need to customize the `obnam` call, preventing all magic and mount:

* **~/Documents** to */source*
* **~/.ssh/** to */root/.ssh/* (to be able to use ssh keys)

```bash
$ docker run --rm --ti \
  -v ~/Documents:/source:ro \
  -v ~/.ssh/:/root/.ssh/:ro \
  maxhq/obnam backup -r sftp://backup.host/backup/destination /source
```

## Encryption using GnuPG

To use GPG keys for encryption, they have to made available to the Docker container.

Let's say you set up this **~/myobnam.conf** on your host:

```bash
[config]
repository = /dest
client-name = sigurd
one-file-system = 1
encrypt-with = ABCD1234
exclude = \.HIDDEN
lru-size = 1024
upload-queue-size = 512
```

Now just mount:

* **~/myobnam.conf** to */etc/obnam.conf*
* **~/.gnupg** to */root/.gnupg*

like this:

```bash
$ docker run --rm -ti \
  -v /home/tux/Documents:/source:ro \
  -v ~/myobnam.conf:/etc/obnam.conf:ro \
  -v ~/.gnupg:/root/.gnupg:ro \
  maxhq/obnam backup -r sftp://backup.host/backup/destination /source
```
