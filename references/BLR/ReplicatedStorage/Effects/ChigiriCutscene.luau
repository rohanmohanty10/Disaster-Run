  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
game:GetService("Debris");
local RunService = game:GetService("RunService");
local Essentials = require(ReplicatedStorage.Shared.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.VfxManager);
local SoundManager = require(ReplicatedStorage.Shared.SoundManager);
local Popup = require(ReplicatedStorage.Shared.Popup);
local script_Fov = require(script.Fov);

return function(p1) -- Line: 12
    -- upvalues: SoundManager (copy), Popup (copy), RunService (copy), script_Fov (copy), Essentials (copy), VfxManager (copy)
    local Char = p1.Char;
    local HumanoidRootPart = Char:FindFirstChild("HumanoidRootPart");
    SoundManager.SpawnSound("AwakeningSFXChigiri", 0.6, workspace, 150);
    Popup.Subtitle(game.Players.LocalPlayer, "I don\'t care if this is my last play.");
    task.delay(3, function() -- Line: 18
        -- upvalues: Popup (ref)
        Popup.Subtitle(game.Players.LocalPlayer, "Are you ready, right leg?");
    end);
    task.delay(7, function() -- Line: 22
        -- upvalues: Popup (ref)
        Popup.Subtitle(game.Players.LocalPlayer, "The best striker in the world... is me!");
    end);
    local u2 = 0;
    local u3 = nil;
    local workspace_CurrentCamera = workspace.CurrentCamera;
    local FieldOfView = workspace_CurrentCamera.FieldOfView;
    u3 = RunService.RenderStepped:Connect(function(p4) -- Line: 30
        -- upvalues: u2 (ref), script_Fov (ref), u3 (ref), workspace_CurrentCamera (copy), FieldOfView (ref), Essentials (ref)
        u2 = u2 + p4 * 60;
        local v5 = script_Fov[math.ceil(u2)];

        if v5 ~= nil then
            if math.ceil(u2) >= #script_Fov then
                u3:Disconnect();

                return;
            end;

            workspace_CurrentCamera.FieldOfView = FieldOfView;
            FieldOfView = Essentials:Lerp(FieldOfView, v5, p4 * 10);
        end;
    end);
    local u6 = script.vfx.HumanoidRootPart.Beams:Clone();
    u6.Parent = HumanoidRootPart;
    local u7 = script.vfx["Right Leg"].Beams:Clone();
    u7.Parent = Char:FindFirstChild("Right Leg");
    local u8 = script.vfx.Head.eyeStuff:Clone();
    u8.Parent = Char:FindFirstChild("Head");
    local u9 = script.chains_Beams:Clone();
    u9.Parent = HumanoidRootPart;

    for _, descendant in u9:GetDescendants() do
        if descendant:IsA("Beam") then
            local Name = descendant.Attachment1.Name;
            descendant.Attachment0 = Char:FindFirstChild(descendant.Attachment0.Name, true);
            descendant.Attachment1 = Char:FindFirstChild(Name, true);
        end;
    end;

    local u10 = script.vfx["Right Leg"].LegThing:Clone();
    u10.Parent = workspace.Debris;
    u10.CFrame = Char:FindFirstChild("Right Leg").CFrame * CFrame.new(0, -0.9, 0);
    Essentials:Weld(Char:FindFirstChild("Right Leg"), u10);
    local AwakeningCam = workspace:FindFirstChild("AwakeningCam");
    local u11 = script.Cam11:Clone();
    u11.Parent = workspace.Debris;
    u11.CFrame = AwakeningCam.camera.CFrame * CFrame.new(0, 0, -3.33);
    Essentials:Weld(AwakeningCam.camera, u11);
    local u12 = script.Cam12:Clone();
    u12.Parent = workspace.Debris;
    u12.CFrame = AwakeningCam.camera.CFrame * CFrame.new(-1.27, 0, -2);
    Essentials:Weld(AwakeningCam.camera, u12);
    local u13 = script.Cam13:Clone();
    u13.Parent = workspace.Debris;
    u13.CFrame = AwakeningCam.camera.CFrame * CFrame.new(1.23, 0, -1.75);
    Essentials:Weld(AwakeningCam.camera, u13);

    local function DisableLeg() -- Line: 87
        -- upvalues: VfxManager (ref), u6 (copy), u9 (copy), u10 (copy)
        VfxManager.Enable(u6, false);

        for _, child in u9.leg:GetChildren() do
            if child:IsA("Beam") then
                child.Enabled = false;
            end;
        end;

        VfxManager.Enable(u10, false);
    end;

    local function EnableLeg() -- Line: 98
        -- upvalues: VfxManager (ref), u6 (copy), u9 (copy), u10 (copy)
        VfxManager.Enable(u6, true);

        for _, child in u9.leg:GetChildren() do
            if child:IsA("Beam") then
                child.Enabled = true;
            end;
        end;

        VfxManager.Enable(u10, true);
    end;

    task.delay(0.283, function() -- Line: 109
        -- upvalues: VfxManager (ref), u7 (copy), u12 (copy), u13 (copy), EnableLeg (copy)
        VfxManager.Emit(u7["1"]);
        VfxManager.Emit(u7.Extras);
        VfxManager.Enable(u12, true);
        VfxManager.Enable(u13, true);
        EnableLeg();
    end);
    task.delay(3.133, function() -- Line: 119
        -- upvalues: VfxManager (ref), u13 (copy), u12 (copy)
        VfxManager.Enable(u13, false);
        VfxManager.Enable(u12, false);
    end);
    task.delay(4.95, function() -- Line: 124
        -- upvalues: VfxManager (ref), u7 (copy), DisableLeg (copy), u8 (copy)
        VfxManager.Emit(u7["3"]);
        VfxManager.Emit(u7["4"]);
        VfxManager.Emit(u7["6"]);
        DisableLeg();
        VfxManager.Enable(u8, true);
    end);
    task.delay(5.65, function() -- Line: 134
        -- upvalues: EnableLeg (copy)
        EnableLeg();
    end);
    task.delay(5.8, function() -- Line: 138
        -- upvalues: DisableLeg (copy), VfxManager (ref), u7 (copy)
        DisableLeg();
        VfxManager.Emit(u7["3"]);
        VfxManager.Emit(u7["7"]);
        VfxManager.Emit(u7["8"]);
    end);
    task.delay(6.167, function() -- Line: 145
        -- upvalues: VfxManager (ref), u11 (copy), EnableLeg (copy)
        VfxManager.Enable(u11, true);
        EnableLeg();
    end);
    task.delay(6.3, function() -- Line: 150
        -- upvalues: DisableLeg (copy), VfxManager (ref), u7 (copy)
        DisableLeg();
        VfxManager.Emit(u7["3"]);
        VfxManager.Emit(u7["9"]);
        VfxManager.Emit(u7["10"]);
    end);
    task.delay(8.36, function() -- Line: 158
        -- upvalues: VfxManager (ref), u11 (copy)
        VfxManager.Enable(u11, false);
    end);
    task.delay(11, function() -- Line: 162
        -- upvalues: u10 (copy), u7 (copy), u6 (copy), u9 (copy), u11 (copy), u13 (copy), u12 (copy), u8 (copy), VfxManager (ref)
        u10:Destroy();
        u7:Destroy();
        u6:Destroy();
        u9:Destroy();
        u11:Destroy();
        u13:Destroy();
        u12:Destroy();
        task.wait(5);

        if u8 then
            VfxManager.Enable(u8, false);
            task.wait(1);
            u8:Destroy();
        end;
    end);
end;