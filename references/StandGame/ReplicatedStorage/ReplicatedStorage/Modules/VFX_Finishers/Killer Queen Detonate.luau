 

 

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
v1["Finisher: " .. l__Name__11] = function(...) --[[ Line: 55 ]]
    -- upvalues: l__FunctionLibrary__4 (copy), u8 (copy), l__TweenService__2 (copy), l__CurrentCamera__10 (copy), l__Debris2__8 (copy), u7 (copy), l__CameraShaker__9 (copy)
    local v9 = ...;
    local l__Origin__12 = v9.Origin;
    local _ = v9.RespawnTime;
    local l__Parent__13 = l__Origin__12.Parent;
    (l__Parent__13:FindFirstChild("Humanoid") or l__Parent__13:FindFirstChild("AnimationController")):SetStateEnabled(Enum.HumanoidStateType.Dead, false);
    local l__Origin__14 = v9.Origin;
    local l__Parent__15 = l__Origin__14.Parent;
    l__FunctionLibrary__4.PlaySound({
        Sound = { u8.Detonate },
        Origin = l__Origin__14
    });
    wait(0.2);
    l__FunctionLibrary__4.PlaySound({
        Sound = { u8.Explosion },
        Origin = l__Origin__14
    });
    for u10, _ in pairs(l__FunctionLibrary__4.BodyParts.All) do
        if u10 ~= "LowerTorso" then
            task.spawn(function() --[[ Line: 83 ]]
                -- upvalues: l__Parent__15 (copy), u10 (copy), l__TweenService__2 (ref)
                local v11 = Random.new();
                task.wait(v11:NextNumber(0, 0.3));
                if l__Parent__15[u10] then
                    l__Parent__15[u10]:SetAttribute("OriginalSize", l__Parent__15[u10].Size);
                    local u12 = l__TweenService__2:Create(l__Parent__15[u10], TweenInfo.new(v11:NextNumber(0.1, 0.175), Enum.EasingStyle.Back, Enum.EasingDirection.In, 2, true), {
                        Size = l__Parent__15[u10].Size * v11:NextNumber(1.2, 2.2)
                    });
                    u12:Play();
                    task.delay(0.45, function() --[[ Line: 92 ]]
                        -- upvalues: u12 (copy), l__Parent__15 (ref), u10 (ref)
                        u12:Pause();
                        u12:Destroy();
                        l__Parent__15[u10].Size = l__Parent__15[u10]:GetAttribute("OriginalSize");
                    end);
                end;
            end);
        end;
    end;
    if l__Parent__15 == v9.Origin.Parent then
        l__TweenService__2:Create(l__CurrentCamera__10, TweenInfo.new(0.45, Enum.EasingStyle.Cubic, Enum.EasingDirection.In), {
            FieldOfView = 80
        }):Play();
        task.delay(0.45, function() --[[ Line: 103 ]]
            -- upvalues: l__TweenService__2 (ref), l__CurrentCamera__10 (ref)
            l__TweenService__2:Create(l__CurrentCamera__10, TweenInfo.new(0.25, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
                FieldOfView = 70
            }):Play();
        end);
    end;
    task.wait(0.45);
    l__Parent__15:BreakJoints();
    l__Origin__14.Anchored = true;
    l__Parent__15.Head.Anchored = true;
    for _, v13 in pairs(l__Parent__15:GetDescendants()) do
        if v13:IsA("BasePart") and (l__FunctionLibrary__4.BodyParts.All[v13.Name] and v13.Name ~= "Head") then
            v13.Anchored = true;
            v13.Size = (v13:GetAttribute("OriginalSize") or v13.Size) * 1.75;
            v13:ClearAllChildren();
            local v14 = l__Origin__14.Position + Random.new():NextUnitVector() * 10;
            v13.CFrame = CFrame.new(l__Origin__14.Position, v14);
            l__TweenService__2:Create(v13, TweenInfo.new(Random.new():NextNumber(0.9, 1.4), Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                Size = Vector3.new(0, 0, 0),
                Position = v14
            }):Play();
        elseif v13:IsA("BasePart") or v13:IsA("Decal") then
            v13.Transparency = 1;
        end;
    end;
    local v15 = Instance.new("PointLight");
    v15.Color = Color3.fromRGB(255, 38, 0);
    v15.Range = 10;
    v15.Brightness = 7;
    l__Debris2__8:AddItem(v15, 4.95);
    v15.Parent = l__Origin__14;
    l__TweenService__2:Create(v15, TweenInfo.new(3, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
        Brightness = 0
    }):Play();
    local v16 = Instance.new("Attachment");
    l__Debris2__8:AddItem(v16, 4.95);
    v16.Parent = l__Origin__14;
    for _, v17 in ipairs(u7.End:GetChildren()) do
        v17:Clone().Parent = v16;
    end;
    l__FunctionLibrary__4.EmitParticle(v16);
    if (l__CurrentCamera__10.CFrame.p - v9.Origin.CFrame.p).Magnitude <= 100 then
        local u19 = l__CameraShaker__9.new(Enum.RenderPriority.Camera.Value, function(p18) --[[ Line: 153 ]]
            -- upvalues: l__CurrentCamera__10 (ref)
            l__CurrentCamera__10.CFrame = l__CurrentCamera__10.CFrame * p18;
        end);
        u19:Start();
        u19:Shake(l__CameraShaker__9.Presets.Bump);
        task.delay(2, function() --[[ Line: 160 ]]
            -- upvalues: u19 (copy)
            u19:Destroy();
        end);
    end;
end;
return v1;