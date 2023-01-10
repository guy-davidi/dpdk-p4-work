/* Header definitions */
header_type ethernet_t {
    fields {
        dstAddr : 48;
        srcAddr : 48;
        etherType : 16;
    }
}

header_type vlan_t {
    fields {
        vlan_id : 12;
        priority : 3;
        cfi : 1;
        vlan_type : 16;
    }
}

/* Parser definition */
parser start {
    extract(ethernet_t)
    extract(vlan_t)

    /* Parse the Ethernet header */
    ethernet_t ethernet = extract(ethernet_t);
    vlan_t vlan = extract(vlan_t);

    /* Check if the packet is an VLAN packet */
    if (vlan.vlan_type == 0x8100) {
        /* Set the VLAN ID to the metadata */
        meta.vlan_id = vlan.vlan_id;

        /* Remove the VLAN header */
        remove_header(vlan_t);
    }
    else {
        /* Set the VLAN ID to 0 if the packet is not an VLAN packet */
        meta.vlan_id = 0;
    }
}

/* Control plane */
control ingress {
    apply(forward);
    apply(classify);
    apply(routes);
}

/* Actions */
action forward() {
    /* Lookup the destination MAC address in the forwarding table */
    table mac_table {
        key = {
            ethernet.dstAddr : l2;
            meta.vlan_id : exact;
        }
        actions {
            fwd : forward;
        }
    }

    /* Forward the packet to the output port */
    execute_meter(mac_table.fwd);
}

action classify() {
    /* Lookup the VLAN ID in the VLAN table */
    table vlan_table {
        key = {
            meta.vlan_id : exact;
        }
        actions {
            set_queue : set_queue;
        }
    }

    /* Set the queue ID */
    execute(vlan_table.set_queue);
}

action set_queue(vlan_id) {
    /* Set the queue ID in the metadata */
    meta.queue_id = vlan_id;
}

action routes() {
    /* Lookup the destination IP address in the routing table */
    table ip_table {
        key = {
            ipv4.dstAddr : lpm;
        }
        actions {
            route : route;
        }
    }

    /* Route the packet to the next hop */
    execute(ip_table.route);
}

action route(next_hop) {
    /* Set the output port in the metadata */
    meta.out_port = next_hop;

    /* Send the packet out of the output port */
    output;
}
