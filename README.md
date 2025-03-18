## ASmap Workshop

This workspace comes with all the software you need to build an ASmap, compare it to others, and use it with Bitcoin Core.

Specifically, it includes:
- the `kartograf` program
- the `rpki-client` program, which `kartograf` depends on
- a checkout of the Bitcoin Core repository, under `bitcoin/`


### Run the thing!

Let's run `kartograf` and generate an ASmap. This will take about 10 minutes: `kartograf run map`.

If all goes well, you'll have a `final_result.txt` located at `out/a_unix_timestamp/final_result.txt`.


### Encoding it for Bitcoin Core

The Bitcoin repository includes some tools to work with ASmaps including encoding the ASmap to reduce its size.

You can run the following command, replacing the `final_result` path with your own:
`python bitcoin/contrib/asmap/asmap-tool.py encode my_final_result_path.txt final_encoded.dat`

This will take a minute or so, and output the encoded file at `final_encoded.dat`.

You can now pass this file to Bitcoin Core via the `-asmap` flag, and Core will consider this data when managing your peers.

### Check your peers coverage

Get an output from `getnodeaddresses`, and two ASmap files, and run `diff_addrs` to get a sense of which portion of your peers have an ASmap assignment. 