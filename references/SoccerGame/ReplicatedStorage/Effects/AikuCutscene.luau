  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
game:GetService("Debris");
require(ReplicatedStorage.Shared.Essentials);
require(ReplicatedStorage.Shared.VfxManager);
local SoundManager = require(ReplicatedStorage.Shared.SoundManager);
local Popup = require(ReplicatedStorage.Shared.Popup);
local SpectatorController = require(ReplicatedStorage.Controllers.SpectatorController);

return function(u1) -- Line: 11
    -- upvalues: SpectatorController (copy), SoundManager (copy), Popup (copy), ReplicatedStorage (copy)
    if game.Players.LocalPlayer.Team == game.Teams.Visitor and not SpectatorController.IsSpectating then
        return;
    end;

    SoundManager.SpawnSound("AikuAwakening", 1, u1.Plr.Character.HumanoidRootPart, 150);
    Popup.Subtitle(game.Players.LocalPlayer, "While I\'m on patrol..");
    task.delay(3, function() -- Line: 17
        -- upvalues: Popup (ref)
        Popup.Subtitle(game.Players.LocalPlayer, "You won\'t be stealing any goals.");
    end);
    task.spawn(function() -- Line: 21
        -- upvalues: ReplicatedStorage (ref), u1 (ref)
        local Descendants = ReplicatedStorage.Assets.Vfx.AikuCutsceneAura:GetDescendants();
        local v2 = {};

        for _, v in pairs(Descendants) do
            if v:IsA("ParticleEmitter") == false then
                if v:IsA("Highlight") then
                    local v3 = v:Clone();
                    v3.Name = "AikuAura";
                    v3.Parent = u1.Plr.Character;
                end;
            elseif not v2[v.Parent] then
                if v.Parent:IsA("Attachment") then
                    v2[v.Parent] = true;
                    local v4 = v.Parent:Clone();
                    v4.Name = "AikuAura";
                    v4.Parent = u1.Plr.Character[v.Parent.Parent.Name];
                else
                    local v5 = v:Clone();
                    v5.Name = "AikuAura";
                    v5.Parent = u1.Plr.Character[v.Parent.Name];
                end;
            end;
        end;

        table.clear(v2);
        table.clear(Descendants);
    end);
    task.delay(6, function() -- Line: 57
        -- upvalues: u1 (ref)
        task.spawn(function() -- Line: 58
            -- upvalues: u1 (ref)
            local Descendants = u1.Plr.Character:GetDescendants();

            for _, v in pairs(Descendants) do
                if v ~= nil and (v.Parent ~= nil and (v.Name == "AikuAura" or v.Parent.Name == "AikuAura")) then
                    if v.Parent:IsA("Attachment") then
                        v.Parent:Destroy();
                    else
                        v:Destroy();
                    end;
                end;
            end;

            table.clear(Descendants);
            table.clear(u1);
            u1 = nil;
        end);
    end);
end;