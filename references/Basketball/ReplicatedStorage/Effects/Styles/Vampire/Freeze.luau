 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
game:GetService("RunService");
game:GetService("Debris");
require(ReplicatedStorage.Shared.Utility.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.Utility.VfxManager);
require(ReplicatedStorage.Controllers.Network);
local SfxManager = require(ReplicatedStorage.Shared.Utility.SfxManager);
local _ = game.Players.LocalPlayer;
local Debris = workspace:FindFirstChild("Debris");

return function(p1, u2) -- Line: 14
    -- upvalues: ReplicatedStorage (copy), SfxManager (copy), Debris (copy), VfxManager (copy)
    local _ = u2.TimeSent;
    local Char = u2.Char;
    local HumanoidRootPart = Char:FindFirstChild("HumanoidRootPart");
    Char:FindFirstChild("Torso");
    local _ = ReplicatedStorage.Basketball.Value;
    Char:FindFirstChild("BALL", true);
    local _ = workspace:GetServerTimeNow() - u2.previousTime + u2.passedTime;

    if u2.Task == "Initial" then
        local Highlight = Instance.new("Highlight");
        Highlight.OutlineColor = Color3.fromRGB(88, 163, 255);
        Highlight.OutlineTransparency = 0;
        Highlight.FillColor = Color3.fromRGB(110, 166, 255);
        Highlight.FillTransparency = 0.75;
        Highlight.Parent = Char;
        task.delay(2, function() -- Line: 32
            -- upvalues: Highlight (copy)
            Highlight:Destroy();
        end);
    end;

    if u2.Task == "Activate" then
        SfxManager:playSound({
            Sound = "DioFreeze",
            Parent = HumanoidRootPart
        });
        task.delay(0.317, function() -- Line: 41
            -- upvalues: HumanoidRootPart (copy), Debris (ref), VfxManager (ref)
            if HumanoidRootPart then
                local v3 = script.grab:Clone();
                v3.CFrame = HumanoidRootPart.CFrame * CFrame.new(0.04608500003814697, -2.1382856369018555, -0.9281538724899292) * CFrame.fromEulerAnglesYXZ(-0, 3.1415927410125732, 0);
                v3.Parent = Debris;
                VfxManager.Emit(v3);
                VfxManager.DestroyEffect(v3, 3);
            end;
        end);
        task.delay(1.1, function() -- Line: 51
            -- upvalues: HumanoidRootPart (copy), Debris (ref), VfxManager (ref), u2 (copy)
            local u4 = {};

            if HumanoidRootPart then
                local v5 = script.explode:Clone();
                v5.CFrame = HumanoidRootPart.CFrame * CFrame.new(0.12141400575637817, 3.045909881591797, -0.40644800662994385) * CFrame.fromEulerAnglesYXZ(-0, 0, 0);
                v5.Parent = Debris;
                VfxManager.Emit(v5);
                VfxManager.DestroyEffect(v5, 3);

                for _, child in u2.OtherChar:GetChildren() do
                    if child:IsA("Part") then
                        child.Material = Enum.Material.Ice;
                        u4[child] = child.Color;
                        child.Color = Color3.new(0.14902, 0.8, 1);
                    end;
                end;
            end;

            task.delay(2, function() -- Line: 68
                -- upvalues: u2 (ref), u4 (copy)
                for _, child in u2.OtherChar:GetChildren() do
                    if child:IsA("Part") and u4[child] then
                        child.Material = Enum.Material.Plastic;
                        child.Color = u4[child];
                    end;
                end;
            end);
        end);
    end;

    if u2.Task == "DashFreeze" then
        local u6 = {};

        if HumanoidRootPart then
            local v7 = script.explode:Clone();
            v7.CFrame = HumanoidRootPart.CFrame * CFrame.new(0.12141400575637817, 3.045909881591797, -0.40644800662994385) * CFrame.fromEulerAnglesYXZ(-0, 0, 0);
            v7.Parent = Debris;
            VfxManager.Emit(v7);
            VfxManager.DestroyEffect(v7, 3);

            for _, child in u2.OtherChar:GetChildren() do
                if child:IsA("Part") then
                    child.Material = Enum.Material.Ice;
                    u6[child] = child.Color;
                    child.Color = Color3.new(0.14902, 0.8, 1);
                end;
            end;
        end;

        task.delay(2, function() -- Line: 98
            -- upvalues: u2 (copy), u6 (copy)
            for _, child in u2.OtherChar:GetChildren() do
                if child:IsA("Part") and u6[child] then
                    child.Material = Enum.Material.Plastic;
                    child.Color = u6[child];
                end;
            end;
        end);
    end;
end;