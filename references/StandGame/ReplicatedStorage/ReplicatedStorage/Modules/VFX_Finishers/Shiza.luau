 

 

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
local l__CameraShaker__10 = require(l__ReplicatedStorage__1.Modules.CameraShaker);
local u2 = nil;
local l__CurrentCamera__11 = workspace.CurrentCamera;
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
local l__Name__12 = script.Name;
local u7 = l__Objects__7:FindFirstChild("Finishers"):FindFirstChild(l__Name__12);
local u8 = l__Anims__5:FindFirstChild("Finishers"):FindFirstChild(l__Name__12);
local u9 = l__Sounds__8:FindFirstChild("Finishers"):FindFirstChild(l__Name__12);
v1["Finisher: " .. l__Name__12] = function(...) --[[ Line: 55 ]]
    -- upvalues: u8 (copy), l__FunctionLibrary__4 (copy), u9 (copy), u7 (copy), l__IgnoreInstances__6 (copy), l__Debris2__9 (copy), l__TweenService__2 (copy), l__CurrentCamera__11 (copy), l__CameraShaker__10 (copy)
    local v10 = ...;
    local l__Origin__13 = v10.Origin;
    local _ = v10.RespawnTime;
    local l__Parent__14 = l__Origin__13.Parent;
    local v11 = l__Parent__14:FindFirstChild("Humanoid") or l__Parent__14:FindFirstChild("AnimationController");
    v11:SetStateEnabled(Enum.HumanoidStateType.Dead, false);
    local l__Origin__15 = v10.Origin;
    local l__Parent__16 = l__Origin__15.Parent;
    local function v15(p12, p13) --[[ Line: 69 ]]
        for _, v14 in pairs(p12) do
            if v14:IsA("ParticleEmitter") then
                v14.Enabled = p13;
            end;
        end;
    end;
    local v16 = v11:LoadAnimation(u8);
    v16:Play();
    v16:AdjustSpeed(1.5);
    l__Origin__15.Anchored = true;
    l__FunctionLibrary__4.PlaySound({
        Sound = { u9.Start },
        Origin = l__Origin__15
    });
    local v17 = u7.Start.Cross:Clone();
    v17.CFrame = l__Origin__15.CFrame * CFrame.new(0, 45, 0);
    v17.Parent = l__IgnoreInstances__6;
    l__Debris2__9:AddItem(v17, 6.5);
    delay(0.3, function() --[[ Line: 94 ]]
        -- upvalues: l__FunctionLibrary__4 (ref), u9 (ref), l__Origin__15 (copy)
        l__FunctionLibrary__4.PlaySound({
            Sound = { u9.Wah },
            Origin = l__Origin__15
        });
    end);
    task.wait(0.2);
    v15(v17:GetChildren(), true);
    task.wait(0.2);
    l__TweenService__2:Create(v17, TweenInfo.new(0.6, Enum.EasingStyle.Cubic, Enum.EasingDirection.In), {
        CFrame = v17.CFrame * CFrame.new(0, -45.5, 0)
    }):Play();
    task.delay(0.3, function() --[[ Line: 107 ]]
        -- upvalues: l__Origin__15 (copy), l__Debris2__9 (ref), u7 (ref), l__FunctionLibrary__4 (ref)
        local v18 = Instance.new("Attachment");
        v18.Position = Vector3.new(0.75, 1.5, 0);
        v18.Parent = l__Origin__15;
        l__Debris2__9:AddItem(v18, 2);
        for _, v19 in pairs(u7.Exclamation:GetChildren()) do
            v19:Clone().Parent = v18;
        end;
        l__FunctionLibrary__4.EmitParticle(v18);
    end);
    task.wait(0.6);
    local v20 = Instance.new("Attachment");
    v20.WorldPosition = l__Origin__15.Position + Vector3.new(0, -3, 0);
    v20.Parent = workspace.Terrain;
    l__Debris2__9:AddItem(v20, 6.5);
    for _, v21 in pairs(u7.End:GetChildren()) do
        v21:Clone().Parent = v20;
    end;
    v15(v17:GetChildren(), false);
    l__FunctionLibrary__4.EmitParticle(v20);
    if (l__CurrentCamera__11.CFrame.p - v10.Origin.CFrame.p).Magnitude <= 100 then
        local u23 = l__CameraShaker__10.new(Enum.RenderPriority.Camera.Value, function(p22) --[[ Line: 136 ]]
            -- upvalues: l__CurrentCamera__11 (ref)
            l__CurrentCamera__11.CFrame = l__CurrentCamera__11.CFrame * p22;
        end);
        u23:Start();
        u23:Shake(l__CameraShaker__10.Presets.Bump);
        task.delay(2, function() --[[ Line: 143 ]]
            -- upvalues: u23 (copy)
            u23:Destroy();
        end);
    end;
    for _, v24 in pairs(l__Parent__16:GetDescendants()) do
        if v24:IsA("BasePart") and (l__FunctionLibrary__4.BodyParts.All[v24.Name] and v24.Name ~= "Head") then
            v24.Anchored = true;
            v24.Size = (v24:GetAttribute("OriginalSize") or v24.Size) * 1.75;
            v24:ClearAllChildren();
            local v25 = l__Origin__15.Position + Random.new():NextUnitVector() * 10;
            v24.CFrame = CFrame.new(l__Origin__15.Position, v25);
            l__TweenService__2:Create(v24, TweenInfo.new(Random.new():NextNumber(0.9, 1.4), Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                Size = Vector3.new(0, 0, 0),
                Position = v25
            }):Play();
        elseif v24:IsA("BasePart") or v24:IsA("Decal") then
            v24.Transparency = 1;
        end;
    end;
    task.wait(0.675);
    task.wait(4);
    l__TweenService__2:Create(v17, TweenInfo.new(0.7, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
        Transparency = 1,
        CFrame = v17.CFrame * CFrame.new(0, -0.5, 0)
    }):Play();
end;
return v1;