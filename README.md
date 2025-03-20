## ASmap Workshop

This workspace comes with all the software you need to build an ASmap, compare it to others, and use it with Bitcoin Core.

Specifically, it includes:
- the `kartograf` program
- the `rpki-client` program, which `kartograf` depends on
- a checkout of the Bitcoin Core repository, under `bitcoin/`


### Run the thing!

You can run `kartograf` by clicking the green "Run" button at the top of this screen. You can follow the progress in the `Console` tab.

You can also run it from the Shell, by running `nix develop` then `kartograf run map`.

Data for each run is stored in a folder named by the Unix timestamp at which the run began. Source data is stored under `data/` and the run output under `out/`. If all goes well, at the end you'll have a `final_result.txt` located at `out/a_unix_timestamp/final_result.txt`.

### While it cooks

While it cooks, let's discuss what it's doing.

We're fetching certificates and cryptographic signatures on those certificates by AS all over the world. The system for this validation of routes is called RPKI. If the whole internet can on RPKI, that would be great for the security and stability of the Internet, but that is not the case.

We start by downloading TALs (Trust Anchor Locators) for each Regional Internet Registry. We'll use these to validate that there's a chain of valid certificates for the route all the way to the RIR itself. The TAL is just a public key that the RIR makes known to all.

We then query all RPKI databases we can find for their data and download it. This can take a while. Once we have that RPKI data, we validate it, i.e. we check the signatures on the route announcements (ROAs). This can also take a while.

Kartograf can fetch data from other sources, such as IRR and Routeviews, with the `-irr` and `-rv` flags. It will then use those other sources when compiling the final map, and will have to compare data between the two or three datasets and resolve differences. So while adding sources increases coverage, it also generally means a longer runtime.

### Encoding it for Bitcoin Core

The Bitcoin repository includes some tools to work with ASmaps including encoding the ASmap to reduce its size.

You can run the following command, replacing the `final_result` path with your own:
`python bitcoin/contrib/asmap/asmap-tool.py encode my_final_result_path.txt final_encoded.dat`

This will take a minute or so, and output the encoded file at `final_encoded.dat`.

You can now pass this file to Bitcoin Core via the `-asmap` flag, and Core will consider this data when managing your peers.

### ASmap Health Check

If you start bitcoind with the `-asmap` flag, it will run a "health check" every 24 hours and log the count of peers and their coverage by the given ASmap. You should see something like:

`ASMap Health Check: 54435 clearnet peers are mapped to 3970 ASNs with 263 peers being unmapped`

### Check your peers coverage

Query your Bitcoin node with the `getnodeaddresses` RPC command. If you have two ASmap files, you can run `diff_addrs` to get a sense of how ASmap assignments have changed between the two ASmap runs.
