 

 

local v1 = {};
local l__ReplicatedStorage__1 = game:GetService("ReplicatedStorage");
game:GetService("RunService");
local l__TweenService__2 = game:GetService("TweenService");
game:GetService("Lighting");
l__ReplicatedStorage__1:WaitForChild("Anims");
local l__Modules__3 = l__ReplicatedStorage__1:WaitForChild("Modules");
l__ReplicatedStorage__1:WaitForChild("Objects");
l__ReplicatedStorage__1:WaitForChild("Sounds");
local l__Debris2__4 = require(l__Modules__3.Debris2);
local l__wait__5 = task.wait;
local l__FunctionLibrary__6 = require(l__Modules__3:WaitForChild("FunctionLibrary"));
local _ = l__FunctionLibrary__6.Delay;
local l__Spawn__7 = l__FunctionLibrary__6.Spawn;
local u2 = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, false, 0);
function v1.Fire(p3, p4, p5, p6, ...) --[[ Line: 23 ]]
    -- upvalues: l__TweenService__2 (copy), u2 (copy), l__Debris2__4 (copy), l__FunctionLibrary__6 (copy), l__wait__5 (copy)
    local u7 = ... or {};
    local v8 = {};
    for v9 = 1, p6 do
        local v10 = math.sin(v9 * 360) * p4;
        local v11 = math.cos(v9 * 360) * p4;
        local v12 = Vector3.new(v10, 0, v11) + p3;
        local v13 = RaycastParams.new();
        v13.FilterType = Enum.RaycastFilterType.Exclude;
        v13.FilterDescendantsInstances = { workspace.Living, workspace.IgnoreInstances, workspace.CurrentCamera };
        v13.IgnoreWater = true;
        local v14 = workspace:Raycast(v12, CFrame.new(v12).UpVector * -15, v13);
        if v14 then
            local v15 = v14.Instance or nil;
            local v16 = v14.Position or nil;
            local _ = v14.Normal or nil;
            if v15.Parent:FindFirstChildOfClass("Humanoid") then
                return;
            end;
            if v15 then
                local u17 = Instance.new("Part");
                u17.Anchored = true;
                u17.CanCollide = false;
                u17.BottomSurface = Enum.SurfaceType.Smooth;
                u17.TopSurface = Enum.SurfaceType.Smooth;
                u17.Size = Vector3.new(p5, p5, p5);
                u17.Position = p3;
                local v18 = math.random(-360, 360);
                local v19 = math.random(-360, 360);
                u17.Rotation = Vector3.new(v18, v19, math.random(-360, 360));
                local u20 = l__TweenService__2:Create(u17, u2, {
                    Position = v16
                });
                u20:Play();
                u17.Transparency = 0;
                u17.Color = v15.Color;
                u17.Material = v15.Material;
                u17.Parent = workspace.IgnoreInstances;
                v8[v9] = u17;
                l__Debris2__4:AddItem(u17, 2);
                l__FunctionLibrary__6.Spawn(function() --[[ Line: 55 ]]
                    -- upvalues: u7 (copy), u20 (copy), u17 (copy)
                    if u7.NoSmoke then
                    else
                        u20.Completed:wait();
                        local v21 = script.Smoke:Clone();
                        v21.Color = ColorSequence.new(u17.Color);
                        v21.Parent = u17;
                        v21:Emit(8);
                        game.Debris:AddItem(v21, v21.Lifetime.Max / v21.TimeScale);
                    end;
                end);
            end;
        end;
    end;
    l__wait__5(1.5);
    if #v8 > 0 then
        for _, v22 in ipairs(v8) do
            v22.Anchored = false;
        end;
    end;
