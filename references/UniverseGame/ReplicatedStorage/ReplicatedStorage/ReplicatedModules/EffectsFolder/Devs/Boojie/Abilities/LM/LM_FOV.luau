  

 

local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
require(PathShortcuts.GenericModule);
local _ = PathShortcuts.ClientAssets;
Random.new();

return function(p1) -- Line: 7
    if game.Players.LocalPlayer.Settings.CutsceneCamera.Value == false then
        return;
    end;

    workspace.CurrentCamera.FieldOfView = p1;
end;