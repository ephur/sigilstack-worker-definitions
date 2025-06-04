# coreDNS

> This has nothing to do with CoreDNS the project. This is *my* "coreDNS" infrastructure. It was going to be core DNS, but I didn't want to deal with escaping the space; that's for rockets.

## Overview

This module is the petty dictator of all things DNS in SigilStack.

- Reads a TXT record from `_domains.ephur.net` to determine which domains deserve to exist.
- Decides authoritatively where domains should live: if it starts with `ephur`, it’s Route53. If it starts with `sigilstack`, it’s Cloudflare. No democracy.
- Just enough safeguards to not break everything, but not enough to stop you from breaking everything.
- Terraform doesn't natively handle DNS providers well. So we patch over the chaos with:
  - Use SSM to overly complicate a force apply mechanism
  - more hooks than a fishing trip
    - pre_init to ensure the SSM parameter exists to avoid a chicken-and-egg problem
    - post_apply to update the PorkBun registrar with the latest NS records. It also checks name servers, flips registrar locks, updates authoritative records, and logs everything with enough verbosity to make your future self cry (happily).
- Contains logic to ensure AWS-only and Cloudflare-only domains don’t overlap or sneak into the wrong camp.
- All logs are structured, traceable, and JSONified—because one day you’ll care.

## Outputs

- `aws_zone_ids`: list of Route53 hosted zone IDs
- `cloudflare_zone_ids`: list of Cloudflare zone IDs
- `all_zones`: combined list of all domains we're babysitting

## Other Notes

- Porkbun API only supports POST. We embrace this.
- DNS delegation strategies are totally intentional. If the providers say "you can't do that," we pretend not to hear them.
- `post_apply` is aggressively modular but still lives in one script—because Python imports felt like too much commitment.
