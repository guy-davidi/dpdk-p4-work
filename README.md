# Configure DPDK Pipeline by P4
In this repo we will present how to configure DPDK pipeline by a P4 program.
# In order run l2fwd

```sudo su
cd  /home/user/dpdk-p4-work/build/examples
sudo ./dpdk-pipeline -c 0x3 -- -s /home/user/dpdk-p4-work/examples/pipeline/examples/l2fwd.cli
```

# In order to connect DPDK app cli 
```
telnet 0.0.0.0 8086
```

# Install the 

```cd /home/user/dpdk-22.07/examples/pipeline/examples
/home/user/dpdk-22.07/examples/pipeline
mkdir build
make
```

# Bind DPDK driver to device
```
cd /home/user/dpdk-22.07/usertools
sudo ./dpdk-devbind.py -b vfio-pci 0000:03:00.0
sudo ./dpdk-devbind.py -b vfio-pci 0000:07:00.0
```
 

# Compilation .P4 -> .spec by
```
cd sudo su
cd /home/user/dpdk-p4-work/build/examples
p4c-dpdk --arch psa my_l2fed.p4 -o my_l2fed.spec 
```

