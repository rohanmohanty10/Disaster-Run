 
 

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
    local Head = Character:FindFirstChild("Head", 0.5);
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
    task.delay(Duration - u5, function() -- Line: 48
        -- upvalues: Folder (copy)
        if Folder ~= nil then
            Folder:SetAttribute("Active", nil);
        end;
    end);
    local u9 = SfxManager:playSound({
        Sound = "BBZ GamblerLadyLuckCutscene FAIL v2",
        Parent = workspace
    });
    task.delay(0.2, function() -- Line: 55
        -- upvalues: Effects (ref), u6 (copy)
        Effects:SubtitleV2({
            { u6, "Hey... wait!", 1.3 },
            { u6, "See <font color=\"#daa520\">this</font>?", 1.6 }
        });
    end);
    task.delay(12.8 - u5, function() -- Line: 70
        -- upvalues: Effects (ref), u6 (copy)
        Effects:SubtitleV2({
            { u6, "No way!", 1.2 },
            { u6, "Lady..<animation style=\"appear\" timeBetweenStep=\"1\">.</animation> Luck...", 2.2 }
        });
    end);
    local u10 = 0;
    local u11 = nil;
    local FieldOfView = workspace_CurrentCamera.FieldOfView;
    u11 = RunService.RenderStepped:Connect(function(p12) -- Line: 88
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
    task.delay(Duration - u5, function() -- Line: 107
        -- upvalues: u11 (ref)
        if u11 then
            u11:Disconnect();
        end;
    end);
    local u14 = script.Camera_VFX:Clone();
    u14:PivotTo(CamRig:FindFirstChild("camera").CFrame);
    u14.Parent = Folder;
    u14.PrimaryPart.CFrame = CamRig.camera.CFrame;
    Essentials:Weld(CamRig.camera, u14.PrimaryPart);
    local u15 = script.Head:Clone();
    u15.CFrame = Head.CFrame;
    u15.Parent = Folder;
    Essentials:Weld(u15, Head);
    local u16 = script.CutsceneVFX:Clone();
    u16:PivotTo(HumanoidRootPart.CFrame);
    u16.Parent = Folder;
    VfxManager.Enable(u16.AuraBACKGROUND, true);
    VfxManager.Enable(u14.camera, true);
    task.delay(4.95 - u5, function() -- Line: 128
        -- upvalues: Folder (copy), VfxManager (ref), u16 (copy)
        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Emit(u16.Release);
    end);
    task.delay(6.8 - u5, function() -- Line: 134
        -- upvalues: Folder (copy), VfxManager (ref), u16 (copy)
        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Emit(u16.SpawnEffect);
        task.wait(0.16666666666666666);

        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Enable(u16.SlotAura, true);
    end);
    task.delay(8.2 - u5, function() -- Line: 147
        -- upvalues: Folder (copy), VfxManager (ref), u16 (copy)
        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Emit(u16.SpinHits.A);
    end);
    task.delay(8.45 - u5, function() -- Line: 153
        -- upvalues: Folder (copy), VfxManager (ref), u16 (copy)
        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Emit(u16.SpinHits.B);
    end);
    task.delay(12.433333333333334 - u5, function() -- Line: 159
        -- upvalues: Folder (copy), VfxManager (ref), u14 (copy)
        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Enable(u14, false);
    end);
    task.delay(12.883333333333333 - u5, function() -- Line: 165
        -- upvalues: Folder (copy), VfxManager (ref), u16 (copy)
        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Enable(u16.AuraBACKGROUND, false);
    end);
    task.delay(13.8 - u5, function() -- Line: 171
        -- upvalues: Folder (copy), VfxManager (ref), u16 (copy), u15 (copy)
        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Emit(u16.Fall);
        VfxManager.Enable(u15, true);
    end);

    local function v17() -- Line: 178
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

    table.insert(u8, Folder.AttributeChanged:Connect(v17));
    table.insert(u8, Folder.Destroying:Connect(v17));
end;