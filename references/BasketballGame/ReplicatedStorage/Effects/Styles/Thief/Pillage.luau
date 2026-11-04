 
 

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
game:GetService("RunService");
game:GetService("Lighting");
local Knit = require(ReplicatedStorage.Packages.Knit);
local Essentials = require(ReplicatedStorage.Shared.Utility.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.Utility.VfxManager);
local SfxManager = require(ReplicatedStorage.Shared.Utility.SfxManager);
local Effects = require(ReplicatedStorage.Shared.Utility.Effects);
local Abilities = require(ReplicatedStorage.Controllers.AbilityController.Abilities);
local Cooldowns = require(ReplicatedStorage.Shared.Tables.Cooldowns);
local _ = Players.LocalPlayer;
local Debris = workspace:FindFirstChild("Debris");

return function(p1, p2) -- Line: 18
    -- upvalues: SfxManager (copy), Debris (copy), VfxManager (copy), Essentials (copy), Players (copy), Knit (copy), Cooldowns (copy), Effects (copy), Abilities (copy)
    local TimeSent = p2.TimeSent;
    local _ = workspace:GetServerTimeNow() - TimeSent;
    local Character = p2.Character;
    local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart");
    local Head = Character:FindFirstChild("Head");
    SfxManager:playSound({
        Sound = "Copy",
        Parent = HumanoidRootPart
    });
    local v3 = script.StartEmit:Clone();
    v3.CFrame = HumanoidRootPart.CFrame;
    v3.Parent = Debris;
    VfxManager.Emit(v3);
    VfxManager.DestroyEffect(v3, 3);
    local u4 = script.EyeFX:Clone();
    u4.CFrame = Head.CFrame;
    u4.Parent = Debris;
    Essentials:Weld(u4, Head);
    VfxManager.Emit(u4.Emit);
    VfxManager.Enable(u4.Enabling, true);
    task.delay(1, function() -- Line: 42
        -- upvalues: u4 (copy), VfxManager (ref)
        if u4 then
            VfxManager.Enable(u4.Enabling, false);
            VfxManager.DestroyEffect(u4, 2);
        end;
    end);

    if Players.LocalPlayer == p2.Enemy then
        local Controller = Knit.GetController("Network");
        local Controller2 = Knit.GetController("AbilityController");
        local Value = Players.LocalPlayer.Style.Value;
        local v5 = p2.Index or 1;

        if Controller2.CDS[p2.Index or 1] < tick() + Cooldowns.Abilities[Value][v5] / 2 then
            Controller2.CDS[p2.Index or 1] = tick() + Cooldowns.Abilities[Value][v5] / 2;
        end;

        Effects:Popup((Controller.CharValues.HasBall and Abilities[Value][v5].BallName and Abilities[Value][v5].BallName or Abilities[Value][v5].Name) .. " ability pillaged by " .. Character.Name .. "!");
    end;
end;