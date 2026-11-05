 

 

local v1 = {};
game:GetService("CollectionService");
local l__ReplicatedStorage__1 = game:GetService("ReplicatedStorage");
game:GetService("RunService");
game:GetService("PhysicsService");
local l__TweenService__2 = game:GetService("TweenService");
game:GetService("Lighting");
local l__Modules__3 = l__ReplicatedStorage__1:WaitForChild("Modules");
local l__FunctionLibrary__4 = require(l__Modules__3:WaitForChild("FunctionLibrary"));
require(l__Modules__3:WaitForChild("ChannelMod2"));
workspace:WaitForChild("Living");
local l__Anims__5 = l__ReplicatedStorage__1:WaitForChild("Anims");
workspace:WaitForChild("IgnoreInstances");
local l__Objects__6 = l__ReplicatedStorage__1:WaitForChild("Objects");
local l__Sounds__7 = l__ReplicatedStorage__1:WaitForChild("Sounds");
local l__Debris2__8 = require(l__Modules__3:WaitForChild("Debris2"));
require(l__ReplicatedStorage__1.Modules.CameraShaker);
local u2 = nil;
local _ = workspace.CurrentCamera;
local u3 = nil;
local u4 = nil;
local u5 = nil;
local _ = game.Players.LocalPlayer;
v1["Set Up"] = function(...) --[[ Line: 33 ]]
    -- upvalues: u2 (ref), u3 (ref), u4 (ref), u5 (ref)
    local v6 = ...;
    u2 = v6.Client_Mod;
    u3 = v6.Misc_Functions;
    u4 = v6.VFX;
    u5 = v6.VFX_2;
end;
local l__Name__9 = script.Name;
local u7 = l__Objects__6:FindFirstChild("Finishers"):FindFirstChild(l__Name__9);
l__Anims__5:FindFirstChild("Finishers"):FindFirstChild(l__Name__9);
local u8 = l__Sounds__7:FindFirstChild("Finishers"):FindFirstChild(l__Name__9);
v1["Finisher: " .. l__Name__9] = function(...) --[[ Line: 55 ]]
    -- upvalues: l__Debris2__8 (copy), l__TweenService__2 (copy), u7 (copy), l__FunctionLibrary__4 (copy), u8 (copy)
    local v9 = ...;
    local l__Origin__10 = v9.Origin;
    local _ = v9.RespawnTime;
    local l__Parent__11 = l__Origin__10.Parent;
    (l__Parent__11:FindFirstChild("Humanoid") or l__Parent__11:FindFirstChild("AnimationController")):SetStateEnabled(Enum.HumanoidStateType.Dead, false);
    local l__Origin__12 = v9.Origin;
    local l__Parent__13 = l__Origin__12.Parent;
    local v10 = {
        Color3.fromRGB(255, 46, 46),
        Color3.fromRGB(145, 255, 1),
        Color3.fromRGB(255, 149, 0),
        Color3.fromRGB(0, 110, 255),
        Color3.fromRGB(170, 0, 255)
    };
    local v11 = v10[math.random(1, #v10)];
    local u12 = Instance.new("PointLight");
    u12.Brightness = 0;
    u12.Color = v11;
    u12.Range = 8;
    l__Debris2__8:AddItem(u12, 4.95);
    u12.Parent = l__Origin__12;
    l__TweenService__2:Create(u12, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0), {
        Brightness = 5
    }):Play();
    task.delay(3, function() --[[ Line: 86 ]]
        -- upvalues: l__TweenService__2 (ref), u12 (copy)
        l__TweenService__2:Create(u12, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0), {
            Brightness = 0
        }):Play();
    end);
    local v13 = Instance.new("Attachment");
    v13.Orientation = Vector3.new(90, 0, 0);
    v13.Parent = l__Origin__12;
    l__Debris2__8:AddItem(v13, 4.95);
    for _, v14 in pairs(u7.Start:GetChildren()) do
        local u15 = v14:Clone();
        u15.Color = ColorSequence.new(v11);
        u15.Enabled = true;
        task.delay(3.2, function() --[[ Line: 100 ]]
            -- upvalues: u15 (copy)
            u15.Enabled = false;
        end);
        u15.Parent = v13;
    end;
    l__Parent__13:BreakJoints();
    for _, v16 in pairs(l__Parent__13:GetDescendants()) do
        if v16:IsA("BallSocketConstraint") then
            v16.Enabled = false;
        end;
        if v16:IsA("Motor6D") and (v16.Name ~= "Neck" and v16.Name ~= "Root") then
            v16.Part1 = nil;
            v16.Enabled = false;
            v16:Destroy();
        end;
        if v16:IsA("BasePart") and (v16.Name ~= "HumanoidRootPart" and v16.Name ~= "Handle") then
            v16.Anchored = false;
            v16.CanCollide = true;
        end;
    end;
    l__FunctionLibrary__4.PlaySound({
        Sound = { u8 },
        Origin = l__Origin__12
    });
end;
return v1;