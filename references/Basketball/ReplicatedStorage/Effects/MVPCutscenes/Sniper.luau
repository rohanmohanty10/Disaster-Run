 
 

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local RunService = game:GetService("RunService");
local Lighting = game:GetService("Lighting");
local Essentials = require(ReplicatedStorage.Shared.Utility.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.Utility.VfxManager);
local SfxManager = require(ReplicatedStorage.Shared.Utility.SfxManager);
local script_Fov = require(script.Fov);
local _ = Players.LocalPlayer;
local workspace_CurrentCamera = workspace.CurrentCamera;
local Debris = workspace:FindFirstChild("Debris");

return function(u1, p2) -- Line: 17
    -- upvalues: SfxManager (copy), workspace_CurrentCamera (copy), RunService (copy), script_Fov (copy), Essentials (copy), Debris (copy), Lighting (copy), VfxManager (copy), TweenService (copy)
    local u3 = workspace:GetServerTimeNow() - p2.TimeSent;
    local Folder = p2.Folder;
    local CamRig = workspace:WaitForChild("CamRig", 5);
    local v4 = script.Parent.Name .. script.Name;
    SfxManager:playSound({
        Sound = "BBZ MVP Cutscene Sniper",
        Parent = workspace
    });
    local u5 = 0;
    local u6 = nil;
    local FieldOfView = workspace_CurrentCamera.FieldOfView;
    u6 = RunService.RenderStepped:Connect(function(p7) -- Line: 30
        -- upvalues: u1 (copy), u6 (ref), u5 (ref), u3 (copy), script_Fov (ref), workspace_CurrentCamera (ref), FieldOfView (ref), Essentials (ref)
        if not u1.MovementController.States.Ability then
            u6:Disconnect();

            return;
        end;

        if u5 <= 0 then
            u5 = p7 * 60 * u3;
        end;

        u5 = u5 + p7 * 60;
        local v8 = script_Fov[math.ceil(u5)];

        if v8 ~= nil then
            if math.ceil(u5) >= #script_Fov then
                u6:Disconnect();

                return;
            end;

            workspace_CurrentCamera.FieldOfView = FieldOfView;
            FieldOfView = Essentials:Lerp(FieldOfView, v8, p7 * 6);
        end;
    end);
    task.delay(7.9 - u3, function() -- Line: 52
        -- upvalues: u6 (ref)
        u6:Disconnect();
    end);

    if Debris:FindFirstChild(v4) then
        Debris:FindFirstChild(v4):Destroy();
    end;

    local Folder2 = Instance.new("Folder");
    Folder2.Name = v4;
    Folder2.Parent = Debris;
    Folder2:SetAttribute("Active", true);
    task.delay(7.9 - u3, function() -- Line: 65
        -- upvalues: Folder2 (copy)
        if not (Folder2 and Folder2:GetAttribute("Active")) then
            return;
        end;

        Folder2:SetAttribute("Active", nil);
    end);
    local u9 = script.Cutscene_VFX:Clone();
    u9.Parent = Folder2;
    u9:PivotTo(Folder.Player1:FindFirstChild("HumanoidRootPart").CFrame);
    local u10 = script.Camera_VFX:Clone();
    u10:PivotTo(CamRig.camera.CFrame);
    u10.Parent = Folder2;
    Essentials:Weld(u10.camera, CamRig.camera);
    local Bloom = Lighting:FindFirstChild("Bloom");
    Bloom.Enabled = false;
    local u11 = Bloom:Clone();
    u11.Name = "B";
    u11.Parent = Lighting;
    u11.Enabled = true;
    task.delay(7.9, function() -- Line: 88
        -- upvalues: u11 (copy), Lighting (ref), Bloom (copy)
        u11:Destroy();

        if not Lighting:FindFirstChild("B") then
            Bloom.Enabled = true;
        end;
    end);
    task.spawn(function() -- Line: 95
        -- upvalues: Folder2 (copy), VfxManager (ref), u10 (copy)
        if not (Folder2 and Folder2:GetAttribute("Active")) then
            return;
        end;

        VfxManager.BetterEmit(u10.CamVFX.StartCamTrans);
    end);
    task.delay(0.35 - u3, function() -- Line: 101
        -- upvalues: Folder2 (copy), VfxManager (ref), u9 (copy)
        if not (Folder2 and Folder2:GetAttribute("Active")) then
            return;
        end;

        VfxManager.BetterEmit(u9.Confetti);
    end);
    task.delay(0.6666666666666666 - u3, function() -- Line: 107
        -- upvalues: Folder2 (copy), VfxManager (ref), u9 (copy)
        if not (Folder2 and Folder2:GetAttribute("Active")) then
            return;
        end;

        VfxManager.BetterEmit(u9.Land);
    end);
    task.delay(1.3333333333333333 - u3, function() -- Line: 113
        -- upvalues: Folder2 (copy), TweenService (ref), u11 (copy)
        if not (Folder2 and Folder2:GetAttribute("Active")) then
            return;
        end;

        TweenService:Create(u11, TweenInfo.new(0.25), {
            Intensity = 1,
            Threshold = 0.9
        }):Play();
    end);
    task.delay(1.5833333333333333 - u3, function() -- Line: 119
        -- upvalues: Folder2 (copy), TweenService (ref), u11 (copy), Bloom (copy)
        if not (Folder2 and Folder2:GetAttribute("Active")) then
            return;
        end;

        TweenService:Create(u11, TweenInfo.new(0.75), {
            Intensity = Bloom.Intensity,
            Threshold = Bloom.Threshold
        }):Play();
    end);
    task.delay(1.5833333333333333 - u3, function() -- Line: 125
        -- upvalues: Folder2 (copy), VfxManager (ref), u9 (copy)
        if not (Folder2 and Folder2:GetAttribute("Active")) then
            return;
        end;

        VfxManager.BetterEmit(u9.Ah);
    end);
    task.delay(5.433333333333334 - u3, function() -- Line: 131
        -- upvalues: Folder2 (copy), VfxManager (ref), u10 (copy)
        if not (Folder2 and Folder2:GetAttribute("Active")) then
            return;
        end;

        VfxManager.BetterEmit(u10.CamVFX.Intensity);
    end);
    task.delay(5.5 - u3, function() -- Line: 137
        -- upvalues: Folder2 (copy), VfxManager (ref), u9 (copy)
        if not (Folder2 and Folder2:GetAttribute("Active")) then
            return;
        end;

        VfxManager.BetterEmit(u9.Impact1);
    end);
    task.delay(6.116666666666666 - u3, function() -- Line: 143
        -- upvalues: Folder2 (copy), VfxManager (ref), u9 (copy)
        if not (Folder2 and Folder2:GetAttribute("Active")) then
            return;
        end;

        VfxManager.BetterEmit(u9.Impact2);
    end);
    local u12 = {};

    local function v13() -- Line: 150
        -- upvalues: u12 (ref), Folder2 (copy), u11 (copy), Lighting (ref), Bloom (copy)
        for _, v in pairs(u12) do
            v:Disconnect();
        end;

        if Folder2 then
            Folder2:Destroy();
        end;

        if u11 then
            u11:Destroy();

            if not Lighting:FindFirstChild("B") then
                Bloom.Enabled = true;
            end;
        end;

        u12 = nil;
    end;

    table.insert(u12, Folder2.AttributeChanged:Connect(v13));
    table.insert(u12, Folder2.Destroying:Connect(v13));
end;