 
 

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
local RunService = game:GetService("RunService");
local Essentials = require(ReplicatedStorage.Shared.Utility.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.Utility.VfxManager);
local SfxManager = require(ReplicatedStorage.Shared.Utility.SfxManager);
local script_Fov = require(script.Fov);
local _ = Players.LocalPlayer;
local workspace_CurrentCamera = workspace.CurrentCamera;
local Debris = workspace:FindFirstChild("Debris");

return function(u1, p2) -- Line: 16
    -- upvalues: SfxManager (copy), workspace_CurrentCamera (copy), RunService (copy), script_Fov (copy), Essentials (copy), Debris (copy), VfxManager (copy)
    local u3 = workspace:GetServerTimeNow() - p2.TimeSent;
    local Folder = p2.Folder;
    local CamRig = workspace:WaitForChild("CamRig", 5);
    local v4 = script.Parent.Name .. script.Name;
    SfxManager:playSound({
        Sound = "BBZ MVP Cutscene Ace",
        Parent = workspace
    });
    local u5 = 0;
    local u6 = nil;
    local FieldOfView = workspace_CurrentCamera.FieldOfView;
    u6 = RunService.RenderStepped:Connect(function(p7) -- Line: 29
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
    task.delay(7.617 - u3, function() -- Line: 51
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
    task.delay(7.617 - u3, function() -- Line: 64
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
    task.spawn(function() -- Line: 79
        -- upvalues: Folder2 (copy), VfxManager (ref), u9 (copy)
        if not (Folder2 and Folder2:GetAttribute("Active")) then
            return;
        end;

        VfxManager.BetterEmit(u9.Confetti);
    end);
    task.delay(2.45 - u3, function() -- Line: 85
        -- upvalues: Folder2 (copy), VfxManager (ref), u10 (copy)
        if not (Folder2 and Folder2:GetAttribute("Active")) then
            return;
        end;

        VfxManager.BetterEmit(u10.CamVFX.Intensity2);
    end);
    task.delay(3.2666666666666666 - u3, function() -- Line: 91
        -- upvalues: Folder2 (copy), VfxManager (ref), u9 (copy)
        if not (Folder2 and Folder2:GetAttribute("Active")) then
            return;
        end;

        VfxManager.BetterEmit(u9.Land);
    end);
    task.delay(4.366666666666666 - u3, function() -- Line: 97
        -- upvalues: Folder2 (copy), VfxManager (ref), u9 (copy)
        if not (Folder2 and Folder2:GetAttribute("Active")) then
            return;
        end;

        VfxManager.BetterEmit(u9.Ah);
    end);
    local u11 = {};

    local function v12() -- Line: 104
        -- upvalues: u11 (ref), Folder2 (copy)
        for _, v in pairs(u11) do
            v:Disconnect();
        end;

        if Folder2 then
            Folder2:Destroy();
        end;

        u11 = nil;
    end;

    table.insert(u11, Folder2.AttributeChanged:Connect(v12));
    table.insert(u11, Folder2.Destroying:Connect(v12));
end;