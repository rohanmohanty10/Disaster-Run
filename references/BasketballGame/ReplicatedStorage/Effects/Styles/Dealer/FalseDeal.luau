 
 

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
game:GetService("RunService");
game:GetService("Lighting");
local Essentials = require(ReplicatedStorage.Shared.Utility.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.Utility.VfxManager);
local SfxManager = require(ReplicatedStorage.Shared.Utility.SfxManager);
require(ReplicatedStorage.Shared.Utility.Effects);
local _ = Players.LocalPlayer;
local _ = workspace.CurrentCamera;
local Debris = workspace:FindFirstChild("Debris");

return function(p1, p2) -- Line: 16
    -- upvalues: SfxManager (copy), Debris (copy), VfxManager (copy), Essentials (copy)
    local TimeSent = p2.TimeSent;
    local v3 = workspace:GetServerTimeNow() - TimeSent;
    local Character = p2.Character;
    local v4 = Character.Name .. script.Parent.Name .. script.Name;
    local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart");
    Character:FindFirstChild("Right Arm");
    Character:FindFirstChild("Left Arm");
    local BALL = Character:FindFirstChild("BALL", true);

    if p2.Task ~= "Dribble" then
        if p2.Task ~= "High Stakes" then
            if p2.Task ~= "Shoot" then
                local v5 = p2.Task == "Cleanup" and Debris:FindFirstChild(v4);

                if v5 then
                    v5:SetAttribute("Active", nil);
                end;

                return;
            end;

            SfxManager:playSound({
                Sound = "BBZ Dealer Shoot",
                Parent = HumanoidRootPart
            });
            local v6 = script.Shoot:Clone();
            v6.CFrame = CFrame.new(BALL.Position) * CFrame.fromOrientation(HumanoidRootPart.CFrame:ToOrientation()) * CFrame.Angles(-0.5235987755982988, 0, 0);
            v6.Parent = Debris;
            VfxManager.Emit(v6);
            VfxManager.DestroyEffect(v6, 4);

            return;
        end;

        SfxManager:playSound({
            Sound = "BBZ Dealer High Stakes",
            Parent = HumanoidRootPart
        });
        local u7 = script.Ball:Clone();
        u7.Parent = Debris;
        u7.CFrame = BALL.CFrame;
        Essentials:Weld(u7, BALL);
        local Model = Instance.new("Model");
        Model.Parent = Debris;

        for _, child in pairs(script.AuraBodyPartsToWeld:GetChildren()) do
            local v8 = Character:FindFirstChild(child.Name);

            if v8 then
                local v9 = child:Clone();
                v9.CFrame = v8.CFrame;
                v9.Parent = Model;
                Essentials:Weld(v9, v8);
            end;
        end;

        task.delay(1.35 / p2.Speed - v3, function() -- Line: 139
            -- upvalues: VfxManager (ref), u7 (copy), Model (copy)
            VfxManager.Enable(u7, false);
            VfxManager.Enable(Model, false);
            VfxManager.DestroyEffect(u7, 2);
            VfxManager.DestroyEffect(Model, 2);
        end);

        return;
    end;

    SfxManager:playSound({
        Sound = "BBZ Dealer False Deal",
        Parent = HumanoidRootPart
    });
    local Folder = Instance.new("Folder");
    Folder.Name = v4;
    Folder.Parent = Debris;
    Folder:SetAttribute("Active", true);
    task.delay(2.0166666666666666 - v3, function() -- Line: 37
        -- upvalues: Folder (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        Folder:SetAttribute("Active", nil);
    end);
    task.delay(0.15 - v3, function() -- Line: 43
        -- upvalues: Folder (copy), Debris (ref), BALL (copy), VfxManager (ref)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        local v10 = script.Bounce:Clone();
        v10.Parent = Debris;
        v10.CFrame = CFrame.new(BALL.Position.X, math.clamp(BALL.Position.Y - BALL.Size.Y / 2, 1.05, 1.5), BALL.Position.Z);
        VfxManager.Emit(v10);
        VfxManager.DestroyEffect(v10, 4);
    end);
    task.delay(0.38333333333333336 - v3, function() -- Line: 53
        -- upvalues: Folder (copy), Debris (ref), BALL (copy), VfxManager (ref)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        local v11 = script.Bounce:Clone();
        v11.Parent = Debris;
        v11.CFrame = CFrame.new(BALL.Position.X, math.clamp(BALL.Position.Y - BALL.Size.Y / 2, 1.05, 1.5), BALL.Position.Z);
        VfxManager.Emit(v11);
        VfxManager.DestroyEffect(v11, 4);
    end);
    task.delay(0.48333333333333334 - v3, function() -- Line: 63
        -- upvalues: Folder (copy), Debris (ref), BALL (copy), VfxManager (ref)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        local v12 = script.Bounce:Clone();
        v12.Parent = Debris;
        v12.CFrame = CFrame.new(BALL.Position.X, math.clamp(BALL.Position.Y - BALL.Size.Y / 2, 1.05, 1.5), BALL.Position.Z);
        VfxManager.Emit(v12);
        VfxManager.DestroyEffect(v12, 4);
    end);
    task.delay(0.65 - v3, function() -- Line: 73
        -- upvalues: Folder (copy), Debris (ref), BALL (copy), VfxManager (ref)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        local v13 = script.Bounce:Clone();
        v13.Parent = Debris;
        v13.CFrame = CFrame.new(BALL.Position.X, math.clamp(BALL.Position.Y - BALL.Size.Y / 2, 1.05, 1.5), BALL.Position.Z);
        VfxManager.Emit(v13);
        VfxManager.DestroyEffect(v13, 4);
    end);
    task.delay(0.8333333333333334 - v3, function() -- Line: 83
        -- upvalues: Folder (copy), Debris (ref), BALL (copy), VfxManager (ref)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        local v14 = script.Bounce:Clone();
        v14.Parent = Debris;
        v14.CFrame = CFrame.new(BALL.Position.X, math.clamp(BALL.Position.Y - BALL.Size.Y / 2, 1.05, 1.5), BALL.Position.Z);
        VfxManager.Emit(v14);
        VfxManager.DestroyEffect(v14, 4);
    end);
    task.delay(1.1666666666666667 - v3, function() -- Line: 93
        -- upvalues: Folder (copy), Debris (ref), BALL (copy), VfxManager (ref)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        local v15 = script.Bounce:Clone();
        v15.Parent = Debris;
        v15.CFrame = CFrame.new(BALL.Position.X, math.clamp(BALL.Position.Y - BALL.Size.Y / 2, 1.05, 1.5), BALL.Position.Z);
        VfxManager.Emit(v15);
        VfxManager.DestroyEffect(v15, 4);
    end);
    local u16 = {};

    local function v17() -- Line: 104
        -- upvalues: u16 (ref), Folder (copy)
        for _, v in pairs(u16) do
            v:Disconnect();
        end;

        if Folder then
            Folder:Destroy();
        end;

        u16 = nil;
    end;

    table.insert(u16, Folder.AttributeChanged:Connect(v17));
    table.insert(u16, Folder.Destroying:Connect(v17));
end;