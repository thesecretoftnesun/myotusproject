#!/usr/bin/env python3

import json
import subprocess
import sys

def fetch_terraform_outputs():
    """Запрашивает outputs из Terraform в JSON формате"""
    try:
        result = subprocess.run(
            ["terraform", "output", "-json"],
            check=True,
            stdout=subprocess.PIPE,
            stderr=subprocess.PIPE,
            text=True
        )
        return json.loads(result.stdout)
    except subprocess.CalledProcessError as e:
        print(f"Error fetching Terraform outputs: {e.stderr}", file=sys.stderr)
        sys.exit(1)

def main():
    outputs = fetch_terraform_outputs()

    # Инициализируем инвентори с группами, используя только IP-адреса
    inventory = {
        "keycloak": {
            "hosts": [outputs["keycloak_public_ip"]["value"]]
        },
        "postgres": {
            "hosts": [outputs["postgres_host"]["value"]]
        },
        "samba": {
            "hosts": [outputs["samba_public_ip"]["value"]]
        },
        "zabbix": {
            "hosts": [outputs["zabbix_public_ip"]["value"]]
        },
        "all": {
            "hosts": [
                outputs["keycloak_public_ip"]["value"],
                outputs["postgres_host"]["value"],
                outputs["samba_public_ip"]["value"],
                outputs["zabbix_public_ip"]["value"]
            ]
        },
        "_meta": {
            "hostvars": {}
        }
    }

    # Выводим инвентори в формате JSON для Ansible
    print(json.dumps(inventory, indent=2))

if __name__ == "__main__":
    main()