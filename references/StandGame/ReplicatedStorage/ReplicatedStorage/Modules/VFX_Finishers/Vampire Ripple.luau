 

 

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
local l__CameraShaker__9 = require(l__ReplicatedStorage__1.Modules.CameraShaker);
local u2 = nil;
local l__CurrentCamera__10 = workspace.CurrentCamera;
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
local l__Name__11 = script.Name;
local u7 = l__Objects__6:FindFirstChild("Finishers"):FindFirstChild(l__Name__11);
l__Anims__5:FindFirstChild("Finishers"):FindFirstChild(l__Name__11);
local u8 = l__Sounds__7:FindFirstChild("Finishers"):FindFirstChild(l__Name__11);
v1["Finisher: " .. l__Name__11] = function(...) --[[ Line: 54 ]]
    -- upvalues: l__FunctionLibrary__4 (copy), u8 (copy), l__TweenService__2 (copy), u7 (copy), l__Debris2__8 (copy), l__CurrentCamera__10 (copy), l__CameraShaker__9 (copy)
    local v9 = ...;
    local l__Origin__12 = v9.Origin;
    local _ = v9.RespawnTime;
    local l__Parent__13 = l__Origin__12.Parent;
    (l__Parent__13:FindFirstChild("Humanoid") or l__Parent__13:FindFirstChild("AnimationController")):SetStateEnabled(Enum.HumanoidStateType.Dead, false);
    l__FunctionLibrary__4.PlaySound({
        Sound = u8,
        Origin = l__Origin__12
    });
    for _, v10 in pairs(l__Parent__13:GetDescendants()) do
        if v10:IsA("BasePart") or v10:IsA("Decal") then
            l__TweenService__2:Create(v10, TweenInfo.new(0.2), {
                Transparency = 1
            }):Play();
        end;
    end;
    for v11, _ in pairs(l__FunctionLibrary__4.BodyParts.All) do
        local v12 = l__Parent__13[v11];
        for _, v13 in pairs(u7.Crumble:GetChildren()) do
            local u14 = v13:Clone();
            u14.Enabled = true;
            l__Debris2__8:AddItem(u14, 3);
            u14.Parent = v12;
            task.delay(1, function() --[[ Line: 85 ]]
                -- upvalues: u14 (copy)
                u14.Enabled = false;
            end);
        end;
    end;
    local u15 = Instance.new("PointLight");
    u15.Brightness = 0;
    u15.Color = Color3.fromRGB(255, 226, 123);
    u15.Range = 8;
    l__Debris2__8:AddItem(u15, 4.95);
    u15.Parent = l__Origin__12;
    l__TweenService__2:Create(u15, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0), {
        Brightness = 5
    }):Play();
    task.delay(1.1, function() --[[ Line: 98 ]]
        -- upvalues: l__TweenService__2 (ref), u15 (copy)
        l__TweenService__2:Create(u15, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0), {
            Brightness = 0
        }):Play();
    end);
    local v16 = Instance.new("Attachment");
    v16.Parent = l__Origin__12;
    l__Debris2__8:AddItem(v16, 4.95);
    for _, v17 in pairs(u7.Root:GetChildren()) do
        local u18 = v17:Clone();
        u18.Enabled = true;
        task.delay(1.2, function() --[[ Line: 108 ]]
            -- upvalues: u18 (copy)
            u18.Enabled = false;
        end);
        u18.Parent = v16;
    end;
    if (l__CurrentCamera__10.CFrame.p - v9.Origin.CFrame.p).Magnitude <= 100 then
        local u20 = l__CameraShaker__9.new(Enum.RenderPriority.Camera.Value, function(p19) --[[ Line: 115 ]]
            -- upvalues: l__CurrentCamera__10 (ref)
            l__CurrentCamera__10.CFrame = l__CurrentCamera__10.CFrame * p19;
        end);
        u20:Start();
        u20:Shake(l__CameraShaker__9.Presets.Bump);
        task.delay(2, function() --[[ Line: 122 ]]
            -- upvalues: u20 (copy)
            u20:Destroy();
        end);
    end;
end;
return v1;