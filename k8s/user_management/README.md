## User management

Example playbook:

```
---
- hosts: localhost
  roles:
    - role: k8s-role-creation
      kubeconfig: "/home/mcharopkin/srn/09/KUBECONFIG"
      cluster_url: https://35.202.70.72
      user_name: dima

```
