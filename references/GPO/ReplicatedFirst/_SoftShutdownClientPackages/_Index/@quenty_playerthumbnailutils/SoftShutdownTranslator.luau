 

local v1 = require(script.Parent.loader).load(script)("JSONTranslator").new
local v2 = {}
local v3 = {
    ["lobby"] = {
        ["title"] = "Rebooting servers for update.",
        ["subtitle"] = "Teleporting back in a moment..."
    },
    ["restart"] = {
        ["title"] = "Rebooting servers for update.",
        ["subtitle"] = "Please wait..."
    },
    ["complete"] = {
        ["title"] = "Rebooting servers for update.",
        ["subtitle"] = "Update complete..."
    }
}
v2.shutdown = v3
return v1("en", v2)