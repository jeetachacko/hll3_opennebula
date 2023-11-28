     #!/bin/bash

# !TODO! Update hardcoded values

# - TPS: 50, 100, 300, 500, 1000 MMC 50
# - TPS: 50, 100, 300, 500, 1000 MMC 100
# - TPS: 50, 100, 300, 500, 1000 MMC 300
# - TPS: 50, 100, 300, 500, 1000 MMC 500
# - TPS: 50, 100, 300, 500, 1000 MMC 1000

# - TPS: 50, 100, 300, 500, 1000 MMC 500 BT 0,5
# - TPS: 50, 100, 300, 500, 1000 MMC 500 BT 1
# - TPS: 50, 100, 300, 500, 1000 MMC 500 BT 2

# - TPS: 50, 100, 300, 500, 1000 MMC 500 BT 2 PMB 1
# - TPS: 50, 100, 300, 500, 1000 MMC 500 BT 2 PMB 2
# - TPS: 50, 100, 300, 500, 1000 MMC 500 BT 2 PMB 4

# - TPS: 50, 100, 300, 500, 1000 MMC 500 BT 2 PMB 2 SIS 16
# - TPS: 50, 100, 300, 500, 1000 MMC 500 BT 2 PMB 2 SIS 32
# - TPS: 50, 100, 300, 500, 1000 MMC 500 BT 2 PMB 2 SIS 64

# - TPS: 50, 100, 300, 500, 1000 TXSIZE +1 byte MMC 500 BT 2 PMB 1
# - TPS: 50, 100, 300, 500, 1000 TXSIZE +1 byte MMC 500 BT 2 PMB 2
# - TPS: 50, 100, 300, 500, 1000 TXSIZE +1 byte MMC 500 BT 2 PMB 4

# - TPS: 50, 100, 300, 500, 1000 TXSIZE +1 byte MMC 500 BT 2 PMB 2 SIS 16
# - TPS: 50, 100, 300, 500, 1000 TXSIZE +1 byte MMC 500 BT 2 PMB 2 SIS 32
# - TPS: 50, 100, 300, 500, 1000 TXSIZE +1 byte MMC 500 BT 2 PMB 2 SIS 64

tps=(300 500 1000)
mmc=(300 500 1000) 
bt=(0.5 1 2)
pmb=(1 2 4)
sis=(16 32 64)

sed -i "26s/.*/fabric_batchsize: [\"500\", \"98 MB\", \"2 MB\"]/" /home/ubuntu/hll3_opennebula/fabric/network-configuration.yaml
sed -i "24s/.*/fabric_batch_timeout: \"2s\"/" /home/ubuntu/hll3_opennebula/fabric/network-configuration.yaml
sed -i "235s/.*/      SnapshotIntervalSize: 16 MB/" /home/ubuntu/hll3_opennebula/fabric/config-template/templates/configtx.yaml

rm /home/ubuntu/hll3_opennebula/caliper/caliper-logs.txt
printf "tps, tpsValue, ConfigVar, ConfigVarValue, Succ, Fail, SendRate, Latency, Throughput" >> /home/ubuntu/hll3_opennebula/caliper/caliper-logs.csv
printf "\n" >> /home/ubuntu/hll3_opennebula/caliper/caliper-logs.csv

for j in "${tps[@]}"
do
     sed -i "21s/.*/            tps: ${j}/" /home/ubuntu/hll3_opennebula/caliper/benchmarks/generator/config.yaml

     for i in "${mmc[@]}"
     do
          sed -i "26s/.*/fabric_batchsize: [\"${i}\", \"98 MB\", \"2 MB\"]/" /home/ubuntu/hll3_opennebula/fabric/network-configuration.yaml
          ./scripts/network_run.sh
          sleep 10s
          ./scripts/caliper_run.sh generator 
          ./scripts/network_delete.sh
          ./scripts/caliper_delete.sh
          sleep 30s
          #COPY RESULTS - XLX
          printf "tps, ${j}, mmc, ${i}," >> /home/ubuntu/hll3_opennebula/caliper/caliper-logs.csv
          printf "%.2f," $(grep '| common' /home/ubuntu/hll3_opennebula/caliper/caliper-logs.txt  | awk '{print $4,$6,$8,$14,$16}' | tail -n 1) >> /home/ubuntu/hll3_opennebula/caliper/caliper-logs.csv
          printf "\n" >> /home/ubuntu/hll3_opennebula/caliper/caliper-logs.csv
          rm /home/ubuntu/hll3_opennebula/caliper/caliper-logs.txt

     done
done

sed -i "26s/.*/fabric_batchsize: [\"500\", \"98 MB\", \"2 MB\"]/" /home/ubuntu/hll3_opennebula/fabric/network-configuration.yaml
sed -i "24s/.*/fabric_batch_timeout: \"2s\"/" /home/ubuntu/hll3_opennebula/fabric/network-configuration.yaml
sed -i "235s/.*/      SnapshotIntervalSize: 16 MB/" /home/ubuntu/hll3_opennebula/fabric/config-template/templates/configtx.yaml

