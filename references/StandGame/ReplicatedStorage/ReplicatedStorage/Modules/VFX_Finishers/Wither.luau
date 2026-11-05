 

 

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
require(l__Modules__3:WaitForChild("Debris2"));
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
local l__Name__8 = script.Name;
local u7 = l__Objects__6:FindFirstChild("Finishers"):FindFirstChild(l__Name__8);
l__Anims__5:FindFirstChild("Finishers"):FindFirstChild(l__Name__8);
l__Sounds__7:FindFirstChild("Finishers"):FindFirstChild(l__Name__8);
v1["Finisher: " .. l__Name__8] = function(...) --[[ Line: 54 ]]
    -- upvalues: l__FunctionLibrary__4 (copy), u7 (copy), l__TweenService__2 (copy)
    local v8 = ...;
    local l__Origin__9 = v8.Origin;
    local _ = v8.RespawnTime;
    local l__Parent__10 = l__Origin__9.Parent;
    (l__Parent__10:FindFirstChild("Humanoid") or l__Parent__10:FindFirstChild("AnimationController")):SetStateEnabled(Enum.HumanoidStateType.Dead, false);
    l__FunctionLibrary__4.EmitParticle(u7.Attachments.DeathEmit, l__Parent__10:FindFirstChild("UpperTorso"));
    l__FunctionLibrary__4.PlaySound({
        Sound = { "ThanosSnap", "Your Own Shadow" },
        Origin = l__Origin__9
    });
    wait(0.5);
    local u9 = TweenInfo.new(1.6, Enum.EasingStyle.Quad, Enum.EasingDirection.In, 0, false, 0.5);
    for _, u10 in pairs(l__Parent__10:GetDescendants()) do
        if u10:IsA("BasePart") or (u10:IsA("Decal") or u10:IsA("Texture")) then
            if u10.Parent == l__Parent__10 and l__FunctionLibrary__4.BodyParts.All[u10.Name] then
                for _, v11 in pairs(u7.DissipateParticles:GetChildren()) do
                    local u12 = v11:Clone();
                    u12.Parent = u10;
                    u12.Enabled = true;
                    delay(u9.Time + u9.DelayTime, function() --[[ Line: 92 ]]
                        -- upvalues: u10 (copy)
                        u10.Anchored = true;
                    end);
                    delay(u9.Time, function() --[[ Line: 96 ]]
                        -- upvalues: u12 (copy), u7 (ref), l__FunctionLibrary__4 (ref), u10 (copy)
                        u12.Enabled = false;
                        for _, v13 in pairs(u7.DustEmit:GetChildren()) do
                            l__FunctionLibrary__4.EmitParticle(v13, u10);
                        end;
                        u10.Anchored = true;
                    end);
                end;
            end;
            local u14 = l__TweenService__2:Create(u10, u9, {
                Transparency = 1
            });
            u14:Play();
            delay(u9.Time + u9.DelayTime + 1, function() --[[ Line: 119 ]]
                -- upvalues: u9 (ref), u14 (ref)
                u9 = nil;
                u14:Destroy();
                u14 = nil;
            end);
        elseif u10:IsA("ParticleEmitter") or (u10:IsA("Beam") or u10:IsA("Trail")) then
            u10.Enabled = false;
        end;
    end;
end;
return v1;