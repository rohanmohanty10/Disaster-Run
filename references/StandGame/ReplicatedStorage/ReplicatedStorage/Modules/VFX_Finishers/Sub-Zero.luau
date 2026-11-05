 

 

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
l__Sounds__8:FindFirstChild("Finishers"):FindFirstChild(l__Name__10);
v1["Finisher: " .. l__Name__10] = function(...) --[[ Line: 54 ]]
    -- upvalues: l__FunctionLibrary__4 (copy), l__TweenService__2 (copy), u7 (copy), l__IgnoreInstances__6 (copy), l__Debris2__9 (copy)
    local v8 = ...;
    local l__Origin__11 = v8.Origin;
    local _ = v8.RespawnTime;
    local l__Parent__12 = l__Origin__11.Parent;
    (l__Parent__12:FindFirstChild("Humanoid") or l__Parent__12:FindFirstChild("AnimationController")):SetStateEnabled(Enum.HumanoidStateType.Dead, false);
    l__FunctionLibrary__4.PlaySound({
        Sound = "Ice Freeze",
        Volume = 4,
        Origin = l__Origin__11
    });
    local u9 = Random.new();
    delay(2.25, function() --[[ Line: 90 ]]
        -- upvalues: l__FunctionLibrary__4 (ref), l__Origin__11 (copy)
        l__FunctionLibrary__4.PlaySound({
            Sound = "Ice Shatter",
            Volume = 2,
            Origin = l__Origin__11
        });
    end);
    local function u13(p10, p11) --[[ Line: 82 ]]
        for _, v12 in pairs(p10) do
            if v12:IsA("ParticleEmitter") then
                v12.Enabled = p11;
            end;
        end;
    end;
    for _, u14 in pairs(l__Parent__12:GetDescendants()) do
        if u14:IsA("BasePart") then
            u14.Anchored = true;
            if u14 ~= l__Parent__12.PrimaryPart then
                task.spawn(function() --[[ Line: 103 ]]
                    -- upvalues: u14 (copy), l__TweenService__2 (ref), u7 (ref), u9 (copy), l__IgnoreInstances__6 (ref), u13 (copy)
                    u14.Material = Enum.Material.Ice;
                    u14.Color = Color3.new(0.188235, 0.498039, 1);
                    local v15 = l__TweenService__2:Create(u14, TweenInfo.new(0.25, Enum.EasingStyle.Linear), {
                        Color = Color3.new(0.792157, 0.886275, 1)
                    });
                    v15:Play();
                    task.wait(0.25);
                    v15:Destroy();
                    for _, v16 in pairs(u7.Particles:GetChildren()) do
                        if v16.Name == "Star" then
                            v16.Rate = Random.new():NextNumber(0.1, 0.7);
                        end;
                        v16:Clone().Parent = u14;
                    end;
                    task.wait(2);
                    u14.Transparency = 1;
                    for _, v17 in pairs(u14:GetDescendants()) do
                        if v17:IsA("ParticleEmitter") then
                            v17:Emit(v17:GetAttribute("EmitCount"));
                        end;
                    end;
                    for _ = 1, math.round(u14.Size.Magnitude) do
                        task.spawn(function() --[[ Line: 134 ]]
                            -- upvalues: u7 (ref), u14 (ref), u9 (ref), l__IgnoreInstances__6 (ref), l__TweenService__2 (ref)
                            local v18 = u7["IcePart" .. math.random(1, 2)]:Clone();
                            v18.CFrame = u14.CFrame * CFrame.new(u9:NextNumber(-u14.Size.X / 2, u14.Size.X / 2), u9:NextNumber(-u14.Size.Y / 2, u14.Size.Y / 2), u9:NextNumber(-u14.Size.Z / 2, u14.Size.Z / 2)) * CFrame.Angles(u9:NextNumber(0, 6.283185307179586), u9:NextNumber(0, 6.283185307179586), u9:NextNumber(0, 6.283185307179586));
                            local v19 = u9:NextNumber(0.3, 1);
                            local v20 = u9:NextNumber(0.4, 1);
                            v18.Size = Vector3.new(v19, v20, u9:NextNumber(0.4, 1));
                            v18.Parent = l__IgnoreInstances__6;
                            if math.random(1, 2) == 1 then
                                local v21 = Instance.new("BodyVelocity");
                                local v22 = u9:NextNumber(-10, 10);
                                local v23 = u9:NextNumber(0, 30);
                                v21.Velocity = Vector3.new(v22, v23, u9:NextNumber(-10, 10));
                                v21.MaxForce = Vector3.new(700000, 700000, 700000);
                                v21.Parent = v18;
                                task.wait(0.1);
                                v21:Destroy();
                            end;
                            task.wait(0.2);
                            v18.CanCollide = true;
                            task.wait(0.6);
                            task.wait(u9:NextNumber(0, 0.5));
                            local v24 = l__TweenService__2:Create(v18, TweenInfo.new(0.3, Enum.EasingStyle.Linear), {
                                Size = Vector3.new(0, 0, 0)
                            });
                            v24:Play();
                            task.wait(0.3);
                            v18:Destroy();
                            v24:Destroy();
                        end);
                    end;
                    u13(u14:GetDescendants(), false);
                end);
            end;
        elseif u14:IsA("Decal") then
            u14.Transparency = 1;
        end;
    end;
    local v25 = u7.FloorParticles:Clone();
    v25.CFrame = l__Origin__11.CFrame * CFrame.new(0, -3, 0);
    v25.Parent = l__IgnoreInstances__6;
    task.wait(2.3);
    local v26 = u7.Flash:Clone();
    v26.CFrame = l__Origin__11.CFrame;
    v26.Parent = workspace;
    for _, v27 in pairs(v26:GetDescendants()) do
        if v27:IsA("ParticleEmitter") then
            v27:Emit(v27:GetAttribute("EmitCount"));
        end;
    end;
    u13(v25:GetDescendants(), false);
    l__Debris2__9:AddItem(v26, 5);
    l__Debris2__9:AddItem(v25, 5);
end;
return v1;