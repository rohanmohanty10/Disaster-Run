 
 

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
game:GetService("RunService");
local Lighting = game:GetService("Lighting");
local Essentials = require(ReplicatedStorage.Shared.Utility.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.Utility.VfxManager);
local SfxManager = require(ReplicatedStorage.Shared.Utility.SfxManager);
require(ReplicatedStorage.Shared.Utility.Effects);
local LocalPlayer = Players.LocalPlayer;
local _ = workspace.CurrentCamera;
local Debris = workspace:FindFirstChild("Debris");

return function(p1, p2) -- Line: 16
    -- upvalues: SfxManager (copy), Debris (copy), Lighting (copy), TweenService (copy), VfxManager (copy), LocalPlayer (copy), Essentials (copy)
    local TimeSent = p2.TimeSent;
    local v3 = workspace:GetServerTimeNow() - TimeSent;
    local Character = p2.Character;
    local v4 = Character.Name .. script.Parent.Name .. script.Name;
    local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart");
    local BALL = Character:FindFirstChild("BALL", true);

    if p2.Task ~= "Dribble" then
        if p2.Task == "Stepback" then
            local Torso = Character:FindFirstChild("Torso");

            if not Torso then
                return;
            end;

            SfxManager:playSound({
                Sound = "BBZ LukaDoncic Stepback",
                Parent = HumanoidRootPart
            });
            local u5 = script.Ball:Clone();
            u5.Parent = Debris;
            u5.CFrame = BALL.CFrame;
            Essentials:Weld(u5, BALL);
            VfxManager.Enable(u5, true);
            local u6 = script.Torso:Clone();
            u6.Parent = Debris;
            u6.CFrame = Torso.CFrame;
            Essentials:Weld(u6, Torso);
            VfxManager.Enable(u6, true);
            task.spawn(function() -- Line: 137
                -- upvalues: Essentials (ref), Character (copy), VfxManager (ref)
                local v7 = tick();

                repeat
                    task.wait(0.1);
                    local v8 = Essentials:CreateClone(Character);
                    VfxManager.DestroyEffect(v8, 1);
                until tick() - v7 > 0.3;
            end);
            task.delay(0.3 - v3, function() -- Line: 145
                -- upvalues: VfxManager (ref), u5 (copy), u6 (copy), Debris (ref), HumanoidRootPart (copy)
                VfxManager.Enable(u5, false);
                VfxManager.Enable(u6, false);
                VfxManager.DestroyEffect(u5, 2);
                VfxManager.DestroyEffect(u6, 2);
                local v9 = script.Boom:Clone();
                v9.Parent = Debris;
                v9.CFrame = HumanoidRootPart.CFrame + Vector3.new(0, v9.Size.Y / 2 - 3, 0);
                VfxManager.Emit(v9);
                VfxManager.DestroyEffect(v9, 2);
            end);
            task.delay(1.15 - v3, function() -- Line: 158
                -- upvalues: Debris (ref), HumanoidRootPart (copy), VfxManager (ref)
                local v10 = script.Jump:Clone();
                v10.Parent = Debris;
                v10.CFrame = HumanoidRootPart.CFrame * CFrame.Angles(0.7853981633974483, 3.141592653589793, 3.141592653589793) + Vector3.new(0, -3, 0);
                VfxManager.Emit(v10);
                VfxManager.DestroyEffect(v10, 4);
            end);
            local v11 = Debris:FindFirstChild(v4);

            if v11 then
                v11:SetAttribute("Active", nil);

                return;
            end;
        else
            if p2.Task == "Floater" then
                SfxManager:playSound({
                    Sound = `BBZ LukaDoncic {p2.Number == 1 and "Far" or "Close"} Floater`,
                    Parent = HumanoidRootPart
                });

                return;
            end;

            if p2.Task == "Shoot" then
                SfxManager:playSound({
                    Sound = "BBZ LukaDoncic Shoot",
                    Parent = HumanoidRootPart
                });
                local v12 = script.Shoot:Clone();
                v12.CFrame = CFrame.new(BALL.Position) * CFrame.fromOrientation(HumanoidRootPart.CFrame:ToOrientation()) * CFrame.Angles(-1.0471975511965976, 3.141592653589793, 3.141592653589793);
                v12.Parent = Debris;
                VfxManager.Emit(v12);
                VfxManager.DestroyEffect(v12, 4);

                return;
            end;

            local v13 = p2.Task == "Cleanup" and Debris:FindFirstChild(v4);

            if v13 then
                v13:SetAttribute("Active", nil);
            end;
        end;

        return;
    end;

    SfxManager:playSound({
        Sound = "BBZ LukaDoncic Isolation",
        Parent = HumanoidRootPart
    });
    local Folder = Instance.new("Folder");
    Folder.Name = v4;
    Folder.Parent = Debris;
    Folder:SetAttribute("Active", true);
    task.delay(3 - v3, function() -- Line: 35
        -- upvalues: Folder (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        Folder:SetAttribute("Active", nil);
    end);
    local ColorCorrection = Lighting:FindFirstChild("ColorCorrection");
    ColorCorrection.Enabled = false;
    local u14 = ColorCorrection:Clone();
    u14.Name = "CC";
    u14.Parent = Lighting;
    u14.Enabled = true;
    task.spawn(function() -- Line: 49
        -- upvalues: Lighting (ref), TweenService (ref), VfxManager (ref), u14 (copy)
        local BlurEffect = Instance.new("BlurEffect", Lighting);
        BlurEffect.Size = 15;
        TweenService:Create(BlurEffect, TweenInfo.new(0.25, Enum.EasingStyle.Linear), {
            Size = 0
        }):Play();
        VfxManager.DestroyEffect(BlurEffect, 0.25);
        TweenService:Create(u14, TweenInfo.new(0.455, Enum.EasingStyle.Sine), {
            Brightness = -0.15,
            Saturation = -1
        }):Play();
    end);
    task.delay(0.18333333333333332 - v3, function() -- Line: 58
        -- upvalues: Folder (copy), Debris (ref), BALL (copy), VfxManager (ref)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        local v15 = script.Bounce:Clone();
        v15.Parent = Debris;
        v15.CFrame = CFrame.new(BALL.Position.X, math.clamp(BALL.Position.Y - BALL.Size.Y / 2, 1.05, 1.5), BALL.Position.Z);
        VfxManager.Emit(v15);
        VfxManager.DestroyEffect(v15, 2);
    end);
    task.delay(0.6833333333333333 - v3, function() -- Line: 68
        -- upvalues: Folder (copy), Debris (ref), BALL (copy), VfxManager (ref)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        local v16 = script.Bounce:Clone();
        v16.Parent = Debris;
        v16.CFrame = CFrame.new(BALL.Position.X, math.clamp(BALL.Position.Y - BALL.Size.Y / 2, 1.05, 1.5), BALL.Position.Z);
        VfxManager.Emit(v16);
        VfxManager.DestroyEffect(v16, 2);
    end);

    if LocalPlayer.Character ~= Character and LocalPlayer.Team ~= game.Teams.Visitor then
        workspace:SetAttribute("Isolation", true);
    end;

    local u17 = {};

    local function v18() -- Line: 83
        -- upvalues: u17 (ref), Folder (copy), u14 (copy), Lighting (ref), TweenService (ref), VfxManager (ref), ColorCorrection (copy), Essentials (ref), Character (copy)
        for _, v in pairs(u17) do
            v:Disconnect();
        end;

        if Folder then
            Folder:Destroy();
        end;

        if u14 then
            local BlurEffect = Instance.new("BlurEffect", Lighting);
            BlurEffect.Size = 15;
            TweenService:Create(BlurEffect, TweenInfo.new(0.25, Enum.EasingStyle.Sine), {
                Size = 0
            }):Play();
            VfxManager.DestroyEffect(BlurEffect, 0.25);
            u14.Brightness = 0.65;
            u14.TintColor = Color3.fromRGB(255, 180, 55);
            TweenService:Create(u14, TweenInfo.new(0.25, Enum.EasingStyle.Linear), {
                Brightness = ColorCorrection.Brightness,
                Saturation = ColorCorrection.Saturation,
                TintColor = ColorCorrection.TintColor
            }):Play();
            task.delay(0.25, function() -- Line: 102
                -- upvalues: u14 (ref), Lighting (ref), ColorCorrection (ref)
                u14:Destroy();

                if not Lighting:FindFirstChild("CC") then
                    ColorCorrection.Enabled = true;
                end;
            end);
        end;

        workspace:SetAttribute("Isolation", nil);
        Essentials:UnhideCharacter(Character, {});
        u17 = nil;
    end;

    table.insert(u17, Folder.AttributeChanged:Connect(v18));
    table.insert(u17, Folder.Destroying:Connect(v18));
end;