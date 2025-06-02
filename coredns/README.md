# coreDNS

NOTE: Do not be confused friend, this has nothing to do with the awesome lightweight DNS resolver, CoreDNS,
this is a definition, for my "core DNS" infrastructure, but I didn't want to put a space right there. While
I might like to escape to space, I do not like escaping spaces.

## Overview 

- Uses the DNS terraform provider to fetch a data source, txt record: _domains.ephur.net, for each domain, 
  enusres there is a hosted zone in both of our preferred DNS providers. This provider is kind of flakey, so 
  it makes sense to use it as the main entry control point for sigilstack
- an optional terraform variable can be passed, which will modify a null resource in order to force an apply
- outputs three things, a list of all AWS dns zones, a list of all CLOUDFLARE zones, a combined list of all zones
- a post_apply hook runs, using the porkbun API to set the Authoritative DNS servers for each domain

