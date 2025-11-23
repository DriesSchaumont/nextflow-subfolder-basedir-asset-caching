#!/usb/bin/env nextflow
nextflow.enable.dsl=2

process test_project {
    tag "${name}"
    debug true
    cpus 1
    memory 500.MB
    container "ubuntu:latest"
    input:
        val(name)
        path(asset_dir, stageAs: "test_assets")
    output:
        path("${name}.txt")
    """
    sha1sum ${asset_dir}/template.txt
    cat ${asset_dir}/template.txt > ${name}.txt
    echo ${name} >> ${name}.txt
    """
}

workflow {
    names = Channel.from(['foo', 'bar'])
    asset_dir = file("${projectDir}/../assets")
    test_project(names, asset_dir)
}