  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("ServerScriptService");
local Players = game:GetService("Players");
local RunService = game:GetService("RunService");
local TweenService = game:GetService("TweenService");
game:GetService("RunService");
game:GetService("TweenService");
game:GetService("Debris");
local GuiService = game:GetService("GuiService");
local ReplicatedStorage2 = game:GetService("ReplicatedStorage");
local UserInputService = game:GetService("UserInputService");
require(ReplicatedStorage.Shared.Essentials);
local Trove = require(ReplicatedStorage.Shared.Trove);
require(ReplicatedStorage.Shared.SoundManager);
local Popup = require(ReplicatedStorage.Shared.Popup);
require(ReplicatedStorage.Shared.VfxManager);
require(ReplicatedStorage2.Shared.AbilityCleanupTrove);
local u1 = false;
local Mobile = Players.LocalPlayer.PlayerGui:WaitForChild("Mobile");

local function changeDirection(p2) -- Line: 27
    -- upvalues: u1 (ref), ReplicatedStorage (copy)
    if u1 then
        ReplicatedStorage.SetYukiDirection:FireServer(p2);
    end;
end;

local function flat(p3: vector) -- Line: 33
    return Vector3.new(p3.X, 0, p3.Z);
end;

local function StreetDribbling(u4, u5, u6) -- Line: 37
    -- upvalues: u1 (ref), GuiService (copy), Mobile (copy), UserInputService (copy), Popup (copy), Trove (copy), RunService (copy)
    if u5.Character.Values.HasBall.Value == false then
        return;
    end;

    if u4.StatesController.States.Ability then
        return;
    end;

    if u4.SB then
        return;
    end;

    if u4.AbilityOne > tick() then
        return;
    end;

    local JumpHeight = u6.Humanoid.JumpHeight;
    u6.Humanoid.JumpPower = 0;
    u6.Humanoid.JumpHeight = 0;
    local State = u6.Humanoid:GetState();

    if State == Enum.HumanoidStateType.Freefall or State == Enum.HumanoidStateType.Jumping then
        u6.Humanoid.JumpHeight = JumpHeight;

        return;
    end;

    require(script.Cutscene)(u4, u5, u6);
    local LookVector = workspace.CurrentCamera.CFrame.LookVector;
    task.wait(7);
    u6.Humanoid.JumpHeight = JumpHeight;
    u1 = true;
    u4.AbilityService.Ability:Fire("StreetDribbling", LookVector);
    u4.Animations.Abilities.YukiSBStart.Looped = false;
    u4.Animations.Abilities.YukiSBStart:Play();
    u4.Animations.Abilities.YukiSBStart.Priority = Enum.AnimationPriority.Action4;
    u4:AbilityCooldown("1", 40);
    GuiService.TouchControlsEnabled = false;
    local Shiftlock = u4.Camera.Shiftlock;
    u4.Camera:SetShiftlock(false);
    print("enable mobile gui", Mobile);
    Mobile:SetAttribute("ForceEnable", true);
    Mobile.YukiAbilityControls.Visible = true;

    if UserInputService.TouchEnabled then
        Popup.Popup(u5, "Press LEFT/RIGHT to CONTROL!");
    elseif game:GetService("UserInputService").GamepadEnabled then
        Popup.Popup(u5, "Move LEFT/RIGHT to CONTROL!");
    else
        Popup.Popup(u5, "Press A/D to CONTROL!");
    end;

    u4.SB = Trove.new();
    u4.SB:Add(function() -- Line: 88
        -- upvalues: u4 (copy), GuiService (ref), Mobile (ref), u6 (copy), JumpHeight (copy), u1 (ref)
        u4.SB = nil;
        GuiService.TouchControlsEnabled = true;
        Mobile.YukiAbilityControls.Visible = false;
        u6.Humanoid.JumpPower = 50;
        u6.Humanoid.JumpHeight = JumpHeight;
        u1 = false;
        Mobile:SetAttribute("ForceEnable", nil);
    end);
    u4.StatesController.States.Ability = true;
    u4.SB:Add(u4.AbilityService.Ability:Connect(function(p7: table) -- Line: 99
        -- upvalues: u5 (copy), RunService (ref), u4 (copy), Shiftlock (copy)
        local AlignPosition = u5.Character:FindFirstChild("AlignPosition");
        local HumanoidRootPart = u5.Character:FindFirstChild("HumanoidRootPart");
        RunService:UnbindFromRenderStep("ShowMobile");
        AlignPosition.MaxVelocity = 80;
        AlignPosition.Enabled = true;
        local BodyGyro = Instance.new("BodyGyro");
        BodyGyro.MaxTorque = Vector3.new(1000000000, 1000000000, 1000000000);
        BodyGyro.D = 600;
        BodyGyro.P = 5000;
        BodyGyro.Parent = HumanoidRootPart;
        u4.SB:Add(BodyGyro);
        u4.SB:Add(function() -- Line: 116
            -- upvalues: AlignPosition (copy), u4 (ref)
            print("Setting false");
            AlignPosition.Enabled = false;
            u4.StatesController.States.Ability = false;
        end);

        for _, v in p7 do
            local math_random_ret = math.random(1, 4);
            u4.Animations:StopAnims();
            u4.Animations.Abilities.KingsRun.Priority = Enum.AnimationPriority.Action2;
            u4.Animations.Abilities.KingsRun:Play();
            u4.Animations.Abilities[`YukiDribble{math_random_ret}`].Priority = Enum.AnimationPriority.Action3;
            u4.Animations.Abilities[`YukiDribble{math_random_ret}`]:Play();
            u4.Animations.Ball[`YukiDribble{math_random_ret}`]:Play();
            local pos = v.pos;
            AlignPosition.Position = Vector3.new(pos.X, 0, pos.Z) + Vector3.new(0, 8.186 + HumanoidRootPart.Size.Y / 2 + 2.25, 0);
            local CFrame_lookAt = CFrame.lookAt;
            local Position = HumanoidRootPart.Position;
            local Vector3_new_ret = Vector3.new(Position.X, 0, Position.Z);
            local pos2 = v.pos;
            BodyGyro.CFrame = CFrame_lookAt(Vector3_new_ret, (Vector3.new(pos2.X, 0, pos2.Z))).Rotation;
            local v8 = v;

            while true do
                local v9 = HumanoidRootPart.Position - v8.pos;

                if Vector3.new(v9.X, 0, v9.Z).Magnitude <= 5.5 then
                    break;
                end;

                local pos3 = v8.pos;
                AlignPosition.Position = Vector3.new(pos3.X, 0, pos3.Z) + Vector3.new(0, 8.186 + HumanoidRootPart.Size.Y / 2 + 2.25, 0);
                task.wait();
            end;
        end;

        u4.Camera:SetShiftlock(Shiftlock);

        if u4.SB then
            u4.Animations.Abilities.KingsRun:Stop();
            u4.SB:Destroy();
        end;
    end));
    local SB = u4.SB;
    u4.SB:Add(task.delay(10, function() -- Line: 157
        -- upvalues: u4 (copy)
        print("clean");
        u4.StatesController.States.Ability = false;
        u4.SB:Destroy();
    end));
    task.delay(15, function() -- Line: 163
        -- upvalues: u4 (copy), SB (copy)
        if u4.SB == SB then
            u4.Animations.Abilities.KingsRun:Stop();
            u4.SB:Destroy();
        end;
    end);
