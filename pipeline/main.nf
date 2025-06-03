#!/usr/bin/env nextflow
// hash:sha256:5d85556731631776e562bdca5a35fe181efd06cf31b97f386d6aedc944be5f99

// capsule - hello-world-writer
process capsule_hello_world_writer_1 {
	tag 'capsule-5967917'
	container "$REGISTRY_HOST/capsule/f1231091-26d3-4864-acd1-cd007f24716d:03b4594cbdbb343da41228442e45d7eb"

	cpus 1
	memory '7.5 GB'

	output:
	path 'capsule/results/*', emit: to_capsule_hello_world_reader_2_1

	script:
	"""
	#!/usr/bin/env bash
	set -e

	export CO_CAPSULE_ID=f1231091-26d3-4864-acd1-cd007f24716d
	export CO_CPUS=1
	export CO_MEMORY=8053063680

	mkdir -p capsule
	mkdir -p capsule/data && ln -s \$PWD/capsule/data /data
	mkdir -p capsule/results && ln -s \$PWD/capsule/results /results
	mkdir -p capsule/scratch && ln -s \$PWD/capsule/scratch /scratch

	echo "[${task.tag}] cloning git repo..."
	if [[ "\$(printf '%s\n' "2.20.0" "\$(git version | awk '{print \$3}')" | sort -V | head -n1)" = "2.20.0" ]]; then
		git clone --filter=tree:0 "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-5967917.git" capsule-repo
	else
		git clone "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-5967917.git" capsule-repo
	fi
	git -C capsule-repo checkout 8fdf02dd5dadd4d84f146695dd199da4240563b5 --quiet
	mv capsule-repo/code capsule/code
	rm -rf capsule-repo

	echo "[${task.tag}] running capsule..."
	cd capsule/code
	chmod +x run
	./run

	echo "[${task.tag}] completed!"
	"""
}

// capsule - hello-world-reader
process capsule_hello_world_reader_2 {
	tag 'capsule-3944950'
	container "$REGISTRY_HOST/capsule/adcd9e44-4b81-4fc2-bc7b-adbc3b310c84:cbb76805f9b77fda6ae280a5bbda2296"

	cpus 1
	memory '7.5 GB'

	input:
	path 'capsule/data/'

	script:
	"""
	#!/usr/bin/env bash
	set -e

	export CO_CAPSULE_ID=adcd9e44-4b81-4fc2-bc7b-adbc3b310c84
	export CO_CPUS=1
	export CO_MEMORY=8053063680

	mkdir -p capsule
	mkdir -p capsule/data && ln -s \$PWD/capsule/data /data
	mkdir -p capsule/results && ln -s \$PWD/capsule/results /results
	mkdir -p capsule/scratch && ln -s \$PWD/capsule/scratch /scratch

	echo "[${task.tag}] cloning git repo..."
	if [[ "\$(printf '%s\n' "2.20.0" "\$(git version | awk '{print \$3}')" | sort -V | head -n1)" = "2.20.0" ]]; then
		git clone --filter=tree:0 "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-3944950.git" capsule-repo
	else
		git clone "https://\$GIT_ACCESS_TOKEN@\$GIT_HOST/capsule-3944950.git" capsule-repo
	fi
	git -C capsule-repo checkout 5e0e03421ab9d3685caac99a7eafb1e27e5fd018 --quiet
	mv capsule-repo/code capsule/code
	rm -rf capsule-repo

	echo "[${task.tag}] running capsule..."
	cd capsule/code
	chmod +x run
	./run

	echo "[${task.tag}] completed!"
	"""
}

workflow {
	// run processes
	capsule_hello_world_writer_1()
	capsule_hello_world_reader_2(capsule_hello_world_writer_1.out.to_capsule_hello_world_reader_2_1)
}
