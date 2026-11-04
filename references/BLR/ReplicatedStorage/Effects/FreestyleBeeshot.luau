  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
local Debris = game:GetService("Debris");
game:GetService("RunService");
game:GetService("Players");
game:GetService("TweenService");
local Knit = require(ReplicatedStorage.Packages.Knit);
require(ReplicatedStorage.Shared.Essentials);
require(ReplicatedStorage.Shared.VfxManager);
local SoundManager = require(ReplicatedStorage.Shared.SoundManager);
require(ReplicatedStorage.Shared.Popup);
local SpectatorController = require(ReplicatedStorage.Controllers.SpectatorController);
ReplicatedStorage:FindFirstChild("Assets"):FindFirstChild("Vfx");
local Debris2 = workspace:FindFirstChild("Debris");
local AbilityUtility = require(ReplicatedStorage.Assets.Misc.FreestyleBeeEffects.Effects.AbilityUtility);

local function cleanup(p1, p2) -- Line: 19
    -- upvalues: Debris2 (copy), Knit (copy)
    local LocalPlayer = game.Players.LocalPlayer;
    local v3 = Debris2:FindFirstChild(p2);
    local _ = LocalPlayer.PlayerGui.ScreenFlash.Frame;
    Knit.GetController("CameraController").Cutscene = false;

    for _, descendant in p1:GetDescendants() do
        if descendant:GetAttribute("GeniusKilling") then
            descendant:Destroy();
        end;
    end;

    if v3 then
        v3:Destroy();
    end;
end;