end;

UserInputService.InputBegan:Connect(function(p10) -- Line: 172
    -- upvalues: u1 (ref), ReplicatedStorage (copy)
    if p10.KeyCode == Enum.KeyCode.A then
        if u1 then
            ReplicatedStorage.SetYukiDirection:FireServer("A");
        end;
    elseif p10.KeyCode == Enum.KeyCode.D and u1 then
        ReplicatedStorage.SetYukiDirection:FireServer("D");
    end;
end);
UserInputService.InputChanged:Connect(function(p11) -- Line: 180
    -- upvalues: u1 (ref), ReplicatedStorage (copy)
    if p11.KeyCode == Enum.KeyCode.Thumbstick1 then
        local X = p11.Position.X;

        if X < -0.1 then
            if u1 then
                ReplicatedStorage.SetYukiDirection:FireServer("A");
            end;
        elseif X > 0.1 and u1 then
            ReplicatedStorage.SetYukiDirection:FireServer("D");
        end;
    end;
end);
Mobile.YukiAbilityControls.Left.Activated:Connect(function() -- Line: 191
    -- upvalues: u1 (ref), ReplicatedStorage (copy)
    print("left pressed");

    if u1 then
        ReplicatedStorage.SetYukiDirection:FireServer("A");
    end;
end);
Mobile.YukiAbilityControls.Right.Activated:Connect(function() -- Line: 196
    -- upvalues: u1 (ref), ReplicatedStorage (copy)
    print("right pressed");

    if u1 then
        ReplicatedStorage.SetYukiDirection:FireServer("D");
    end;
end);
ReplicatedStorage:WaitForChild("SetYukiLine").OnClientEvent:Connect(function(p12, p13) -- Line: 218
    -- upvalues: TweenService (copy)
    if p12 == "fade" then
        workspace:GetServerTimeNow();
        local v14 = 0;

        for _, v in p13 do
            local part = v.part;
            local _ = v.start;
            local Z = part.Size.Z;
            local v15 = v14 / 60;
            v14 = v14 + Z;
            local v16 = TweenService:Create(part, TweenInfo.new(Z / 60, Enum.EasingStyle.Linear, Enum.EasingDirection.Out, 0, false, v15), {
                Size = Vector3.new(part.Size.X, part.Size.Y, 0),
                CFrame = part:GetAttribute("cf") * CFrame.new(0, 0, -Z)
            });
            v16:Play();
            v16.Completed:Connect(function() -- Line: 241
                -- upvalues: part (copy)
                part:Destroy();
            end);
        end;

        return;
    end;

    local Attribute = p12:GetAttribute("cf");

    if p12.Name == "setup" then
        TweenService:Create(p12, TweenInfo.new(0.15), {
            Size = Vector3.new(1.6, 0.1, p13),
            CFrame = Attribute * CFrame.new(0, 0, -p13 / 2)
        }):Play();

        return;
    end;

    p12.Name = "setup";
    p12.Size = Vector3.new(1.6, 0.1, p13);
    p12.CFrame = Attribute * CFrame.new(0, 0, -p13 / 2);
end);

return StreetDribbling;