 

 

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
local l__IgnoreInstances__6 = workspace:WaitForChild("IgnoreInstances");
local l__Objects__7 = l__ReplicatedStorage__1:WaitForChild("Objects");
local l__Sounds__8 = l__ReplicatedStorage__1:WaitForChild("Sounds");
local l__Debris2__9 = require(l__Modules__3:WaitForChild("Debris2"));
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
local l__Name__10 = script.Name;
local u7 = l__Objects__7:FindFirstChild("Finishers"):FindFirstChild(l__Name__10);
l__Anims__5:FindFirstChild("Finishers"):FindFirstChild(l__Name__10);
local u8 = l__Sounds__8:FindFirstChild("Finishers"):FindFirstChild(l__Name__10);
v1["Finisher: " .. l__Name__10] = function(...) --[[ Line: 54 ]]
    -- upvalues: l__FunctionLibrary__4 (copy), u8 (copy), l__TweenService__2 (copy), u7 (copy), l__Debris2__9 (copy), l__IgnoreInstances__6 (copy)
    local v9 = ...;
    local l__Origin__11 = v9.Origin;
    local _ = v9.RespawnTime;
    local l__Parent__12 = l__Origin__11.Parent;
    (l__Parent__12:FindFirstChild("Humanoid") or l__Parent__12:FindFirstChild("AnimationController")):SetStateEnabled(Enum.HumanoidStateType.Dead, false);
    l__FunctionLibrary__4.PlaySound({
        Sound = u8,
        Origin = l__Origin__11
    });
    local u10 = Random.new();
    l__Origin__11.Anchored = true;
    local u11 = nil;
    local function u13() --[[ Line: 85 ]]
        -- upvalues: u11 (ref), l__Parent__12 (copy), l__TweenService__2 (ref)
        if u11 then
        else
            u11 = true;
            for _, v12 in pairs(l__Parent__12:GetDescendants()) do
                if v12:IsA("BasePart") or (v12:IsA("Decal") or v12:IsA("Texture")) then
                    l__TweenService__2:Create(v12, TweenInfo.new(2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                        Transparency = 1
                    }):Play();
                end;
            end;
        end;
    end;
    for u14 = 1, 6 do
        task.spawn(function() --[[ Line: 110 ]]
            -- upvalues: l__Origin__11 (copy), u14 (copy), u10 (copy), u7 (ref), l__Debris2__9 (ref), l__IgnoreInstances__6 (ref), l__TweenService__2 (ref), l__FunctionLibrary__4 (ref), l__Parent__12 (copy), u13 (copy)
            for u15 = 1, 2 do
                task.spawn(function() --[[ Line: 113 ]]
                    -- upvalues: l__Origin__11 (ref), u14 (ref), u15 (copy), u10 (ref), u7 (ref), l__Debris2__9 (ref), l__IgnoreInstances__6 (ref), l__TweenService__2 (ref), l__FunctionLibrary__4 (ref), l__Parent__12 (ref), u13 (ref)
                    local l__Position__13 = l__Origin__11.Position;
                    local v16 = math.sin((u14 + u15) * 360) * 1;
                    local v17 = math.cos((u14 + u15) * 360) * 1;
                    local v18 = Vector3.new(v16, 0, v17);
                    local v19 = u10:NextNumber(2, 7.25);
                    local v20 = l__Position__13 + (v18 + Vector3.new(0, v19, 0));
                    local v21 = math.sin((u14 + u15) * 360) * 10;
                    local v22 = math.sin((u14 + u15) * 90) * u10:NextNumber(12, 20);
                    local v23 = v20 + Vector3.new(v21, 0, v22);
                    local v24 = u7.Start["Babylon Sword"]:Clone();
                    v24.Transparency = 1;
                    v24.Position = v23;
                    v24.CFrame = CFrame.new(v24.Position, l__Origin__11.Position) * CFrame.Angles(0, 1.5707963267948966, 0);
                    local v25 = Instance.new("Part");
                    v25.Name = "PortalPart";
                    v25.Anchored = true;
                    v25.Transparency = 1;
                    v25.CanCollide = false;
                    v25.CFrame = v24.CFrame * CFrame.new(-2, 0, 0) * CFrame.Angles(0, 1.5707963267948966, 0);
                    local v26 = Instance.new("Attachment");
                    v26.Parent = v25;
                    for _, v27 in pairs(u7.Portal:GetChildren()) do
                        v27:Clone().Parent = v26;
                    end;
                    local v28 = Instance.new("PointLight");
                    v28.Color = Color3.fromRGB(255, 211, 101);
                    v28.Range = 8;
                    v28.Brightness = 1.5;
                    v28.Shadows = false;
                    v28.Parent = v25;
                    l__Debris2__9:AddItem(v25, 3.75);
                    l__Debris2__9:AddItem(v24, 4.25);
                    v25.Parent = l__IgnoreInstances__6;
                    v24.Parent = l__IgnoreInstances__6;
                    local v29 = v26:GetChildren();
                    for _, v30 in pairs(v29) do
                        v30.Enabled = true;
                    end;
                    task.wait(0.3);
                    l__TweenService__2:Create(v24, TweenInfo.new(0.7, Enum.EasingStyle.Cubic, Enum.EasingDirection.In), {
                        Transparency = 0
                    }):Play();
                    task.wait(0.85);
                    local v31 = Instance.new("Attachment");
                    v31.Parent = v25;
                    for _, v32 in pairs(u7.Shoot:GetChildren()) do
                        v32:Clone().Parent = v31;
                    end;
                    v26.Parent = v25;
                    local v33 = l__TweenService__2:Create(v24, TweenInfo.new(0.65, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
                        Position = l__Origin__11.Position
                    });
                    v33:Play();
                    l__FunctionLibrary__4.EmitParticle(v31);
                    task.wait(0.1);
                    l__TweenService__2:Create(v28, TweenInfo.new(0.8, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
                        Range = 0
                    }):Play();
                    local v34 = v26:GetChildren();
                    for _, v35 in pairs(v34) do
                        v35.Enabled = false;
                    end;
                    task.wait(0.15);
                    local v36 = Instance.new("Attachment");
                    v36.Parent = l__Origin__11;
                    local v37 = Instance.new("PointLight");
                    v37.Color = Color3.fromRGB(200, 20, 0);
                    v37.Range = 8;
                    v37.Brightness = 4.5;
                    v37.Shadows = false;
                    v37.Parent = l__Origin__11;
                    l__TweenService__2:Create(v37, TweenInfo.new(0.6, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
                        Range = 0
                    }):Play();
                    for _, v38 in pairs(u7.End:GetChildren()) do
                        v38:Clone().Parent = v36;
                    end;
                    l__FunctionLibrary__4.EmitParticle(v36);
                    l__Debris2__9:AddItem(v36, 2);
                    l__Debris2__9:AddItem(v37, 2);
                    task.wait(0.25);
                    v33:Destroy();
                    v24.Anchored = false;
                    l__FunctionLibrary__4.Weld(v24, l__Parent__12.UpperTorso, v24.CFrame);
                    task.wait(1.7);
                    l__TweenService__2:Create(v24, TweenInfo.new(0.8, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
                        Transparency = 1
                    }):Play();
                    l__FunctionLibrary__4.EmitParticle(v24);
                    u13();
                end);
            end;
        end);
        task.wait(u10:NextNumber(0.01, 0.09));
    end;
    task.wait(1.9);
end;
return v1;