# hello-world-pipeline

This [Nextflow](https://www.nextflow.io/docs/latest/getstarted.html) pipeline was created using [Code Ocean](https://codeocean.com).
The Code Ocean pipeline definition is synced to this [hello-world-pipeline](https://github.com/benjamin-heasly/hello-world-pipeline) GitHub repo.

The instructions here should allow you to run the Code Ocean pipeline locally, using the same Nextflow pipeline definition and Capsule / [Docker image](https://en.wikipedia.org/wiki/Docker_(software)#Components) definitions.


# The pipeline

This pipeline uses two steps, what Code Ocean calls "capsules".

 - `hello-world-writer` writes a "hello_world" message to a text file in its `/results` directory.
 - `hello-world-reader` reads the same text file from its `/data` directory and prints the file contents.

This is a complicated way just to print "hello_world" to the console.
It's intended as a test and demo for executing a Code Ocean pipeline locally.


# You'll need

- This [hello-world-pipeline](https://github.com/benjamin-heasly/hello-world-pipeline) repo
- [Nextflow](https://www.nextflow.io/docs/latest/getstarted.html)
- [Docker Community Edition (CE)](https://www.docker.com/community-edition)
- Code Ocean [API access token](https://github.com/codeocean/coding_workshop?tab=readme-ov-file#creating-an-api-access-token) with Capsules/read permission


# Code Ocean registry and repo access

To run this locally you need to authenticate with the Code Ocean container registry and Git code repos.
These are the "source of truth" for the pipeline and its capsules (capsules combine Docker containers with versioned code).

To log in to the Code Ocean container registry:

```
docker login registry.codeocean.allenneuraldynamics.org
# Enter your Code Ocean user name
# Paste in your Code Ocean API access token
```

To set up access to the Code Ocean Git repos:

```
export CO_USERNAME="<your Code Ocean user name>"
read -s -p "Enter Code Ocean password or API key: " CO_PASSWORD && echo && export CO_PASSWORD
# Paste in your Code Ocean API access token
```

**NOTE:** You must [url encode](https://www.w3schools.com/tags/ref_urlencode.ASP) your Code Ocean user name.  This is because the pipeline attempts to include your user name within the urls of the capsule code repos.  For example, if your Code Ocean user name were `my.name@website.com` then you could use:

```
export CO_USERNAME="my.name%40website.com"
```


## Run

Move to the `pipeline` subdir within this repo.

```
cd pipeline
```

Run the pipeline!

```
NXF_VER=24.10.4 DATA_PATH=$PWD/../data nextflow -log ../results/nextflow/nextflow.log -c local.config run main.nf
```

The output from a successful run might look like this:

```
 N E X T F L O W   ~  version 24.10.4

Launching `main.nf` [gigantic_mestorf] DSL2 - revision: cd233a7ccc

executor >  local (2)
[ee/688f01] process > capsule_hello_world_writer_1 (capsule-5967917) [100%] 1 of 1 ✔
[5d/214ba3] process > capsule_hello_world_reader_2 (capsule-3944950) [100%] 1 of 1 ✔
[capsule-5967917] cloning git repo...
[capsule-5967917] running capsule...
My message is:
hello_world
[capsule-5967917] completed!

[capsule-3944950] cloning git repo...
[capsule-3944950] running capsule...
I read a message: hello_world
[capsule-3944950] completed!
```

In addition, Nextflow generates nice reports and images in the `../results` directory.
Here are some examples from a previous pipeline run:

 - [dag.html](./docs/dag.html)
 - [report.html](./docs/report.html)
 - [timeline.html](./docs/timeline.html)
