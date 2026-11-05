 

 

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
local l__Living__5 = workspace:WaitForChild("Living");
local l__Anims__6 = l__ReplicatedStorage__1:WaitForChild("Anims");
local l__IgnoreInstances__7 = workspace:WaitForChild("IgnoreInstances");
local l__Objects__8 = l__ReplicatedStorage__1:WaitForChild("Objects");
local l__Sounds__9 = l__ReplicatedStorage__1:WaitForChild("Sounds");
local l__Debris2__10 = require(l__Modules__3:WaitForChild("Debris2"));
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
local l__Name__11 = script.Name;
local u7 = l__Objects__8:FindFirstChild("Finishers"):FindFirstChild(l__Name__11);
local u8 = l__Anims__6:FindFirstChild("Finishers"):FindFirstChild(l__Name__11);
local u9 = l__Sounds__9:FindFirstChild("Finishers"):FindFirstChild(l__Name__11);
v1["Finisher: " .. l__Name__11] = function(...) --[[ Line: 55 ]]
    -- upvalues: l__Modules__3 (copy), l__IgnoreInstances__7 (copy), l__Living__5 (copy), l__FunctionLibrary__4 (copy), u8 (copy), u9 (copy), u7 (copy), l__Debris2__10 (copy), l__TweenService__2 (copy)
    local v10 = ...;
    local l__Origin__12 = v10.Origin;
    local _ = v10.RespawnTime;
    local l__Parent__13 = l__Origin__12.Parent;
    (l__Parent__13:FindFirstChild("Humanoid") or l__Parent__13:FindFirstChild("AnimationController")):SetStateEnabled(Enum.HumanoidStateType.Dead, false);
    local l__Bezier2__14 = require(l__Modules__3:WaitForChild("Bezier2"));
    local l__Origin__15 = v10.Origin;
    local l__Parent__16 = l__Origin__15.Parent;
    local v11 = l__Parent__16:FindFirstChild("Humanoid"):FindFirstChild("Animator");
    local u12 = Random.new();
    local u13 = RaycastParams.new();
    u13.FilterDescendantsInstances = { l__IgnoreInstances__7, l__Living__5 };
    u13.FilterType = Enum.RaycastFilterType.Exclude;
    l__Origin__15.Anchored = true;
    l__FunctionLibrary__4.LoadAnimation({
        Play = true,
        Animator = v11,
        Animation = u8.Flop,
        Priority = Enum.AnimationPriority.Action4
    }):AdjustSpeed(0.85);
    l__FunctionLibrary__4.PlaySound({
        Sound = u9.Hit,
        Origin = l__Origin__15
    });
    local u14 = Instance.new("Highlight");
    u14.DepthMode = Enum.HighlightDepthMode.Occluded;
    u14.FillColor = Color3.fromRGB(255, 0, 0);
    u14.FillTransparency = 0.1;
    u14.OutlineTransparency = 1;
    u14.Parent = l__Parent__16;
    game.Debris:AddItem(u14, 1);
    task.delay(0.04, function() --[[ Line: 127 ]]
        -- upvalues: u14 (copy)
        u14.FillTransparency = 0.55;
    end);
    task.wait(0.025);
    local u15 = {
        "14055813089",
        "14055812962",
        "14055812766",
        "14055812643",
        "14055812520",
        "14055812371",
        "14055812149",
        "14055812003",
        "14055811832",
        "14055811707",
        "14055811549",
        "14055811292",
        "14055811134",
        "14055810915",
        "14055816317"
    };
    for _ = 1, 28 do
        task.spawn(function() --[[ Line: 134 ]]
            -- upvalues: l__Origin__15 (copy), u12 (copy), u13 (copy), l__Bezier2__14 (copy), u7 (ref), l__IgnoreInstances__7 (ref), l__Debris2__10 (ref), l__TweenService__2 (ref), u15 (copy)
            local v16 = workspace;
            local l__Position__17 = l__Origin__15.Position;
            local v17 = u12:NextNumber(-6, 5);
            local v18 = v16:Raycast(l__Position__17 + Vector3.new(v17, 2, u12:NextNumber(-5, 6)), Vector3.new(0, -15, 0), u13);
            local v19 = Vector3.new(v18.Position.X, v18.Position.Y + 0.75, v18.Position.Z);
            local v20 = { l__Origin__15.Position, l__Bezier2__14:Lerp(l__Origin__15.Position, v19, 0.5) + Vector3.new(0, u12:NextNumber(1, 8)), v19 };
            if math.random(1, 5) == 5 then
                local v21 = u7.Start["XP Orb"]:Clone();
                v21.Position = l__Origin__15.Position;
                v21.Parent = l__IgnoreInstances__7;
                l__Debris2__10:AddItem(v21, 6);
                local v22 = v21.Attachment:GetChildren();
                for _, v23 in pairs(v22) do
                    v23.Enabled = true;
                end;
                local v24 = math.random(30, 38);
                for v25 = 1, v24 do
                    v21.Position = l__Bezier2__14:Curve(v20, v25 / v24);
                    task.wait();
                end;
                l__TweenService__2:Create(v21, TweenInfo.new(0.6, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 10, true), {
                    Position = v21.Position + Vector3.new(0, 0.25, 0)
                }):Play();
                task.wait(5);
                local v26 = v21.Attachment:GetChildren();
                for _, v27 in pairs(v26) do
                    v27.Enabled = false;
                end;
            else
                local v28 = u7.Start.Item.Item:Clone();
                v28.BillboardGui.ImageLabel.Image = "rbxassetid://" .. u15[math.random(1, #u15)] .. "";
                v28.Position = l__Origin__15.Position;
                v28.Parent = l__IgnoreInstances__7;
                l__Debris2__10:AddItem(v28, 6);
                local v29 = math.random(23, 30);
                for v30 = 1, v29 do
                    v28.Position = l__Bezier2__14:Curve(v20, v30 / v29);
                    task.wait();
                end;
                local v31 = u7.Start.Item.Shadow:Clone();
                v31.CFrame = v28.CFrame * CFrame.new(0, -1, 0);
                v31.Parent = l__IgnoreInstances__7;
                l__Debris2__10:AddItem(v31, 5.5);
                l__TweenService__2:Create(v28.BillboardGui, TweenInfo.new(0.6, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 10, true), {
                    StudsOffset = Vector3.new(0, 0.25, 0)
                }):Play();
                task.wait(5);
                l__TweenService__2:Create(v28.BillboardGui.ImageLabel, TweenInfo.new(0.6, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                    Size = UDim2.new(0, 0, 0, 0)
                }):Play();
                l__TweenService__2:Create(v31.Decal, TweenInfo.new(0.4), {
                    Transparency = 1
                }):Play();
            end;
        end);
    end;
    task.wait(0.75);
    for _, v32 in pairs(l__Parent__16:GetDescendants()) do
        if v32:IsA("BasePart") then
            if v32.Parent == l__Parent__16 and l__FunctionLibrary__4.BodyParts.All[v32.Name] then
                local v33 = {};
                for _, v34 in pairs(u7.End:GetChildren()) do
                    local v35 = v34:Clone();
                    v35.Parent = v32;
                    l__Debris2__10:AddItem(v35, 4);
                    table.insert(v33, v35);
                    l__FunctionLibrary__4.EmitParticle(v35);
                end;
            end;
            l__TweenService__2:Create(v32, TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                Transparency = 1
            }):Play();
        elseif v32:IsA("Decal") then
            v32.Transparency = 1;
        elseif v32:IsA("ParticleEmitter") or (v32:IsA("Trail") or v32:IsA("Beam")) then
            v32.Enabled = false;
        end;
    end;
end;
return v1;