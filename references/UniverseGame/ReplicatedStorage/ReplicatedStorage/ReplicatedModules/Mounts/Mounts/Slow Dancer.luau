  

 

local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
local TableUtil = require(Knit.Util.TableUtil);
local HorseCommon = require(PathShortcuts.ReplicatedModules.Mounts.Mounts["Silver Bullet"].HorseCommon);

return TableUtil.Reconcile({
    ItemId = "MOUNT_49"
}, HorseCommon);