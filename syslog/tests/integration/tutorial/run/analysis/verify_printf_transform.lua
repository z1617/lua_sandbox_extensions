-- This Source Code Form is subject to the terms of the Mozilla Public
-- License, v. 2.0. If a copy of the MPL was not distributed with this
-- file, You can obtain one at http://mozilla.org/MPL/2.0/.

require "string"
local test = require "test_verify_message"

local messages = {
    {
        Timestamp = 1518531919000000000,
        Logger = "input.printf_transform",
        Hostname = "ubuntu",
        Payload = "Accepted publickey for foobar from 216.160.83.56 port 4242 ssh2",
        Pid = 7192,
        Fields = {
            ssh_remote_port = 4242,
            method = "publickey",
            user = "foobar",
            extra = "",
            authmsg = "Accepted",
            ssh_remote_ipaddr_city = "Milton",
            ssh_remote_ipaddr_country = "US",
            programname = "sshd",
            ssh_remote_ipaddr = {value = "216.160.83.56", representation = "ipv4"}
        }
    }
}

local cnt = 0
function process_message()
    cnt = cnt + 1
    local received = decode_message(read_message("raw"))
    test.fields_array_to_hash(received)
    test.verify_msg(messages[cnt], received, cnt)
    return 0
end

function timer_event(ns)
    assert(cnt == #messages, string.format("%d of %d tests ran", cnt, #messages))
end
