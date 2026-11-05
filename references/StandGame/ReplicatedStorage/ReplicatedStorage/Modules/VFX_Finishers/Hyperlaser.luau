 

 

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
local u8 = l__Anims__5:FindFirstChild("Finishers"):FindFirstChild(l__Name__9);
local u9 = l__Sounds__7:FindFirstChild("Finishers"):FindFirstChild(l__Name__9);
v1["Finisher: " .. l__Name__9] = function(...) --[[ Line: 55 ]]
    -- upvalues: l__FunctionLibrary__4 (copy), u9 (copy), u8 (copy), l__Debris2__8 (copy), u7 (copy), l__TweenService__2 (copy)
    local v10 = ...;
    local l__Origin__10 = v10.Origin;
    local _ = v10.RespawnTime;
    local l__Parent__11 = l__Origin__10.Parent;
    local v11 = l__Parent__11:FindFirstChild("Humanoid") or l__Parent__11:FindFirstChild("AnimationController");
    v11:SetStateEnabled(Enum.HumanoidStateType.Dead, false);
    local l__Origin__12 = v10.Origin;
    local l__Parent__13 = l__Origin__12.Parent;
    local v12 = Random.new();
    l__Origin__12.Anchored = true;
    l__FunctionLibrary__4.PlaySound({
        Sound = { u9 },
        Origin = l__Origin__12
    });
    v11:LoadAnimation(u8[tostring(math.random(1, 3))]):Play(0);
    local v13 = Instance.new("PointLight");
    v13.Brightness = 6;
    v13.Range = 16;
    v13.Color = Color3.fromRGB(58, 255, 255);
    v13.Parent = l__Origin__12;
    l__Debris2__8:AddItem(v13, 1.3);
    for _, u14 in pairs(l__Parent__13:GetDescendants()) do
        if u14:IsA("BasePart") then
            if l__FunctionLibrary__4.BodyParts.All[u14.Name] then
                local v15 = Instance.new("SelectionBox");
                v15.Adornee = u14;
                v15.Color3 = Color3.fromRGB(58, 255, 255);
                v15.SurfaceTransparency = 1;
                v15.Parent = u14;
                l__Debris2__8:AddItem(v15, 1.3);
                for _, v16 in pairs(u7.Aura:GetChildren()) do
                    local u17 = v16:Clone();
                    u17.Enabled = true;
                    task.delay(v12:NextNumber(0.3, 0.5), function() --[[ Line: 112 ]]
                        -- upvalues: u17 (copy)
                        u17.Enabled = false;
                    end);
                    u17.Parent = u14;
                    l__Debris2__8:AddItem(u17, 4);
                end;
                task.delay(0.15, function() --[[ Line: 120 ]]
                    -- upvalues: l__TweenService__2 (ref), u14 (copy)
                    l__TweenService__2:Create(u14, TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                        Transparency = 1
                    }):Play();
                end);
            else
                u14.Transparency = 1;
            end;
        end;
    end;
end;
return v1;