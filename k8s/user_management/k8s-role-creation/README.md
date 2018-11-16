Role Name
=========

Role creates user in specified cubernetes cluster ans saves `kubeconfig` for this user

Requirements
------------

* `kubectl` installed
* `kubeconfig` available


Role Variables
--------------

*  `user_name`(String) -- username var. Default: `admin-custom`
*  `user_namespace`(String) -- namespace where user should be created. Default: `default`
*  `cluster_role`(Boolean) -- `True` if `ClusterRole` else `False`. Default: `True`
*  `kubeconfig`(String) -- Path to kubeconfig. Default: `"~/.kube/config"`
*  `cluster_url`(String) -- Url to cluster. `Required`
*  `role_templates`(List) -- List of kubernetes yml templates to render. `Optional`


Dependencies
------------

No dependencies currently.

Example Playbook
----------------

```
- hosts: localhost
  roles:
    - role: k8s-role-creation
      kubeconfig: {{ kubeconfig_path | default('~/.kube/config') }}
      cluster_url: {{ cluster_url }}
      user_name: {{ user_name | default(admin-custom) }}

```
License
-------

BSD

Author Information
------------------

TBD
