 

local v1 = require(script.Index)
return {
    ["Server"] = v1.Server,
    ["Client"] = v1.Client,
    ["fromServerArray"] = v1.fromServerArray,
    ["fromClientArray"] = v1.fromClientArray,
    ["OnSpamSignal"] = v1.OnSpamSignal,
    ["Signal"] = v1.Signal,
    ["fromSignalArray"] = v1.fromSignalArray,
    ["buffer"] = v1.buffer
}