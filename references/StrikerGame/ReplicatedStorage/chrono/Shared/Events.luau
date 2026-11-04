 

 

require(script.Parent.Types);
local Signal = require(script.Parent.Signal);
local v1 = {};
local v2 = {};
v1.EntityAdded = Signal.new();
v2.EntityAdded = v1.EntityAdded.Event;
v1.EntityRemoved = Signal.new();
v2.EntityRemoved = v1.EntityRemoved.Event;
v1.PlayerCharacterRegistered = Signal.new();
v2.PlayerCharacterRegistered = v1.PlayerCharacterRegistered.Event;
v1.PlayerCharacterUnregistered = Signal.new();
v2.PlayerCharacterUnregistered = v1.PlayerCharacterUnregistered.Event;
v1.PlayerOwnedAdded = Signal.new();
v2.PlayerOwnedAdded = v1.PlayerOwnedAdded.Event;
v1.PlayerOwnedRemoved = Signal.new();
v2.PlayerOwnedRemoved = v1.PlayerOwnedRemoved.Event;
v1.EntityMountChanged = Signal.new();
v2.EntityMountChanged = v1.EntityMountChanged.Event;
v1.PlayerLoaded = Signal.new();
v2._Signals = v1;

return v2;