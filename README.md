# nextflow-subfolder-basedir-asset-caching

This repository provides a small example of asset (repository) directories not being correctly cached by nextflow when the `main.nf` script is part of a subfolder.

## Example of incorrect caching

### Cleaning the repository

```
nextflow drop DriesSchaumont/nextflow-subfolder-basedir-asset-caching > /dev/null; rm -rf .nextflow && rm -f .nextflow.log* && rm -rf work
```

### Running the workflow once

```
NXF_VER=25.10.0 NXF_TRACE=nextflow.util NXF_PATCH_DIRECTORY_HASH=true nextflow run DriesSchaumont/nextflow-subfolder-basedir-asset-caching -main-script pipeline/main.nf
```
```
 N E X T F L O W   ~  version 25.10.0

Pulling DriesSchaumont/nextflow-subfolder-basedir-asset-caching ...
 downloaded from https://github.com/DriesSchaumont/nextflow-subfolder-basedir-asset-caching.git
Launching `https://github.com/DriesSchaumont/nextflow-subfolder-basedir-asset-caching` [cheesy_marconi] DSL2 - revision: 0e8fe835b6 [main]

executor >  local (2)
[a8/abdb0b] test_project (foo) [100%] 2 of 2 ✔
8fbf7ab58288ceb1da97c4b561e59c87e111ccf6  test_assets/template.txt

8fbf7ab58288ceb1da97c4b561e59c87e111ccf6  test_assets/template.txt
```

### Testing resume (not dropping repository)

```
NXF_VER=25.10.0 NXF_TRACE=nextflow.util NXF_PATCH_DIRECTORY_HASH=true nextflow run DriesSchaumont/nextflow-subfolder-basedir-asset-caching -main-script pipeline/main.nf -resume
```

```
 N E X T F L O W   ~  version 25.10.0

Launching `https://github.com/DriesSchaumont/nextflow-subfolder-basedir-asset-caching` [backstabbing_franklin] DSL2 - revision: 0e8fe835b6 [main]

[64/b7bb09] test_project (bar) [100%] 2 of 2, cached: 2 ✔
8fbf7ab58288ceb1da97c4b561e59c87e111ccf6  test_assets/template.txt

8fbf7ab58288ceb1da97c4b561e59c87e111ccf6  test_assets/template.txt
```

### Dropping the repository
```
nextflow drop DriesSchaumont/nextflow-subfolder-basedir-asset-caching
```

### Failing resume

```
NXF_VER=25.10.0 NXF_TRACE=nextflow.util NXF_PATCH_DIRECTORY_HASH=true nextflow run DriesSchaumont/nextflow-subfolder-basedir-asset-caching -main-script pipeline/main.nf -resume
```
```

 N E X T F L O W   ~  version 25.10.0

Pulling DriesSchaumont/nextflow-subfolder-basedir-asset-caching ...
 downloaded from https://github.com/DriesSchaumont/nextflow-subfolder-basedir-asset-caching.git
Launching `https://github.com/DriesSchaumont/nextflow-subfolder-basedir-asset-caching` [gloomy_boyd] DSL2 - revision: 0e8fe835b6 [main]

executor >  local (2)
[80/b8c723] test_project (foo) [100%] 2 of 2 ✔
8fbf7ab58288ceb1da97c4b561e59c87e111ccf6  test_assets/template.txt

8fbf7ab58288ceb1da97c4b561e59c87e111ccf6  test_assets/template.txt

```
