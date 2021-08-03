
Ansible Role: InnoDB ReplicaSet
=========

![CI](https://github.com/v0112358/ansible-role-innodb-replicaset/actions/workflows/main.yml/badge.svg) ![Ansible Role](https://img.shields.io/ansible/role/55881) ![Ansible Role](https://img.shields.io/ansible/role/d/55881) [![GitHub license](https://img.shields.io/github/license/v0112358/ansible-role-innodb-replicaset)](https://github.com/v0112358/ansible-role-innodb-replicaset/blob/master/LICENSE.md)

Install and configure MySQL InnoDB ReplicaSet on your system.

Example Inventory
------------
```
[innodb_replicaset:children]
innodb_replicaset_infra

[innodb_replicaset_infra]
innodb-replicaset-0               innodb_replicaset_role="primary" run_mysqlrouter="yes"
innodb-replicaset-1               innodb_replicaset_role="secondary" run_mysqlrouter="yes"
```
Example Playbook
------------

```
---
- name: Deploy InnoDB ReplicaSet
  hosts: innodb-replicaset
  pre_tasks:
    - name: Verify Ansible meets InnoDB ReplicaSet requirements.
      assert:
        that: "ansible_version.full is version_compare('2.10.0', '>=')"
        msg: >
          "You must update Ansible to at least 2.10.0 to use this playbook"
  roles:
    - { role: innodb-replicaset, tags: innodb-replicaset }
```

Role Variables
--------------

These variables are set in defaults/main.yml. Please review and update default password:
```
######### InnoDB ReplicaSet
innodb_replicaset_cluster_admin: "rsadmin"
innodb_replicaset_cluster_password: "*Replica_pass21_sample"
innodb_replicaset_name: "rs_infra"

######### MySQLRouter
mysqlrouter_password: "*MysqlRouter_pass21_sample"
mysqlrouter_connect_timeout: 10
mysqlrouter_read_timeout: 10
mysqlrouter_bind_address: 0.0.0.0

######### Percona server
percona_server_version: "8.0.25-15"
percona_xtrabackup_version: "8.0.25-17"
percona_server_root_password: "demozCYqkQsampleYRwiQ0n7demo"
percona_server_packages:
 - ....
```

Requirements
------------

pip packages listed in requirements.txt.

License
-------

MIT

Author Information
------------------
v0112358
