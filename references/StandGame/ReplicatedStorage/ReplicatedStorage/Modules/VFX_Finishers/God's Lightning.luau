 

 

local v1 = {};
game:GetService("CollectionService");
local l__ReplicatedStorage__1 = game:GetService("ReplicatedStorage");
game:GetService("RunService");
game:GetService("PhysicsService");
local l__TweenService__2 = game:GetService("TweenService");
local l__Lighting__3 = game:GetService("Lighting");
local l__Modules__4 = l__ReplicatedStorage__1:WaitForChild("Modules");
local l__FunctionLibrary__5 = require(l__Modules__4:WaitForChild("FunctionLibrary"));
require(l__Modules__4:WaitForChild("ChannelMod2"));
workspace:WaitForChild("Living");
local l__Anims__6 = l__ReplicatedStorage__1:WaitForChild("Anims");
local l__IgnoreInstances__7 = workspace:WaitForChild("IgnoreInstances");
local l__Objects__8 = l__ReplicatedStorage__1:WaitForChild("Objects");
local l__Sounds__9 = l__ReplicatedStorage__1:WaitForChild("Sounds");
local l__Debris2__10 = require(l__Modules__4:WaitForChild("Debris2"));
require(l__ReplicatedStorage__1.Modules.CameraShaker);
local u2 = nil;
local _ = workspace.CurrentCamera;
local u3 = nil;
local u4 = nil;
local u5 = nil;
local l__LocalPlayer__11 = game.Players.LocalPlayer;
v1["Set Up"] = function(...) --[[ Line: 33 ]]
    -- upvalues: u2 (ref), u3 (ref), u4 (ref), u5 (ref)
    local v6 = ...;
    u2 = v6.Client_Mod;
    u3 = v6.Misc_Functions;
    u4 = v6.VFX;
    u5 = v6.VFX_2;
