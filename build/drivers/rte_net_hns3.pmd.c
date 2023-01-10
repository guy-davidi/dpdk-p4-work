static __attribute__((unused)) const char *generator = "../buildtools/pmdinfogen.py";
const char net_hns3_pmd_info[] __attribute__((used)) = "PMD_INFO_STRING= {\"name\": \"net_hns3\", \"params\": \"rx_func_hint=vec|sve|simple|common tx_func_hint=vec|sve|simple|common dev_caps_mask=<1-65535> mbx_time_limit_ms=<uint16> \", \"kmod\": \"* igb_uio | vfio-pci\", \"pci_ids\": [[6629, 41504, 65535, 65535], [6629, 41505, 65535, 65535], [6629, 41506, 65535, 65535], [6629, 41508, 65535, 65535], [6629, 41510, 65535, 65535], [6629, 41512, 65535, 65535]]}";
const char net_hns3_vf_pmd_info[] __attribute__((used)) = "PMD_INFO_STRING= {\"name\": \"net_hns3_vf\", \"params\": \"rx_func_hint=vec|sve|simple|common tx_func_hint=vec|sve|simple|common dev_caps_mask=<1-65535> mbx_time_limit_ms=<uint16_t> \", \"kmod\": \"* igb_uio | vfio-pci\", \"pci_ids\": [[6629, 41518, 65535, 65535], [6629, 41519, 65535, 65535]]}";