return function(p4) -- Line: 38
    -- upvalues: SpectatorController (copy), SoundManager (copy), Debris2 (copy), ReplicatedStorage (copy), AbilityUtility (copy), Debris (copy), cleanup (copy)
    if game.Players.LocalPlayer.Team == game.Teams.Visitor and not SpectatorController.IsSpectating then
        return;
    end;

    local Char = p4.Char;
    local v5 = script.Name .. " VFX FOLDER " .. Char.Name;

    if p4.Task ~= "Cutscene" then
        if p4.Task == "Event1" then
            local v6 = Debris2:FindFirstChild(v5);

            if v6 then
                v6 = v6:FindFirstChild("BEE_SCENE");
            end;

            if v6 then
                AbilityUtility:AllVFX(v6.Effects.BeeShot.SmokeRun, true);
                AbilityUtility:AllVFX(v6.Effects.BeeShot.SpeedRunsLines, true);

                return;
            end;
        elseif p4.Task == "Event2" then
            local v7 = Debris2:FindFirstChild(v5);

            if v7 then
                v7 = v7:FindFirstChild("BEE_SCENE");
            end;

            for _, child in ReplicatedStorage.Assets.Misc.FreestyleBeeEffects.Neo_Hex:GetChildren() do
                if child:IsA("BasePart") then
                    local v8 = Char:FindFirstChild(child.Name);

                    if v8 then
                        for _, child2 in child:GetChildren() do
                            if child2:IsA("ParticleEmitter") then
                                local v9 = child2:Clone();
                                v9:SetAttribute("GeniusKilling", true);
                                v9.Parent = v8;
                                v9.Enabled = true;
                                AbilityUtility:AllVFX(v9, true);
                            end;
                        end;
                    end;
                end;
            end;

            if v7 then
                AbilityUtility:AllVFX(v7.Effects.BeeShot.SmokeRun, false);
                AbilityUtility:EmitAll(v7.Effects.BeeShot.KickBall1);

                return;
            end;
        elseif p4.Task == "Event3" then
            local v10 = Debris2:FindFirstChild(v5);

            if v10 then
                v10 = v10:FindFirstChild("BEE_SCENE");
            end;

            if v10 then
                AbilityUtility:EmitAll(v10.Effects.BeeShot.SmokeDebree);
                AbilityUtility:EmitAll(v10.Effects.BeeShot.BallTouch);

                return;
            end;
        elseif p4.Task == "Event4" then
            local v11 = Debris2:FindFirstChild(v5);

            if v11 then
                v11 = v11:FindFirstChild("BEE_SCENE");
            end;

            if v11 then
                AbilityUtility:AllVFX(v11.Effects.BeeShot.MonsterAuraBeams, false);
                AbilityUtility:AllVFX(v11.Effects.BeeShot.SpeedBoost1, true);

                return;
            end;
        else
            if p4.Task == "Event5" then
                return;
            end;

            if p4.Task == "Event6" then
                local v12 = Debris2:FindFirstChild(v5);

                if v12 then
                    v12 = v12:FindFirstChild("BEE_SCENE");
                end;

                if v12 then
                    AbilityUtility:AllVFX(v12.Effects.BeeShot.SpeedRunsLines, false);
                    AbilityUtility:AllVFX(v12.Effects.BeeShot.SpeedBoost1, false);
                    AbilityUtility:EmitAll(v12.Effects.BeeShot.Leap);

                    return;
                end;
            elseif p4.Task == "Event7" then
                local v13 = Debris2:FindFirstChild(v5);

                if v13 then
                    v13 = v13:FindFirstChild("BEE_SCENE");
                end;

                if v13 then
                    AbilityUtility:EmitAll(v13.Effects.BeeShot.BeeSpawn);
                    AbilityUtility:AllVFX(v13.Effects.BeeShot.Shoot, 1);

                    return;
                end;
            elseif p4.Task == "Event11" then
                local v14 = Debris2:FindFirstChild(v5);

                if v14 then
                    v14 = v14:FindFirstChild("BEE_SCENE");
                end;

                if v14 then
                    AbilityUtility:AllVFX(v14.Effects.BeeShot.MonsterAuraBeams, false);
                    AbilityUtility:AllVFX(v14.Effects.BeeShot, false);
                    AbilityUtility:AllVFX(v14.Neo_Hex, false);

                    return;
                end;
            elseif p4.Task == "Cleanup" then
                cleanup(Char, v5);
            end;
        end;

        return;
    end;

    SoundManager.SpawnSound("rainbow kick", 5, workspace, 150);
    local Folder = Instance.new("Folder");
    Folder.Parent = workspace;
    Folder.Name = v5;
    Folder.Parent = Debris2;
    local v15 = ReplicatedStorage.Assets.Misc.FreestyleBeeEffects:Clone();
    v15:PivotTo(Char:GetPivot());
    v15.Name = "BEE_SCENE";
    v15.Parent = Folder;
    local Neo_Hex = ReplicatedStorage.Assets.Misc.FreestyleBeeEffects.Neo_Hex;
    local BeeShot = ReplicatedStorage.Assets.Misc.FreestyleBeeEffects.Effects.BeeShot;
    local v16 = Neo_Hex.Torso.CFrame:ToObjectSpace(BeeShot.SmokeRun.CFrame);
    local v17 = Neo_Hex.Torso.CFrame:ToObjectSpace(BeeShot.SpeedRunsLines.CFrame);
    local v18 = Neo_Hex.PrimaryPart.CFrame:ToObjectSpace(BeeShot.KickBall1.CFrame);
    local v19 = Neo_Hex.PrimaryPart.CFrame:ToObjectSpace(BeeShot.SmokeDebree.CFrame);
    local v20 = Neo_Hex.PrimaryPart.CFrame:ToObjectSpace(BeeShot.BallTouch.CFrame);
    local v21 = Neo_Hex.PrimaryPart.CFrame:ToObjectSpace(BeeShot.MonsterAuraBeams.CFrame);
    local v22 = Neo_Hex.PrimaryPart.CFrame:ToObjectSpace(BeeShot.SpeedBoost1.CFrame);
    local v23 = Neo_Hex.PrimaryPart.CFrame:ToObjectSpace(BeeShot.Leap.CFrame);
    local v24 = Neo_Hex.PrimaryPart.CFrame:ToObjectSpace(BeeShot.BeeSpawn.CFrame);
    local v25 = Neo_Hex.PrimaryPart.CFrame:ToObjectSpace(BeeShot.Shoot.CFrame);

    for _, descendant in v15:GetDescendants() do
        if descendant:IsA("BasePart") then
            descendant.Anchored = false;
            descendant.CanCollide = false;
            descendant.CanQuery = false;
            descendant.CanTouch = false;
        end;
    end;

    for i, v in {
        {
            obj = v15.Effects.BeeShot.SmokeRun,
            cf = v16,
            originPart = Char.Torso
        },
        {
            obj = v15.Effects.BeeShot.SpeedRunsLines,
            cf = v17,
            originPart = Char.Torso
        },
        {
            obj = v15.Effects.BeeShot.KickBall1,
            cf = v18,
            originPart = Char.PrimaryPart
        },
        {
            obj = v15.Effects.BeeShot.SmokeDebree,
            cf = v19,
            originPart = Char.PrimaryPart
        },
        {
            obj = v15.Effects.BeeShot.BallTouch,
            cf = v20,
            originPart = Char.PrimaryPart
        },
        {
            obj = v15.Effects.BeeShot.MonsterAuraBeams,
            cf = v21,
            originPart = Char.PrimaryPart
        },
        {
            obj = v15.Effects.BeeShot.SpeedBoost1,
            cf = v22,
            originPart = Char.PrimaryPart
        },
        {
            obj = v15.Effects.BeeShot.Leap,
            cf = v23,
            originPart = Char.PrimaryPart
        },
        {
            obj = v15.Effects.BeeShot.BeeSpawn,
            cf = v24,
            originPart = Char.PrimaryPart
        },
        {
            obj = v15.Effects.BeeShot.Shoot,
            cf = v25,
            originPart = Char.PrimaryPart
        }
    } do
        v.obj.Anchored = false;

        if i >= 3 then
            v.obj.Anchored = true;
            v.obj:PivotTo(v.originPart.CFrame:ToWorldSpace(v.cf));
        else
            v.obj.Anchored = false;
            local v26 = AbilityUtility:Weld(v.originPart, v.obj, v.originPart.CFrame:ToWorldSpace(v.cf));
            v26.Name = "WELD TEST";
            v26:SetAttribute("GeniusKilling", true);
            Debris:AddItem(v26, 7);
        end;
    end;

    AbilityUtility:AllVFX(v15.Effects.BeeShot, false);
end;