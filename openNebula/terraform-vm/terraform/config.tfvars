# NEVER COMMIT THIS FILE with actual credentials!

EXPERIMENT_NAME = "hll3"
ON_USERNAME     = "chacko"                  # THIS IS YOUR RBG USERNAME (THE SAME YOU LOGIN WITH ON THE WEB)
ON_PASSWD       = ""                  # THIS IS YOUR PASSWORD FOR THAT USER
ON_GROUP        = "chacko-research"                  # This is the group your advisor assigned you to. See the OpenNebula GUI, top right when clicking on your username.
ON_VM_COUNT     = 3                   # Number of VMs to spawn on OpenNebula. Be mindful with our resources!
CPU_CORES       = 8
MEMORY          = 10240                # MB; 4GB VM + 2GB for the hypervisor guest space reservation. You VM will have 4 GB of memory.
DISK_SIZE       = 30720               # MB; Never use a larger size. See: https://wiki.tum.de/pages/viewpage.action?pageId=1310363151
