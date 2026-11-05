 

 

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
workspace:WaitForChild("IgnoreInstances");
local l__Objects__5 = l__ReplicatedStorage__1:WaitForChild("Objects");
local l__Sounds__6 = l__ReplicatedStorage__1:WaitForChild("Sounds");
require(l__Modules__2:WaitForChild("Debris2"));
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
local l__Name__7 = script.Name;
l__Objects__5:FindFirstChild("Finishers"):FindFirstChild(l__Name__7);
l__Anims__4:FindFirstChild("Finishers"):FindFirstChild(l__Name__7);
local u7 = l__Sounds__6:FindFirstChild("Finishers"):FindFirstChild(l__Name__7);
v1["Finisher: " .. l__Name__7] = function(...) --[[ Line: 54 ]]
    -- upvalues: l__FunctionLibrary__3 (copy), u7 (copy)
    local v8 = ...;
    local l__Origin__8 = v8.Origin;
    local _ = v8.RespawnTime;
    local l__Parent__9 = l__Origin__8.Parent;
    (l__Parent__9:FindFirstChild("Humanoid") or l__Parent__9:FindFirstChild("AnimationController")):SetStateEnabled(Enum.HumanoidStateType.Dead, false);
    l__FunctionLibrary__3.PlaySound({
        Sound = u7.Oof,
        Origin = l__Origin__8
    });
end;
return v1;