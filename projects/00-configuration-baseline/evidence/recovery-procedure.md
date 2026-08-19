# Recovery Procedure

How this got fixed after the failure test — and whether the procedure below was actually tested, or is still theoretical.

## Procedure

1. Confirm the drift is real, on the affected host, rather than assuming it from a report:
   `ssh <user>@<host> 'which <package>; cat /etc/motd'`
2. Re-run the baseline playbook against the inventory, with no special flags:
   `ansible-playbook -i inventory.ini baseline.yml`
3. Read the recap: the drifted host should report `changed` only for the items that actually drifted; unaffected hosts should report `changed=0`.
4. Verify restoration directly on the host, not from Ansible's output alone.
5. Run the playbook once more. A `changed=0` result on all hosts confirms the system has settled to a stable state.

## Was this tested?

**Yes** — executed end to end on 2026-08-19 against `debian-test-1`, after deliberately removing a managed package and deleting a managed config file. See `failure-test.md` for the full record.

## Time to recover

Under a minute of actual runtime — a single playbook run, no manual repair steps, no changes to the playbook required.

## Notes

The recovery procedure and the normal configuration procedure are the same command. That is the point of a declarative, idempotent baseline: there is no separate "repair mode" to remember or maintain — reapplying the desired state *is* the repair.
