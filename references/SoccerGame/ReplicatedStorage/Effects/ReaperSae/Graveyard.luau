  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
local Lighting = game:GetService("Lighting");
require(ReplicatedStorage.Shared.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.VfxManager);
require(ReplicatedStorage.Shared.SoundManager);
local SpectatorController = require(ReplicatedStorage.Controllers.SpectatorController);
Random.new(os.clock());

local function changeLighting(p1) -- Line: 12
    -- upvalues: Lighting (copy)
    for _, child in Lighting:GetChildren() do
        child:Destroy();
    end;

    for i, v in p1:GetAttributes() do
        Lighting[i] = v;
    end;

    for _, child in p1:GetChildren() do
        child:Clone().Parent = Lighting;
    end;
end;

return function(p2) -- Line: 27
    -- upvalues: SpectatorController (copy), VfxManager (copy), changeLighting (copy), ReplicatedStorage (copy)
    local LocalPlayer = game.Players.LocalPlayer;

    if LocalPlayer.Team == game.Teams.Visitor and (LocalPlayer.PlayerGui.Misc.CloseLimited.Visible == false and (LocalPlayer.PlayerGui.Customization.Enabled == false and not SpectatorController.IsSpectating)) then
        return;
    end;

    local u3 = script.Model:Clone();
    u3.Parent = workspace.Debris;
    u3:PivotTo(workspace.Field.Field:GetPivot());
    VfxManager.Enable(u3, true);
    changeLighting(script.LightingConfig);
    task.delay(15, function() -- Line: 38
        -- upvalues: changeLighting (ref), ReplicatedStorage (ref), u3 (copy)
        changeLighting(ReplicatedStorage.Assets.MainLighting);
        u3:Destroy();
    end);
end;