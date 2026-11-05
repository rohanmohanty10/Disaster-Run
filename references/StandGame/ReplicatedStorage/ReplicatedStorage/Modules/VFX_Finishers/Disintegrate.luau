 

 

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
    -- upvalues: l__FunctionLibrary__4 (copy), u8 (copy), l__TweenService__2 (copy), u7 (copy), l__Debris2__8 (copy)
    local v9 = ...;
    local l__Origin__10 = v9.Origin;
    local _ = v9.RespawnTime;
    local l__Parent__11 = l__Origin__10.Parent;
    (l__Parent__11:FindFirstChild("Humanoid") or l__Parent__11:FindFirstChild("AnimationController")):SetStateEnabled(Enum.HumanoidStateType.Dead, false);
    local l__Origin__12 = v9.Origin;
    local l__Parent__13 = l__Origin__12.Parent;
    l__Origin__12.Anchored = true;
    l__FunctionLibrary__4.PlaySound({
        Sound = { u8.Scream },
        Origin = l__Origin__12
    });
    local v10 = {
        "LeftFoot",
        "LeftLowerLeg",
        "LeftUpperLeg",
        "RightFoot",
        "RightLowerLeg",
        "RightUpperLeg",
        "LowerTorso",
        "UpperTorso",
        "Head",
        "LeftUpperArm",
        "LeftLowerArm",
        "LeftHand",
        "RightUpperArm",
        "RightLowerArm",
        "RightHand"
    };
    for _, v11 in pairs(l__Parent__13:GetDescendants()) do
        if v11:IsA("Decal") then
            v11.Transparency = 1;
        elseif v11:IsA("BasePart") and not table.find(v10, v11.Name) then
            l__TweenService__2:Create(v11, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                Transparency = 1
            }):Play();
        end;
    end;
    for v12 = 1, 15 do
        local u13 = l__Parent__13[v10[v12]];
        for _, v14 in pairs(u7.End:GetChildren()) do
            local u15 = v14:Clone();
            u15.Parent = u13;
            u15.Enabled = true;
            task.delay(0.7, function() --[[ Line: 116 ]]
                -- upvalues: u15 (copy)
                u15.Enabled = false;
            end);
            l__Debris2__8:AddItem(u15, 4);
        end;
        task.delay(0.15, function() --[[ Line: 122 ]]
            -- upvalues: l__TweenService__2 (ref), u13 (copy)
            l__TweenService__2:Create(u13, TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                Transparency = 1
            }):Play();
        end);
    end;
end;
return v1;