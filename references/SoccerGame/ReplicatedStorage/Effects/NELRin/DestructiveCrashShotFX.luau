  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
game:GetService("Debris");
game:GetService("RunService");
game:GetService("Players");
game:GetService("TweenService");
require(ReplicatedStorage.Packages.Knit);
require(ReplicatedStorage.Shared.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.VfxManager);
require(ReplicatedStorage.Shared.SoundManager);
require(ReplicatedStorage.Shared.Popup);
local SpectatorController = require(ReplicatedStorage.Controllers.SpectatorController);
ReplicatedStorage:FindFirstChild("Assets"):FindFirstChild("Vfx");
local Debris = workspace:FindFirstChild("Debris");

local function cleanup(p1, p2) -- Line: 18
    -- upvalues: Debris (copy)
    local _ = game.Players.LocalPlayer;
    local v3 = Debris:FindFirstChild(p2);

    for _, descendant in p1:GetDescendants() do
        if descendant:GetAttribute("DestructiveShot") then
            descendant:Destroy();
        end;
    end;

    if v3 then
        v3:Destroy();
    end;
end;

return function(p4) -- Line: 35
    -- upvalues: SpectatorController (copy), Debris (copy), VfxManager (copy), cleanup (copy)
    if game.Players.LocalPlayer.Team == game.Teams.Visitor and not SpectatorController.IsSpectating then
        return;
    end;

    local Char = p4.Char;
    local v5;

    if Char then
        v5 = Char:FindFirstChild("HumanoidRootPart");
    else
        v5 = Char;
    end;

    if not v5 then
        return;
    end;

    local v6 = script.Name .. " VFX FOLDER " .. Char.Name;
    local v7 = Debris:FindFirstChild(v6) or nil;
    local v8 = 1;

    if p4.Task == "ChargeKick" then
        if not Char then
            return;
        end;

        local Folder = Instance.new("Folder");
        Folder.Name = v6;
        Folder.Parent = Debris;
        local v9 = script.VFX:Clone();
        v9:PivotTo(Char.HumanoidRootPart.CFrame);
        v9.Parent = Folder;
        local v10 = v9.ChargeKick:Clone();
        VfxManager.Enable(v10, true);
        local v11 = v9.LinesLeg:Clone();
        VfxManager.Enable(v11, true);

        for _, child in script.Aura.RinAura:GetChildren() do
            local v12 = child;

            for _, child2 in child:GetChildren() do
                local v13 = child2:Clone();
                v13.Parent = Char:FindFirstChild(v12.Name);
                VfxManager.Enable(v13);
                v13:SetAttribute("DestructiveShot", true);
            end;
        end;

        return;
    end;

    if p4.Task == "KickRelease" then
        VfxManager.Emit(v7.VFX.KickRelease);

        return;
    end;

    if p4.Task == "RinStep" then
        VfxManager.Emit(v7.VFX.RinStep);

        return;
    end;

    if p4.Task == "Release" then
        VfxManager.Emit(v7.VFX.Release);

        return;
    end;

    if p4.Task == "LinesOn" then
        VfxManager.Enable(v7.VFX.Lines, true);

        return;
    end;

    if p4.Task == "VictimStep" then
        VfxManager.Emit(v7.VFX["P2Step" .. v8]);
        local _ = v8 + 1;

        return;
    end;

    if p4.Task == "LinesOff" then
        VfxManager.Enable(v7.VFX.Lines, false);

        return;
    end;

    if p4.Task == "Guard" then
        VfxManager.Emit(v7.VFX.Guard);

        return;
    end;

    if p4.Task == "ChargeKick2" then
        VfxManager.Enable(v7.VFX.ChargeKick2, true);

        return;
    end;

    if p4.Task == "ChargeKick2End" then
        local VFX = v7.VFX;
        VfxManager.Enable(VFX.ChargeKick2, false);
        VfxManager.Enable(VFX.FinalKick, true);

        return;
    end;

    if p4.Task == "FinalKickFloor" then
        VfxManager.Emit(v7.VFX.FinalKickFloor);

        return;
    end;

    if p4.Task == "FinalKickEnd" then
        VfxManager.Enable(v7.VFX.FinalKick, false);

        return;
    end;

    if p4.Task == "Cleanup" then
        cleanup(Char, v6);
    end;
end;