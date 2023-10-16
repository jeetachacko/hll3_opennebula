	cp caliper/benchmarks/generator/common.js /home/ubuntu/hll3_opennebula/client_admtrts/common.js
	cp caliper/benchmarks/generator/config.yaml /home/ubuntu/hll3_opennebula/client_admtrts/config.yaml
	mkdir /home/ubuntu/hll3_opennebula/client_admtrts/caliper-config
	mkdir /home/ubuntu/hll3_opennebula/client_admtrts/config-template
	cp caliper/caliper-config/templates/networkConfig.yaml /home/ubuntu/hll3_opennebula/client_admtrts/caliper-config/networkConfig.yaml
	cp caliper/config-template/templates/networkConfig.yaml /home/ubuntu/hll3_opennebula/client_admtrts/config-template/networkConfig.yaml
	cp fabric/chaincode/generator/go/generator.go /home/ubuntu/hll3_opennebula/client_admtrts/generator.go
	cp fabric/channel-update/values.yaml /home/ubuntu/hll3_opennebula/client_admtrts/values.yaml
	cp fabric/config-template/templates/fabric-config.yaml /home/ubuntu/hll3_opennebula/client_admtrts/fabric-config.yaml
	cp fabric/config/templates/fabric-config.yaml /home/ubuntu/hll3_opennebula/client_admtrts/fabric-config.yaml 
	cp fabric/config/templates/hostAliases.yaml /home/ubuntu/hll3_opennebula/client_admtrts/hostAliases.yaml
	cp fabric/hlf-kube/fabric-config.yaml /home/ubuntu/hll3_opennebula/client_admtrts/fabric-config.yaml
	cp fabric/hlf-kube/pv-templates/peer-statefulset_nfs.yaml /home/ubuntu/hll3_opennebula/client_admtrts/peer-statefulset_nfs.yaml
	cp fabric/hlf-kube/templates/peer-statefulset.yaml /home/ubuntu/hll3_opennebula/client_admtrts/peer-statefulset.yaml
	cp openNebula/terraform-vm/terraform/config.tfvars /home/ubuntu/hll3_opennebula/client_admtrts/config.tfvars
	cp openNebula/terraform-vm/terraform/virtual-machines.tf /home/ubuntu/hll3_opennebula/client_admtrts/virtual-machines.tf
	cp scripts/caliper_delete.sh /home/ubuntu/hll3_opennebula/client_admtrts/caliper_delete.sh
	cp scripts/caliper_run.sh /home/ubuntu/hll3_opennebula/client_admtrts/caliper_run.sh
	cp scripts/configfile_gen.sh /home/ubuntu/hll3_opennebula/client_admtrts/configfile_gen.sh
	cp scripts/k8s_opennebula.sh /home/ubuntu/hll3_opennebula/client_admtrts/k8s_opennebula.sh
	cp scripts/k8s_opennebula_kubectl.sh /home/ubuntu/hll3_opennebula/client_admtrts/k8s_opennebula_kubectl.sh
	cp scripts/monitor.sh /home/ubuntu/hll3_opennebula/client_admtrts/monitor.sh
	cp scripts/network_delete.sh /home/ubuntu/hll3_opennebula/client_admtrts/network_delete.sh
	cp scripts/scf_kill.sh /home/ubuntu/hll3_opennebula/client_admtrts/scf_kill.sh
	cp scripts/scf_run.sh /home/ubuntu/hll3_opennebula/client_admtrts/scf_run.sh 

	cp caliper/benchmarks/generator/common_original_simplegen.js /home/ubuntu/hll3_opennebula/client_admtrts/common_original_simplegen.js
	cp caliper/benchmarks/generator/getValues.js /home/ubuntu/hll3_opennebula/client_admtrts/getValues.js
	cp caliper/benchmarks/generator/getValues_default.js /home/ubuntu/hll3_opennebula/client_admtrts/getValues_default.js
	cp caliper/benchmarks/generator/ratecontroller.js /home/ubuntu/hll3_opennebula/client_admtrts/ratecontroller.js
	mkdir /home/ubuntu/hll3_opennebula/client_admtrts/readBlockchain
	cp -r caliper/readBlockchain/* /home/ubuntu/hll3_opennebula/client_admtrts/readBlockchain/
	cp caliper/values.yaml /home/ubuntu/hll3_opennebula/client_admtrts/values.yaml
	cp caliper/workerlog.txt /home/ubuntu/hll3_opennebula/client_admtrts/workerlog.txt 
	mkdir /home/ubuntu/hll3_opennebula/client_admtrts/channel-read
	cp -r fabric/channel-read/* /home/ubuntu/hll3_opennebula/client_admtrts/channel-read/
	cp network-delay.yaml /home/ubuntu/hll3_opennebula/client_admtrts/network-delay.yaml
	cp parser.txt /home/ubuntu/hll3_opennebula/client_admtrts/parser.txt
	cp scripts/caliper_rerun.sh /home/ubuntu/hll3_opennebula/client_admtrts/caliper_rerun.sh
	cp scripts/configmap_update.sh /home/ubuntu/hll3_opennebula/client_admtrts/configmap_update.sh
	cp scripts/network_read.sh /home/ubuntu/hll3_opennebula/client_admtrts/network_read.sh
	cp test.sh /home/ubuntu/hll3_opennebula/client_admtrts/test.sh