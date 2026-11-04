  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
local Debris = game:GetService("Debris");
require(ReplicatedStorage.Shared.Essentials);
require(ReplicatedStorage.Shared.VfxManager);
local SoundManager = require(ReplicatedStorage.Shared.SoundManager);
local Popup = require(ReplicatedStorage.Shared.Popup);

return function(p1) -- Line: 10
    -- upvalues: SoundManager (copy), ReplicatedStorage (copy), Popup (copy), Debris (copy)
    SoundManager.SpawnSound("NagiCutsceneDialogue", 1, p1.Plr.Character, 150);
    local Children = p1.Plr.Character:GetChildren();
    local Children2 = ReplicatedStorage.Assets.Vfx.NagiAura:GetChildren();

    for _, v in pairs(Children) do
        if v:IsA("BasePart") ~= false and not v:IsA("MeshPart") then
            local v2 = v;

            for _, v3 in pairs(Children2) do
                local v4 = v3:Clone();
                v4.Name = "NagiAura";
                v4.Parent = v2;
            end;
        end;
    end;

    task.delay(0.25, function() -- Line: 26
        -- upvalues: Popup (ref)
        Popup.Subtitle(game.Players.LocalPlayer, "Reo,");
    end);
    task.delay(1.75, function() -- Line: 30
        -- upvalues: Popup (ref)
        Popup.Subtitle(game.Players.LocalPlayer, "I\'m gonna give it a try.");
    end);
    table.clear(Children);
    table.clear(Children2);
    task.wait(5);
    local Descendants = p1.Plr.Character:GetDescendants();

    for _, v in pairs(Descendants) do
        if v.Name == "NagiAura" then
            v.Enabled = false;
            Debris:AddItem(v, 1.5);
        end;
    end;

    table.clear(Descendants);
end;