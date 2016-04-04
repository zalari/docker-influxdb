# Supported tags and respective `Dockerfile` links

-	[`0.8` (*0.8/Dockerfile*)](https://github.com/zalari/docker-influxdb/0.8/Dockerfile)

[![](https://badge.imagelayers.io/zalari/influxdb:0.8.svg)](https://imagelayers.io/?images=zalari/influxdb:0.8.svg)

# What is it?

TimeSeriesAwesomeStuff -> [InfluxDB](https://influxdata.com/)

# How to use this image

## Start a `influxdb` instance

Starting an Influxdb instance is simple:

```console
$ docker run --name some-influxdb -e INFLUXDB_DB_NAME=new-name -e INFLUXDB_DB_PASSWORD=my-secret -e INFLUXDB_DB_USER=my-user -d zalari/influxdb:tag
```

... where `some-influxdb` is the name you want to assign to your container, `new-name` is the name of a new DB to be created, `my-user` is the username for an admin user for _this_ newly created DB and `my-secret` is the password for the admin user. The default admin / password is always: root:root.

## Connect to InfluxDB from an application in another Docker container

This image exposes the standard API port (8086) and the WebUI (8083), so container linking makes the influxdb instance available to other application containers. Start your application container like this in order to link it to the InfluxDB container:

```console
$ docker run --name some-app --link some-influxdb:influxdb -d application-that-uses-influxdb
```

## Container shell access and viewing InfluxDB logs

The `docker exec` command allows you to run commands inside a Docker container. The following command line will give you a bash shell inside your `influxdb` container:

```console
    $ docker exec -it some-influxdb bash
```

The influxdb Server log is available through Docker's container log:

```console
$ docker logs some-influxdb
```

## Environment Variables

When you start the `influxdb` image, you can adjust the configuration of the influxdb instance by passing one or more environment variables on the `docker run` command line.

### `INFLUXDB_DB_NAME`

Name of a new DB to be created on startup of the container.

### `INFLUXDB_DB_USER`

Username for a admin user for the above DB.

### `INFLUXDB_DB_PASSWORD`

Password for the admin user for the above DB.

## Where to Store Data

Important note: There are several ways to store data used by applications that run in Docker containers. We encourage users of the `influxdb` images to familiarize themselves with the options available, including:

-	Let Docker manage the storage of your database data [by writing the database files to disk on the host system using its own internal volume management](https://docs.docker.com/userguide/dockervolumes/#adding-a-data-volume). This is the default and is easy and fairly transparent to the user. The downside is that the files may be hard to locate for tools and applications that run directly on the host system, i.e. outside containers.
-	Create a data directory on the host system (outside the container) and [mount this to a directory visible from inside the container](https://docs.docker.com/userguide/dockervolumes/#mount-a-host-directory-as-a-data-volume). This places the database files in a known location on the host system, and makes it easy for tools and applications on the host system to access the files. The downside is that the user needs to make sure that the directory exists, and that e.g. directory permissions and other security mechanisms on the host system are set up correctly.

The Docker documentation is a good starting point for understanding the different storage options and variations, and there are multiple blogs and forum postings that discuss and give advice in this area. We will simply show the basic procedure here for the latter option above:

1.	Create a data directory on a suitable volume on your host system, e.g. `/my/own/datadir`.
2.	Start your `influxdb` container like this:

	```console
	$ docker run --name some-influxdb -v /my/own/datadir:/opt/influxdb/shared/data -d influxdb:0.8
	```

The `-v /my/own/datadir:/opt/influxdb/shared/data` part of the command mounts the `/my/own/datadir` directory from the underlying host system as `/opt/influxdb/shared/data` inside the container, where influxdb by default will write its data files.

Note that users on host systems with SELinux enabled may see issues with this. The current workaround is to assign the relevant SELinux policy type to the new data directory so that the container will be allowed to access it:

```console
$ chcon -Rt svirt_sandbox_file_t /my/own/datadir
```

# Supported Docker versions

This image is officially supported on Docker version 1.10.3.

Support for older versions (down to 1.6) is provided on a best-effort basis.

Please see [the Docker installation documentation](https://docs.docker.com/installation/) for details on how to upgrade your Docker daemon.

# User Feedback

## Documentation

Documentation for this image is stored in the [`influxdb/` directory](https://github.com/docker-library/docs/tree/master/influxdb) of the [`docker-library/docs` GitHub repo](https://github.com/docker-library/docs). Be sure to familiarize yourself with the [repository's `README.md` file](https://github.com/docker-library/docs/blob/master/README.md) before attempting a pull request.

## Issues

If you have any problems with or questions about this image, please contact us through a [GitHub issue](https://github.com/docker-library/influxdb/issues). If the issue is related to a CVE, please check for [a `cve-tracker` issue on the `official-images` repository first](https://github.com/docker-library/official-images/issues?q=label%3Acve-tracker).

You can also reach many of the official image maintainers via the `#docker-library` IRC channel on [Freenode](https://freenode.net).

## Contributing

You are invited to contribute new features, fixes, or updates, large or small; we are always thrilled to receive pull requests, and do our best to process them as fast as we can.

Before you start to code, we recommend discussing your plans through a [GitHub issue](https://github.com/docker-library/influxdb/issues), especially for more ambitious contributions. This gives other contributors a chance to point you in the right direction, give you feedback on your design, and help you find out if someone else is working on the same thing.
