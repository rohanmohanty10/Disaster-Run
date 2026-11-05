  

 

local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
require(PathShortcuts.GenericModule);
local u1 = game.ReplicatedStorage:WaitForChild("Client Assets");
local ParticleHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
game:GetService("TweenService");

return function(p2, p3, p4, p5, p6) -- Line: 9
    -- upvalues: u1 (copy), ParticleHandler (copy)
    if not (p2 and p2:IsDescendantOf(workspace)) then
        return;
    end;

    local v7 = p2:FindFirstChild(p4 or "StandTrail");

    if not v7 then
        v7 = ((p6 and u1["Soul Survivor"][p6] or u1["Soul Survivor"]):FindFirstChild(p4 or "StandTrail") or u1["Soul Survivor"][p4 or "StandTrail"]):Clone();
        v7.CFrame = p2.CFrame;
        v7.Anchored = false;
        v7.CanCollide = false;
        v7.Massless = true;

        if p5 then
            local v8 = game.Players:GetPlayerFromCharacter(p5);
            local v9 = 0;

            if v8 and v8.Data.Skin:GetAttribute("UnusualHueId") then
                v9 = v9 + v8.Data.Skin:GetAttribute("UnusualHueId") * 5;
            end;

            if v9 > 0 then
                ParticleHandler.HSVShiftParticles(v7, {
                    HueShift = v9
                });
            end;
        end;

        for _, descendant in pairs(v7:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:SetAttribute("StandTrail", true);
            end;
        end;

        local WeldConstraint = Instance.new("WeldConstraint");
        WeldConstraint.Part0 = p2;
        WeldConstraint.Part1 = v7;
        WeldConstraint.Parent = v7;
        v7.Parent = p2;
    end;

    for _, descendant in pairs(v7:GetDescendants()) do
        if descendant:IsA("ParticleEmitter") or (descendant:IsA("Beam") or descendant:IsA("Trail")) then
            descendant.Enabled = p3 or false;
        end;
    end;
end;