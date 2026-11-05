  

 

local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local ItemData = require(PathShortcuts.ReplicatedModules.ItemData);
local EffectsHandler = require(game.ReplicatedStorage.ReplicatedModules.EffectsHandler);
local Rig = game.ReplicatedStorage["Client Assets"].Assets.Abilities.KillEffects.Preview.Rig;
local u2 = {
    ["A-Train"] = function(u1) -- Line: 8
        task.delay(0.31666666666666665, function() -- Line: 9
            -- upvalues: u1 (copy)
            u1:BreakJoints();

            for _, descendant in pairs(u1:GetDescendants()) do
                if descendant:IsA("JointInstance") then
                    descendant:Destroy();
                end;
            end;
        end);
    end
};

return function(p3, p4) -- Line: 20
    -- upvalues: ItemData (copy), Rig (copy), u2 (copy), EffectsHandler (copy)
    local v5 = ItemData.GetItemInfo(p3);

    if not v5 or (v5.Type ~= "KillEffect" or Rig:GetAttribute("Cooldown")) then
        return;
    end;

    Rig:SetAttribute("Cooldown", true);
    task.delay(1.5, function() -- Line: 26
        -- upvalues: Rig (ref)
        Rig:SetAttribute("Cooldown", nil);
    end);
    local Character = game.Players.LocalPlayer.Character;
    local HumanoidRootPart = Character.HumanoidRootPart;
    local v6 = Character.Humanoid:GetAppliedDescription();
    local v7 = Rig:Clone();
    v7.Parent = workspace.Effects;
    v7.Humanoid:ApplyDescription(v6);
    task.wait(0.1);

    for _, descendant in v7:GetDescendants() do
        if descendant:IsA("BasePart") then
            descendant.CollisionGroup = "Ghosted";
        end;
    end;

    task.delay(3, v7.Destroy, v7);

    if u2[v5.Name] then
        u2[v5.Name](v7);
    end;

    v7.HumanoidRootPart.CFrame = HumanoidRootPart.CFrame * CFrame.new(0, 0, -5) * CFrame.Angles(0, 3.141592653589793, 0);
    local Name = v5.Name;

    if v5.Inherit then
        v5 = ItemData.GetItemInfo(v5.Inherit);
    end;

    EffectsHandler.CallEffect(`KillEffect_{v5.Name}`, {
        TargetCharacter = v7,
        KillerPlayer = game.Players.LocalPlayer,
        ItemId = p3,
        Name = Name
    });
end;