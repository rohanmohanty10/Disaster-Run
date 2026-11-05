 

 

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
local l__CurrentCamera__8 = workspace.CurrentCamera;
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
v1["Finisher: " .. l__Name__9] = function(...) --[[ Line: 54 ]]
    -- upvalues: l__FunctionLibrary__4 (copy), u8 (copy), l__CurrentCamera__8 (copy), l__TweenService__2 (copy), u7 (copy)
    local v9 = ...;
    local l__Origin__10 = v9.Origin;
    local _ = v9.RespawnTime;
    local l__Parent__11 = l__Origin__10.Parent;
    (l__Parent__11:FindFirstChild("Humanoid") or l__Parent__11:FindFirstChild("AnimationController")):SetStateEnabled(Enum.HumanoidStateType.Dead, false);
    l__FunctionLibrary__4.PlaySound({
        Sound = u8,
        Origin = l__Origin__10
    });
    local v10 = Color3.fromRGB(130, 235, 255);
    for _, u11 in pairs(l__Parent__11:GetDescendants()) do
        if (u11:IsA("Decal") or u11:IsA("Texture")) and u11.Transparency < 1 then
            local l__Transparency__12 = u11.Transparency;
            u11.Transparency = 1;
            l__FunctionLibrary__4.Delay(5, function() --[[ Line: 78 ]]
                -- upvalues: u11 (copy), l__Transparency__12 (copy)
                u11.Transparency = l__Transparency__12;
            end);
        elseif u11:IsA("BasePart") and u11.Transparency < 1 then
            local u12 = u11:Clone();
            for _, v13 in pairs(u12:GetChildren()) do
                if v13:IsA("SpecialMesh") then
                    if v13:IsA("SpecialMesh") then
                        v13.Scale = v13.Scale + Vector3.new(0.1, 0.1, 0.1);
                        if v13.MeshType == "FileMesh" then
                            v13.TextureId = "http://www.roblox.com/asset/?id=6347925";
                            v13.VertexColor = Vector3.new(v10.R * 10, v10.G * 10, v10.B * 10);
                        end;
                    end;
                else
                    v13:Destroy();
                end;
            end;
            if u12:IsA("MeshPart") then
                u12.TextureID = "";
            end;
            u12.CastShadow = false;
            u12.Massless = true;
            u12.Anchored = false;
            u12.CanCollide = false;
            u12.Color = v10;
            u12.Material = "Neon";
            u12.Transparency = 1;
            u12.Size = u12.Size + Vector3.new(0.1, 0.1, 0.1);
            u12.Parent = l__CurrentCamera__8;
            l__FunctionLibrary__4.Weld(u11, u12, CFrame.new(0, 0, 0)).Parent = u12;
            l__TweenService__2:Create(u12, TweenInfo.new(2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                Transparency = 0
            }):Play();
            l__FunctionLibrary__4.Delay(2.5, function() --[[ Line: 120 ]]
                -- upvalues: u12 (copy), u11 (copy), l__FunctionLibrary__4 (ref), u7 (ref)
                u12.Transparency = 1;
                local l__Transparency__13 = u11.Transparency;
                u11.Transparency = 1;
                l__FunctionLibrary__4.EmitParticle(u7.FaintParticle, u12, 4, true);
                l__FunctionLibrary__4.Delay(4, function() --[[ Line: 129 ]]
                    -- upvalues: u12 (ref)
                    u12:Destroy();
                end);
                wait(2);
                u11.Transparency = l__Transparency__13;
            end);
        end;
    end;
    for _, u14 in pairs(l__Parent__11:GetDescendants()) do
        if u14:IsA("BasePart") then
            u14.Anchored = true;
            if u14 ~= l__Parent__11.PrimaryPart then
                task.spawn(function() --[[ Line: 161 ]]
                    -- upvalues: u14 (copy), l__TweenService__2 (ref), u7 (ref)
                    u14.Material = Enum.Material.Neon;
                    u14.Color = Color3.new(0.188235, 0.498039, 1);
                    local v15 = l__TweenService__2:Create(u14, TweenInfo.new(0.25, Enum.EasingStyle.Linear), {
                        Color = Color3.new(0.521569, 0.792157, 1)
                    });
                    v15:Play();
                    wait(2.5);
                    v15:Destroy();
                    for _, v16 in pairs(u7.Particles:GetChildren()) do
                        local v17 = v16:Clone();
                        v17.Parent = u14;
                        v17:Emit(v17:GetAttribute("EmitCount"));
                    end;
                    task.wait(0.05);
                end);
            end;
        elseif not u14:IsA("Decal") then
            u14:IsA("Texture");
        end;
    end;
end;
return v1;