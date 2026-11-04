 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
local RunService = game:GetService("RunService");
game:GetService("Debris");
local Essentials = require(ReplicatedStorage.Shared.Utility.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.Utility.VfxManager);
require(ReplicatedStorage.Controllers.LightingController);
local script_Fov = require(script.Fov);
local SfxManager = require(ReplicatedStorage.Shared.Utility.SfxManager);
local _ = game.Players.LocalPlayer;

return function(u1, p2) -- Line: 14
    -- upvalues: SfxManager (copy), RunService (copy), script_Fov (copy), Essentials (copy), VfxManager (copy)
    local workspace_CurrentCamera = workspace.CurrentCamera;
    local u3 = workspace:GetServerTimeNow() - p2.TimeSent;
    SfxManager:playSound({
        Sound = "ClutchBallAwaken",
        Duration = 7,
        Parent = workspace
    });
    local u4 = 0;
    local u5 = nil;
    local FieldOfView = workspace_CurrentCamera.FieldOfView;
    u5 = RunService.RenderStepped:Connect(function(p6) -- Line: 24
        -- upvalues: u1 (copy), u5 (ref), u4 (ref), u3 (copy), script_Fov (ref), workspace_CurrentCamera (copy), FieldOfView (ref), Essentials (ref)
        if u1.MovementController.States.Ability == false then
            u5:Disconnect();

            return;
        end;

        if u4 <= 0 then
            u4 = p6 * 60 * u3;
        end;

        u4 = u4 + p6 * 60;
        local v7 = script_Fov[math.ceil(u4)];

        if v7 ~= nil then
            if math.ceil(u4) >= #script_Fov then
                u5:Disconnect();

                return;
            end;

            workspace_CurrentCamera.FieldOfView = FieldOfView;
            FieldOfView = Essentials:Lerp(FieldOfView, v7, p6 * 6);
        end;
    end);
    task.delay(5.5 - u3, function() -- Line: 43
        -- upvalues: u5 (ref)
        u5:Disconnect();
    end);
    local Character = p2.Character;
    local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart");

    if not HumanoidRootPart then
        return;
    end;

    local script_Attachments = script.Attachments;
    local u8 = {};

    for _, child in script_Attachments:GetChildren() do
        local v9 = child:Clone();
        v9.Parent = HumanoidRootPart;
        task.delay(6, v9.Destroy, v9);
    end;

    for _, child in script.VFX:GetChildren() do
        if script_Attachments:FindFirstChild(child.Name) then
            local u10 = child:Clone();
            u10.Parent = workspace.Debris;
            u10.CFrame = HumanoidRootPart:FindFirstChild(u10.Name).WorldCFrame;
            u8[u10.Name] = u10;
            Essentials:Weld(u10, HumanoidRootPart);
            local Attribute = u10:GetAttribute("EmitDelay");

            if Attribute then
                task.delay(Attribute - u3, function() -- Line: 72
                    -- upvalues: VfxManager (ref), u10 (ref)
                    VfxManager.Emit(u10);
                end);
            else
                warn("no emit time");
            end;
        end;
    end;

    local script_Head = script.Head;
    local Head = Character:FindFirstChild("Head");

    for _, child in script_Head:GetChildren() do
        local u11 = child:Clone();
        u11.Parent = Head;
        local Name = u11.Name;

        if Name == "Eye_Emit" then
            task.delay(0.81 - u3, function() -- Line: 86
                -- upvalues: VfxManager (ref), u11 (ref)
                VfxManager.Emit(u11);
            end);
        elseif Name == "Eye_Enabled" then
            task.delay(0.81 - u3, function() -- Line: 90
                -- upvalues: VfxManager (ref), u11 (ref)
                VfxManager.Enable(u11, true);
            end);
            task.delay(1.5 - u3, function() -- Line: 93
                -- upvalues: VfxManager (ref), u11 (ref)
                VfxManager.Enable(u11, false);
            end);
        elseif Name == "Emit" then
            task.delay(5.05, function() -- Line: 97
                -- upvalues: VfxManager (ref), u11 (ref)
                VfxManager.Emit(u11);
            end);
        end;

        task.delay(6, u11.Destroy, u11);
    end;

    task.delay(6 - u3, function() -- Line: 104
        -- upvalues: u8 (copy)
        for _, v in u8 do
            v:Destroy();
        end;
    end);
end;