end;
function v1.Line(u23, u24, u25, u26, ...) --[[ Line: 79 ]]
    -- upvalues: l__Spawn__7 (copy), l__Debris2__4 (copy), l__TweenService__2 (copy), u2 (copy), l__FunctionLibrary__6 (copy), l__wait__5 (copy)
    local u27 = ... or {};
    local u28 = 1;
    l__Spawn__7(function() --[[ Line: 83 ]]
        -- upvalues: u24 (copy), u28 (copy), u26 (copy), u23 (copy), u25 (copy), l__Debris2__4 (ref), l__TweenService__2 (ref), u2 (ref), l__FunctionLibrary__6 (ref), u27 (copy), l__wait__5 (ref)
        local v29 = u28 == 2 and -1 or u24;
        local v30 = {};
        for v31 = 1, u26 do
            local l__Position__8 = (u23 * CFrame.new(v29 * (v31 * 0.5), 0, -v31 * 5)).Position;
            local v32 = CFrame.new(l__Position__8).UpVector * -15;
            local v33 = RaycastParams.new();
            v33.FilterDescendantsInstances = { workspace.Living, workspace.IgnoreInstances, workspace.CurrentCamera };
            v33.FilterType = Enum.RaycastFilterType.Exclude;
            v33.IgnoreWater = true;
            local v34 = game.Workspace:Raycast(l__Position__8, v32, v33);
            if v34 then
                local v35 = v34.Instance or nil;
                local v36 = v34.Position or nil;
                local _ = v34.Normal or nil;
                if v35 then
                    local u37 = Instance.new("Part");
                    u37.Anchored = true;
                    u37.CanCollide = false;
                    u37.BottomSurface = Enum.SurfaceType.Smooth;
                    u37.TopSurface = Enum.SurfaceType.Smooth;
                    u37.Size = Vector3.new(u25, u25, u25);
                    u37.Position = v36 - Vector3.new(0, u25 / 2, 0);
                    u37.Anchored = true;
                    local v38 = math.random(-360, 360);
                    local v39 = math.random(-360, 360);
                    u37.Rotation = Vector3.new(v38, v39, math.random(-360, 360));
                    u37.Transparency = 0;
                    u37.Color = v35.Color;
                    u37.Material = v35.Material;
                    u37.Parent = workspace.IgnoreInstances;
                    v30[v31] = u37;
                    l__Debris2__4:AddItem(u37, 2);
                    local u40 = l__TweenService__2:Create(u37, u2, {
                        Position = v36
                    });
                    u40:Play();
                    l__FunctionLibrary__6.Spawn(function() --[[ Line: 122 ]]
                        -- upvalues: u27 (ref), u40 (copy), u37 (copy)
                        if u27.NoSmoke then
                        else
                            u40.Completed:wait();
                            local v41 = script.Smoke:Clone();
                            v41.Color = ColorSequence.new(u37.Color);
                            v41.Parent = u37;
                            v41:Emit(8);
                            game.Debris:AddItem(v41, v41.Lifetime.Max / v41.TimeScale);
                        end;
                    end);
                end;
            end;
            l__wait__5(0.01);
        end;
        l__wait__5(1.5);
        if #v30 > 0 then
            for _, v42 in ipairs(v30) do
                v42.Anchored = false;
                l__wait__5();
            end;
        end;
    end);
    local u43 = 2;
    l__Spawn__7(function() --[[ Line: 83 ]]
        -- upvalues: u24 (copy), u43 (copy), u26 (copy), u23 (copy), u25 (copy), l__Debris2__4 (ref), l__TweenService__2 (ref), u2 (ref), l__FunctionLibrary__6 (ref), u27 (copy), l__wait__5 (ref)
        local v44 = u43 == 2 and -1 or u24;
        local v45 = {};
        for v46 = 1, u26 do
            local l__Position__9 = (u23 * CFrame.new(v44 * (v46 * 0.5), 0, -v46 * 5)).Position;
            local v47 = CFrame.new(l__Position__9).UpVector * -15;
            local v48 = RaycastParams.new();
            v48.FilterDescendantsInstances = { workspace.Living, workspace.IgnoreInstances, workspace.CurrentCamera };
            v48.FilterType = Enum.RaycastFilterType.Exclude;
            v48.IgnoreWater = true;
            local v49 = game.Workspace:Raycast(l__Position__9, v47, v48);
            if v49 then
                local v50 = v49.Instance or nil;
                local v51 = v49.Position or nil;
                local _ = v49.Normal or nil;
                if v50 then
                    local u52 = Instance.new("Part");
                    u52.Anchored = true;
                    u52.CanCollide = false;
                    u52.BottomSurface = Enum.SurfaceType.Smooth;
                    u52.TopSurface = Enum.SurfaceType.Smooth;
                    u52.Size = Vector3.new(u25, u25, u25);
                    u52.Position = v51 - Vector3.new(0, u25 / 2, 0);
                    u52.Anchored = true;
                    local v53 = math.random(-360, 360);
                    local v54 = math.random(-360, 360);
                    u52.Rotation = Vector3.new(v53, v54, math.random(-360, 360));
                    u52.Transparency = 0;
                    u52.Color = v50.Color;
                    u52.Material = v50.Material;
                    u52.Parent = workspace.IgnoreInstances;
                    v45[v46] = u52;
                    l__Debris2__4:AddItem(u52, 2);
                    local u55 = l__TweenService__2:Create(u52, u2, {
                        Position = v51
                    });
                    u55:Play();
                    l__FunctionLibrary__6.Spawn(function() --[[ Line: 122 ]]
                        -- upvalues: u27 (ref), u55 (copy), u52 (copy)
                        if u27.NoSmoke then
                        else
                            u55.Completed:wait();
                            local v56 = script.Smoke:Clone();
                            v56.Color = ColorSequence.new(u52.Color);
                            v56.Parent = u52;
                            v56:Emit(8);
                            game.Debris:AddItem(v56, v56.Lifetime.Max / v56.TimeScale);
                        end;
                    end);
                end;
            end;
            l__wait__5(0.01);
        end;
        l__wait__5(1.5);
        if #v45 > 0 then
            for _, v57 in ipairs(v45) do
                v57.Anchored = false;
                l__wait__5();
            end;
        end;
    end);
end;
return v1;