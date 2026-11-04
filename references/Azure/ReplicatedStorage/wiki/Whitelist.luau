 

 

local v1 = {
    ronaldo = require(script.ronaldo),
    exe = require(script.exe),
    theexe = require(script.theexe),
    owner = require(script.owner),
    wally = require(script.wally),
    dukeerisia = require(script.dukeerisia),
    cinder = require(script.cinder),
    dawnwalker = require(script.dawnwalker),
    phainon = require(script.phainon),
    aizen = require(script.aizen),
    messi = require(script.messi),
    KJ = require(script.KJ),
    theKJ = require(script.theKJ),
    dio = require(script.dio),
    dio_bad = {},
    cid = require(script.cid),
    sonic = require(script.sonic),
    roland = require("@self/roland"),
    ["2011x"] = require("@self/2011x"),
    gremmy = require("@self/gremmy"),
    akuma = require("@self/akuma"),
    akashi = require("@self/akashi"),
    killua = require(script.killua),
    zantetsu = {},
    dustsbscreation = require(script.dustsbscreation),
    milkytillys = { 4678987333, 1974243283 },
    Goku = require(script.Goku)
};
local v2 = { "cinder", "dawnwalker", "dukeerisa", "wally", "owner", "aizen", "sonic", "2011x", "akashi", "gremmy", "KJ", "dio", "Goku", "dustsbscreation" };

for _, v in { 1549164509, 236578085, 5833700555, 42087622, 619213444, 144335594 } do
    local v3 = v;

    for i, v4 in v1 do
        if not table.find(v2, i) then
            table.insert(v4, v3);
        end;
    end;
end;

return v1;