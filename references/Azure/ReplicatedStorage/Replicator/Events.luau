 

 

local v1 = require("@game/ReplicatedStorage/Network/Signal");

return {
    EntityAdded = v1.new(),
    EntityRemoved = v1.new(),
    CharacterRegistered = v1.new(),
    CharacterUnregistered = v1.new(),
    OwnerChanged = v1.new(),
    Snapshot = v1.new(),
    Teleported = v1.new()
};