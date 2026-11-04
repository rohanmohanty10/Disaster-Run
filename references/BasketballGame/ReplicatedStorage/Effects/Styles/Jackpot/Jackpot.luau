 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
local RunService = game:GetService("RunService");
game:GetService("Debris");
local Essentials = require(ReplicatedStorage.Shared.Utility.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.Utility.VfxManager);
require(ReplicatedStorage.Controllers.LightingController);
local script_Fov = require(script.Fov);
local SfxManager = require(ReplicatedStorage.Shared.Utility.SfxManager);
local Effects = require(ReplicatedStorage.Shared.Utility.Effects);
require(ReplicatedStorage.Effects.Base.Zone);
local _ = game.Players.LocalPlayer;
local Debris = workspace:FindFirstChild("Debris");

local function Destroy_Effect(u1: userdata, p2: number) -- Line: 17
    task.delay(p2, function() -- Line: 18
        -- upvalues: u1 (copy)
        u1:Destroy();
    end);
end;

return function(u3, p4) -- Line: 23
    -- upvalues: Debris (copy), SfxManager (copy), Effects (copy), RunService (copy), script_Fov (copy), Essentials (copy), VfxManager (copy)
    local workspace_CurrentCamera = workspace.CurrentCamera;
    local Character = p4.Character;
    local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart", 0.5);
    Character:FindFirstChild("Head", 0.5);
    local Duration = p4.Duration;
    local CamRig = workspace:WaitForChild("CamRig", 5);
    local u5 = workspace:GetServerTimeNow() - p4.TimeSent;
    local u6 = game.Players:FindFirstChild(Character.Name) or game.Players:GetPlayerFromCharacter(Character);
    local v7 = Character.Name .. script.Parent.Name .. script.Name;

    if p4.Task ~= "Cutscene" then
        if p4.Task == "Cleanup" and Debris:FindFirstChild(v7) then
            Debris:FindFirstChild(v7):SetAttribute("Active", nil);
        end;

        return;
    end;

    local u8 = {};

    if Debris:FindFirstChild(v7) then
        Debris:FindFirstChild(v7):Destroy();
    end;

    local Folder = Instance.new("Folder");
    Folder.Name = v7;
    Folder.Parent = Debris;
    Folder:SetAttribute("Active", true);
    task.delay(Duration - u5, function() -- Line: 47
        -- upvalues: Folder (copy)
        if Folder ~= nil then
            Folder:SetAttribute("Active", nil);
        end;
    end);
    local u9 = SfxManager:playSound({
        Sound = "BBZ Gambler Lady Luck Cutscene WIN",
        Parent = workspace
    });
    task.delay(0.2, function() -- Line: 55
        -- upvalues: Effects (ref), u6 (copy)
        Effects:SubtitleV2({
            { u6, "Hey... wait!", 1.3 },
            { u6, "See <font color=\"#daa520\">this</font>?", 1.6 }
        });
    end);
    task.delay(13.45, function() -- Line: 70
        -- upvalues: Effects (ref), u6 (copy)
        Effects:SubtitleV2({
            { u6, "Lady Luck is smiling on me!", 2.65 }
        });
    end);
    local u10 = 0;
    local u11 = nil;
    local FieldOfView = workspace_CurrentCamera.FieldOfView;
    u11 = RunService.RenderStepped:Connect(function(p12) -- Line: 83
        -- upvalues: u3 (copy), u11 (ref), u10 (ref), u5 (copy), script_Fov (ref), workspace_CurrentCamera (copy), FieldOfView (ref)
        if u3.MovementController.States.Ability == false then
            u11:Disconnect();

            return;
        end;

        if u10 <= 0 then
            u10 = p12 * 60 * u5;
        end;

        u10 = u10 + p12 * 60;
        local v13 = script_Fov[math.ceil(u10)];

        if v13 ~= nil then
            if math.ceil(u10) >= #script_Fov then
                u11:Disconnect();

                return;
            end;

            workspace_CurrentCamera.FieldOfView = FieldOfView;
            FieldOfView = v13;
        end;
    end);
    task.delay(Duration - u5, function() -- Line: 102
        -- upvalues: u11 (ref)
        if u11 then
            u11:Disconnect();
        end;
    end);
    local u14 = script.Camera_VFX:Clone();
    u14:PivotTo(CamRig:FindFirstChild("camera").CFrame);
    u14.Parent = Folder;
    u14.CamLines["2"].CFrame = CamRig.camera.CFrame * CFrame.new(0.10945186018943787, -0.32741785049438477, -1.1138774156570435) * CFrame.fromEulerAnglesYXZ(-0.13888710737228394, -3.1398587226867676, -1.7416666746139526);
    u14.CamLines.slantedTop.CFrame = CamRig.camera.CFrame * CFrame.new(-0.2111532837152481, 0.31443095207214355, -1.1145930290222168) * CFrame.fromEulerAnglesYXZ(-0.1388872265815735, -3.1398589611053467, -1.7416667938232422);
    u14.PrimaryPart.CFrame = CamRig.camera.CFrame;
    Essentials:Weld(CamRig.camera, u14.PrimaryPart);
    Essentials:Weld(CamRig.camera, u14.CamLines["2"]);
    Essentials:Weld(CamRig.camera, u14.CamLines.slantedTop);
    local u15 = script.CutsceneVFX:Clone();
    u15:PivotTo(HumanoidRootPart.CFrame);
    u15.Parent = Folder;
    VfxManager.Enable(u15.AuraBACKGROUND, true);
    VfxManager.Enable(u14.camera, true);
    task.delay(4.95 - u5, function() -- Line: 123
        -- upvalues: Folder (copy), VfxManager (ref), u15 (copy)
        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Emit(u15.Release);
    end);
    task.delay(6.783333333333333 - u5, function() -- Line: 130
        -- upvalues: Folder (copy), VfxManager (ref), u15 (copy)
        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Emit(u15.SpawnEffect);
        task.wait(0.06666666666666667);

        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Enable(u15.SlotAura, true);
    end);
    task.delay(8.2 - u5, function() -- Line: 143
        -- upvalues: Folder (copy), VfxManager (ref), u15 (copy)
        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Emit(u15.SpinHits.A);
    end);
    task.delay(8.45 - u5, function() -- Line: 149
        -- upvalues: Folder (copy), VfxManager (ref), u15 (copy)
        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Emit(u15.SpinHits.B);
    end);
    task.delay(12.3 - u5, function() -- Line: 155
        -- upvalues: Folder (copy), VfxManager (ref), u15 (copy)
        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Emit(u15.SpinHits.C);
        task.wait(0.016666666666666666);

        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Enable(u15.BackgroundMoney, true);
    end);
    task.delay(14.066666666666666 - u5, function() -- Line: 168
        -- upvalues: Folder (copy), VfxManager (ref), u15 (copy)
        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Enable(u15.FinalAura, true);
    end);
    task.delay(14.55 - u5, function() -- Line: 175
        -- upvalues: Folder (copy), VfxManager (ref), u14 (copy), Debris (ref), Character (copy), Essentials (ref)
        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Enable(u14.camera, false);
        VfxManager.Enable(u14.CamLines, true);
        local u16 = script.Aura:Clone();
        u16.Parent = Debris;

        for _, child in u16:GetChildren() do
            local v17 = Character[child.Name];

            if v17 then
                child.CFrame = v17.CFrame;
                Essentials:Weld(child, v17);
                VfxManager.Enable(child, true);
            end;
        end;

        task.delay(30, function() -- Line: 194
            -- upvalues: u16 (copy), VfxManager (ref)
            if u16 then
                VfxManager.Enable(u16, false);
                VfxManager.DestroyEffect(u16, 3);
            end;
        end);
    end);

    local function v18() -- Line: 202
        -- upvalues: u8 (copy), Folder (copy), VfxManager (ref), u9 (copy)
        for _, v in u8 do
            v:Disconnect();
        end;

        if Folder then
            Folder.Name = "_";
            VfxManager.Enable(Folder, false);
            VfxManager.DestroyEffect(Folder, 2);
        end;

        if u9 then
            VfxManager.DestroyEffect(u9, 2);
        end;
    end;

    table.insert(u8, Folder.AttributeChanged:Connect(v18));
    table.insert(u8, Folder.Destroying:Connect(v18));
end;