for j in "${tps[@]}"
do
     sed -i "21s/.*/            tps: ${j}/" /home/ubuntu/hll3_opennebula/caliper/benchmarks/generator/config.yaml

     for i in "${bt[@]}"
     do
          sed -i "24s/.*/fabric_batch_timeout: \"${i}s\"/" /home/ubuntu/hll3_opennebula/fabric/network-configuration.yaml
          ./scripts/network_run.sh
          sleep 10s
          ./scripts/caliper_run.sh generator 
          ./scripts/network_delete.sh
          ./scripts/caliper_delete.sh
          sleep 30s
          #COPY RESULTS - XLX
          printf "tps, ${j}, bt, ${i}," >> /home/ubuntu/hll3_opennebula/caliper/caliper-logs.csv
          printf "%.2f," $(grep '| common' /home/ubuntu/hll3_opennebula/caliper/caliper-logs.txt  | awk '{print $4,$6,$8,$14,$16}' | tail -n 1) >> /home/ubuntu/hll3_opennebula/caliper/caliper-logs.csv
          printf "\n" >> /home/ubuntu/hll3_opennebula/caliper/caliper-logs.csv
          rm /home/ubuntu/hll3_opennebula/caliper/caliper-logs.txt

     done
done

sed -i "26s/.*/fabric_batchsize: [\"500\", \"98 MB\", \"2 MB\"]/" /home/ubuntu/hll3_opennebula/fabric/network-configuration.yaml
sed -i "24s/.*/fabric_batch_timeout: \"2s\"/" /home/ubuntu/hll3_opennebula/fabric/network-configuration.yaml
sed -i "235s/.*/      SnapshotIntervalSize: 16 MB/" /home/ubuntu/hll3_opennebula/fabric/config-template/templates/configtx.yaml

for j in "${tps[@]}"
do
     sed -i "21s/.*/            tps: ${j}/" /home/ubuntu/hll3_opennebula/caliper/benchmarks/generator/config.yaml
     for i in "${pmb[@]}"
     do
          sed -i "26s/.*/fabric_batchsize: [\"500\", \"98 MB\", \"${i} MB\"]/" /home/ubuntu/hll3_opennebula/fabric/network-configuration.yaml
          ./scripts/network_run.sh
          sleep 10s
          ./scripts/caliper_run.sh generator 
          ./scripts/network_delete.sh
          ./scripts/caliper_delete.sh
          sleep 30s
          #COPY RESULTS - XLX
          printf "tps, ${j}, pmb, ${i}," >> /home/ubuntu/hll3_opennebula/caliper/caliper-logs.csv
          printf "%.2f," $(grep '| common' /home/ubuntu/hll3_opennebula/caliper/caliper-logs.txt  | awk '{print $4,$6,$8,$14,$16}' | tail -n 1) >> /home/ubuntu/hll3_opennebula/caliper/caliper-logs.csv
          printf "\n" >> /home/ubuntu/hll3_opennebula/caliper/caliper-logs.csv
          rm /home/ubuntu/hll3_opennebula/caliper/caliper-logs.txt

     done
done

sed -i "26s/.*/fabric_batchsize: [\"500\", \"98 MB\", \"2 MB\"]/" /home/ubuntu/hll3_opennebula/fabric/network-configuration.yaml
sed -i "24s/.*/fabric_batch_timeout: \"2s\"/" /home/ubuntu/hll3_opennebula/fabric/network-configuration.yaml
sed -i "235s/.*/      SnapshotIntervalSize: 16 MB/" /home/ubuntu/hll3_opennebula/fabric/config-template/templates/configtx.yaml

for j in "${tps[@]}"
do
     sed -i "21s/.*/            tps: ${j}/" /home/ubuntu/hll3_opennebula/caliper/benchmarks/generator/config.yaml

     for i in "${sis[@]}"
     do
          sed -i "235s/.*/      SnapshotIntervalSize: ${i} MB/" /home/ubuntu/hll3_opennebula/fabric/config-template/templates/configtx.yaml
          ./scripts/network_run.sh
          sleep 10s
          ./scripts/caliper_run.sh generator 
          ./scripts/network_delete.sh
          ./scripts/caliper_delete.sh
          sleep 30s
          #COPY RESULTS - XLX
          printf "tps, ${j}, sis, ${i}," >> /home/ubuntu/hll3_opennebula/caliper/caliper-logs.csv
          printf "%.2f," $(grep '| common' /home/ubuntu/hll3_opennebula/caliper/caliper-logs.txt  | awk '{print $4,$6,$8,$14,$16}' | tail -n 1) >> /home/ubuntu/hll3_opennebula/caliper/caliper-logs.csv
          printf "\n" >> /home/ubuntu/hll3_opennebula/caliper/caliper-logs.csv
          rm /home/ubuntu/hll3_opennebula/caliper/caliper-logs.txt

     done
