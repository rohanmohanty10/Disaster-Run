 

 

local v1 = {};
game:GetService("CollectionService");
local l__ReplicatedStorage__1 = game:GetService("ReplicatedStorage");
game:GetService("RunService");
game:GetService("PhysicsService");
game:GetService("TweenService");
game:GetService("Lighting");
local l__Modules__2 = l__ReplicatedStorage__1:WaitForChild("Modules");
local l__FunctionLibrary__3 = require(l__Modules__2:WaitForChild("FunctionLibrary"));
require(l__Modules__2:WaitForChild("ChannelMod2"));
workspace:WaitForChild("Living");
local l__Anims__4 = l__ReplicatedStorage__1:WaitForChild("Anims");
local l__IgnoreInstances__5 = workspace:WaitForChild("IgnoreInstances");
local l__Objects__6 = l__ReplicatedStorage__1:WaitForChild("Objects");
local l__Sounds__7 = l__ReplicatedStorage__1:WaitForChild("Sounds");
local l__Debris2__8 = require(l__Modules__2:WaitForChild("Debris2"));
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
l__Objects__6:FindFirstChild("Finishers"):FindFirstChild(l__Name__9);
l__Anims__4:FindFirstChild("Finishers"):FindFirstChild(l__Name__9);
local u7 = l__Sounds__7:FindFirstChild("Finishers"):FindFirstChild(l__Name__9);
v1["Finisher: " .. l__Name__9] = function(...) --[[ Line: 55 ]]
    -- upvalues: l__FunctionLibrary__3 (copy), u7 (copy), l__IgnoreInstances__5 (copy), l__Debris2__8 (copy)
    local v8 = ...;
    local l__Origin__10 = v8.Origin;
    local _ = v8.RespawnTime;
    local l__Parent__11 = l__Origin__10.Parent;
    (l__Parent__11:FindFirstChild("Humanoid") or l__Parent__11:FindFirstChild("AnimationController")):SetStateEnabled(Enum.HumanoidStateType.Dead, false);
    local l__Origin__12 = v8.Origin;
    local l__Parent__13 = l__Origin__12.Parent;
    l__FunctionLibrary__3.PlaySound({
        Sound = { u7 },
        Origin = l__Origin__12
    });
    l__Parent__13:BreakJoints();
    l__Origin__12.Anchored = true;
    local l__Head__14 = l__Parent__13.Head;
    l__Head__14.CanCollide = true;
    l__Head__14.Parent = l__IgnoreInstances__5;
    l__Debris2__8:AddItem(l__Head__14, 5);
    for _, v9 in pairs(l__Parent__13:GetDescendants()) do
        if v9:IsA("BasePart") and (l__FunctionLibrary__3.BodyParts.All[v9.Name] and v9.Name ~= "Head") then
            v9.CanCollide = true;
            for _, v10 in pairs(v9:GetChildren()) do
                if v10:IsA("BallSocketConstraint") or (v10:IsA("Motor6D") or (v10:IsA("Weld") or (v10:IsA("ManualWeld") or v10:IsA("SpecialWeld")))) then
                    v10:Destroy();
                end;
            end;
        elseif v9:IsA("Accessory") or v9:IsA("Hat") then
            v9.Parent = l__IgnoreInstances__5;
            for _, v11 in pairs(v9:GetDescendants()) do
                if v11:IsA("BasePart") then
                    v11.CanCollide = true;
                end;
            end;
            l__Debris2__8:AddItem(v9, 5);
        end;
    end;
end;
return v1;