end;
local l__Name__12 = script.Name;
local u7 = l__Objects__8:FindFirstChild("Finishers"):FindFirstChild(l__Name__12);
local u8 = l__Anims__6:FindFirstChild("Finishers"):FindFirstChild(l__Name__12);
local u9 = l__Sounds__9:FindFirstChild("Finishers"):FindFirstChild(l__Name__12);
v1["Finisher: " .. l__Name__12] = function(...) --[[ Line: 55 ]]
    -- upvalues: l__LocalPlayer__11 (copy), u7 (copy), l__Debris2__10 (copy), l__TweenService__2 (copy), l__FunctionLibrary__5 (copy), u9 (copy), l__IgnoreInstances__7 (copy), l__Lighting__3 (copy), u8 (copy)
    local v10 = ...;
    local l__Origin__13 = v10.Origin;
    local _ = v10.RespawnTime;
    local l__Parent__14 = l__Origin__13.Parent;
    local v11 = l__Parent__14:FindFirstChild("Humanoid") or l__Parent__14:FindFirstChild("AnimationController");
    v11:SetStateEnabled(Enum.HumanoidStateType.Dead, false);
    local l__Origin__15 = v10.Origin;
    local l__Parent__16 = l__Origin__15.Parent;
    if l__LocalPlayer__11.Character == l__Parent__16 or v10.User == l__LocalPlayer__11.Character then
        local v12 = u7.ScreenGui:Clone();
        v12.Parent = l__LocalPlayer__11.PlayerGui;
        l__Debris2__10:AddItem(v12, 2);
        l__TweenService__2:Create(v12.ImageLabel, TweenInfo.new(0.5, Enum.EasingStyle.Circular, Enum.EasingDirection.Out), {
            ImageTransparency = 1
        }):Play();
        l__FunctionLibrary__5.PlaySound({
            ClientOnly = true,
            Sound = u9.Boom
        });
    end;
    wait(0.2);
    l__FunctionLibrary__5.PlaySound({
        Sound = u9.Lightning,
        Origin = l__Origin__13
    });
    local v13 = Instance.new("Attachment");
    v13.Position = Vector3.new(0, 14.5, 0);
    v13.Parent = l__Origin__15;
    l__Debris2__10:AddItem(v13, 3);
    for _, v14 in ipairs(u7.Electrify:GetChildren()) do
        v14:Clone().Parent = v13;
    end;
    l__FunctionLibrary__5.EmitParticle(v13);
    task.wait(0.25);
    local v15 = Instance.new("Attachment");
    v15.Position = Vector3.new(0, 14.5, 0);
    v15.Parent = l__Origin__15;
    l__Debris2__10:AddItem(v15, 3);
    for _, v16 in ipairs(u7.Strike:GetChildren()) do
        v16:Clone().Parent = v15;
    end;
    l__FunctionLibrary__5.EmitParticle(v15);
    task.spawn(function() --[[ Line: 124 ]]
        -- upvalues: l__Origin__15 (copy), l__IgnoreInstances__7 (ref), l__TweenService__2 (ref), l__Debris2__10 (ref)
        local v17 = Random.new();
        local v18 = l__Origin__15.Position + Vector3.new(0, 40, 0);
        local v19 = v18;
        for v20 = 1, 5 do
            local v21;
            if v20 == 8 then
                v21 = l__Origin__15.Position;
            else
                local v22 = v17:NextNumber(-4, 4);
                v21 = v18 + Vector3.new(v22, -(v20 * 8), v17:NextNumber(-4, 4));
            end;
            local v23 = Instance.new("Part");
            v23.Color = Color3.fromRGB(175, 206, 255);
            v23.Material = Enum.Material.Neon;
            v23.Size = Vector3.new(3, 3, (v21 - v19).Magnitude * 1.15);
            v23.CFrame = CFrame.new(v19, v21) * CFrame.new(0, 0, -((v21 - v19).Magnitude / 2));
            v23.Anchored = true;
            v23.CanCollide = false;
            v23.Parent = l__IgnoreInstances__7;
            l__TweenService__2:Create(v23, TweenInfo.new(0.3, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
                Transparency = 1,
                Size = Vector3.new(0, 0, v23.Size.Z)
            }):Play();
            l__Debris2__10:AddItem(v23, 0.5);
            task.wait();
            v19 = v21;
        end;
    end);
    task.wait();
    task.spawn(function() --[[ Line: 149 ]]
        -- upvalues: l__Parent__14 (copy), l__Parent__16 (copy), l__LocalPlayer__11 (ref), l__Lighting__3 (ref)
        if l__Parent__14 == l__Parent__16 or l__Parent__14 == l__LocalPlayer__11.Character then
            for _, u24 in l__Lighting__3:GetChildren() do
                if u24:IsA("ColorCorrectionEffect") then
                    u24.Enabled = false;
                    task.delay(0.06, function() --[[ Line: 154 ]]
                        -- upvalues: u24 (copy)
                        u24.Enabled = true;
                    end);
                end;
            end;
            local v25 = Instance.new("ColorCorrectionEffect");
            v25.Contrast = 55555;
            v25.Saturation = -1;
            v25.Enabled = true;
            local v26 = Instance.new("ColorCorrectionEffect");
            v26.Brightness = 1;
            v26.Contrast = -55555;
            v26.Saturation = -1;
            v26.Enabled = true;
            v25.Parent = l__Lighting__3;
            task.wait(0.05);
            v25:Destroy();
            v26.Parent = l__Lighting__3;
            task.wait(0.05);
            v26:Destroy();
        end;
    end);
    local v27 = Instance.new("PointLight");
    v27.Color = Color3.fromRGB(79, 155, 255);
    v27.Range = 20;
    v27.Brightness = 9;
    l__Debris2__10:AddItem(v27, 4.95);
    v27.Parent = l__Origin__15;
    l__TweenService__2:Create(v27, TweenInfo.new(3, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
        Brightness = 0
    }):Play();
    local v28 = Instance.new("Attachment");
    v28.Position = Vector3.new(0, -3, 0);
    l__Debris2__10:AddItem(v28, 4.95);
    v28.Parent = l__Origin__15;
    for _, v29 in ipairs(u7.Ground:GetChildren()) do
        v29:Clone().Parent = v28;
    end;
    l__FunctionLibrary__5.EmitParticle(v28);
    local v30 = v11:LoadAnimation(u8);
    v30:Play();
    v30:AdjustSpeed(0.6);
    task.spawn(function() --[[ Line: 202 ]]
        -- upvalues: l__Origin__15 (copy), l__Parent__16 (copy), u7 (ref), l__Debris2__10 (ref), l__TweenService__2 (ref), l__IgnoreInstances__7 (ref)
        l__Origin__15.Anchored = true;
        for _, v31 in pairs(l__Parent__16:GetDescendants()) do
            if v31:IsA("BasePart") or v31:IsA("Decal") then
                v31.Transparency = 1;
            end;
        end;
        for _, v32 in pairs(u7.Bones:GetChildren()) do
            local v33 = l__Parent__16:FindFirstChild(v32.Name);
            if v33 then
                local v34 = v32:Clone();
                v34.CanCollide = false;
                v34.Anchored = false;
                local v35 = Instance.new("WeldConstraint");
                v35.Part0 = v34;
                v35.Part1 = v33;
                v34.CFrame = v33.CFrame;
                v35.Parent = v34;
                local v36 = Instance.new("Highlight");
                v36.FillColor = Color3.fromRGB(255, 255, 255);
                v36.OutlineTransparency = 1;
                v36.FillTransparency = 0;
                v36.Parent = v34;
                l__Debris2__10:AddItem(v34, 4);
                l__TweenService__2:Create(v36, TweenInfo.new(0.6), {
                    FillTransparency = 1
                }):Play();
                l__TweenService__2:Create(v34, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, false, 1.5), {
                    Transparency = 1
                }):Play();
                v34.Parent = l__IgnoreInstances__7;
            end;
        end;
    end);
end;
return v1;