done

sed -i "26s/.*/fabric_batchsize: [\"500\", \"98 MB\", \"2 MB\"]/" /home/ubuntu/hll3_opennebula/fabric/network-configuration.yaml
sed -i "24s/.*/fabric_batch_timeout: \"2s\"/" /home/ubuntu/hll3_opennebula/fabric/network-configuration.yaml
sed -i "235s/.*/      SnapshotIntervalSize: 16 MB/" /home/ubuntu/hll3_opennebula/fabric/config-template/templates/configtx.yaml

#COMPUTE HEAVY WORKLOAD
sed -i "230s/.*/	s2 := string([]byte{2047: 0})/" /home/ubuntu/hll3_opennebula/fabric/chaincode/generator/go/generator.go
sed -i "231s/.*/	valuex = valuex + s2/" /home/ubuntu/hll3_opennebula/fabric/chaincode/generator/go/generator.go


for j in "${tps[@]}"
do
     sed -i "21s/.*/            tps: ${j}/" /home/ubuntu/hll3_opennebula/caliper/benchmarks/generator/config.yaml
     for i in "${pmb[@]}"
     do
          sed -i "26s/.*/fabric_batchsize: [\"500\", \"98 MB\", \"${i} MB\"]/" /home/ubuntu/hll3_opennebula/fabric/network-configuration.yaml
          ./scripts/network_run.sh
          sleep 10s
          ./scripts/caliper_run.sh generator 
          ./scripts/network_delete.sh
          ./scripts/caliper_delete.sh
          sleep 30s
          #COPY RESULTS - XLX
          printf "tps, ${j}, CHWorkloadpmb, ${i}," >> /home/ubuntu/hll3_opennebula/caliper/caliper-logs.csv
          printf "%.2f," $(grep '| common' /home/ubuntu/hll3_opennebula/caliper/caliper-logs.txt  | awk '{print $4,$6,$8,$14,$16}' | tail -n 1) >> /home/ubuntu/hll3_opennebula/caliper/caliper-logs.csv
          printf "\n" >> /home/ubuntu/hll3_opennebula/caliper/caliper-logs.csv
          rm /home/ubuntu/hll3_opennebula/caliper/caliper-logs.txt

     done
done

sed -i "26s/.*/fabric_batchsize: [\"500\", \"98 MB\", \"2 MB\"]/" /home/ubuntu/hll3_opennebula/fabric/network-configuration.yaml
sed -i "24s/.*/fabric_batch_timeout: \"2s\"/" /home/ubuntu/hll3_opennebula/fabric/network-configuration.yaml
sed -i "235s/.*/      SnapshotIntervalSize: 16 MB/" /home/ubuntu/hll3_opennebula/fabric/config-template/templates/configtx.yaml

for j in "${tps[@]}"
do
     sed -i "21s/.*/            tps: ${j}/" /home/ubuntu/hll3_opennebula/caliper/benchmarks/generator/config.yaml

     for i in "${sis[@]}"
     do
          sed -i "235s/.*/      SnapshotIntervalSize: ${i} MB/" /home/ubuntu/hll3_opennebula/fabric/config-template/templates/configtx.yaml
          ./scripts/network_run.sh
          sleep 10s
          ./scripts/caliper_run.sh generator 
          ./scripts/network_delete.sh
          ./scripts/caliper_delete.sh
          sleep 30s
          #COPY RESULTS - XLX
          printf "tps, ${j}, CHWorkloadsis, ${i}," >> /home/ubuntu/hll3_opennebula/caliper/caliper-logs.csv
          printf "%.2f," $(grep '| common' /home/ubuntu/hll3_opennebula/caliper/caliper-logs.txt  | awk '{print $4,$6,$8,$14,$16}' | tail -n 1) >> /home/ubuntu/hll3_opennebula/caliper/caliper-logs.csv
          printf "\n" >> /home/ubuntu/hll3_opennebula/caliper/caliper-logs.csv
          rm /home/ubuntu/hll3_opennebula/caliper/caliper-logs.txt

     done
done

sed -i "26s/.*/fabric_batchsize: [\"500\", \"98 MB\", \"2 MB\"]/" /home/ubuntu/hll3_opennebula/fabric/network-configuration.yaml
sed -i "24s/.*/fabric_batch_timeout: \"2s\"/" /home/ubuntu/hll3_opennebula/fabric/network-configuration.yaml
sed -i "235s/.*/      SnapshotIntervalSize: 16 MB/" /home/ubuntu/hll3_opennebula/fabric/config-template/templates/configtx.yaml
#DEFAULT WORKLOAD
sed -i "230s/.*/	\/\/ s2 := string([]byte{2047: 0})/" /home/ubuntu/hll3_opennebula/fabric/chaincode/generator/go/generator.go
sed -i "231s/.*/	\/\/ valuex = valuex + s2/" /home/ubuntu/hll3_opennebula/fabric/chaincode/generator/go/generator.go
