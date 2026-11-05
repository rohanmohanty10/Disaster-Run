 
local v0 = {
    EFP = game.Workspace.Thrown
};
local v1 = require(script.BoatTween);
local l_TweenService_0 = game:GetService("TweenService");
v0.ProcessPart = function(v3) --[[ Line: 21 ]]
    local l_Maid_0 = v3.Maid;
    local l_FX_0 = v3.FX;
    local l_Part_0 = v3.Part;
    local v7 = v3.Debri or 10;
    local v8 = l_Maid_0:give(l_FX_0:Clone());
    for _, v10 in pairs(v8:GetChildren()) do
        l_Maid_0:give(v10);
        game.Debris:AddItem(v10, v7);
        v10.Parent = l_Part_0;
    end;
end;
v0.PlayTween = function(v11, v12, v13) --[[ Line: 35 ]]
    -- upvalues: v1 (copy)
    local v14 = v1:Create(v11, v12);
    v14:Play();
    local v15 = v14.Completed:Once(function() --[[ Line: 39 ]]
        -- upvalues: v13 (copy), v14 (copy)
        if v13 then
            v13();
        end;
        v14:Destroy();
    end);
    task.delay(v12.Time, function() --[[ Line: 45 ]]
        -- upvalues: v15 (copy), v14 (copy)
        v15:Disconnect();
        v14:Destroy();
    end);
    return v14;
end;
v0.Maid = require(script.Maid);
v0.Bezier = require(script.Bezier);
v0.Impact = function(v16) --[[ Line: 57 ]]
    local v17 = v16:Clone();
    v17.Parent = game.Lighting;
    delay(0.1, function() --[[ Line: 60 ]]
        -- upvalues: v17 (copy)
        v17:Destroy();
    end);
end;
v0.ChangeParticleColor = function(v18) --[[ Line: 66 ]]
    local l_Particle_0 = v18.Particle;
    local l_Color_0 = v18.Color;
    local v21 = v18.Position or v18.Pos;
    local v22 = {};
    if l_Particle_0:IsA("ParticleEmitter") then
        table.insert(v22, l_Particle_0);
    else
        for _, v24 in pairs(l_Particle_0:GetDescendants()) do
            if v24:IsA("ParticleEmitter") then
                table.insert(v22, v24);
            end;
        end;
    end;
    for _, v26 in pairs(v22) do
        if l_Color_0 then
            local v27 = {
                ColorSequenceKeypoint.new(0, l_Color_0), 
                ColorSequenceKeypoint.new(1, l_Color_0)
            };
            v26.Color = ColorSequence.new(v27);
        else
            local v28 = Ray.new(v21, (Vector3.new(0, -100, 0, 0)));
            local l_PartOnRayWithWhitelist_0 = game.Workspace:FindPartOnRayWithWhitelist(v28, {
                workspace.Built, 
                workspace.Map
            });
            if l_PartOnRayWithWhitelist_0 then
                local v30 = {
                    ColorSequenceKeypoint.new(0, l_PartOnRayWithWhitelist_0.Color), 
                    ColorSequenceKeypoint.new(1, l_PartOnRayWithWhitelist_0.Color)
                };
                v26.Color = ColorSequence.new(v30);
            end;
        end;
    end;
end;
local v31 = RaycastParams.new();
v31.FilterType = Enum.RaycastFilterType.Include;
v31.FilterDescendantsInstances = { 
    workspace.Map
};
v0.SetSmoke = function(v32) --[[ Line: 110 ]]
    -- upvalues: v31 (copy)
    local l_FX_1 = v32.FX;
    local v34 = v32.Dist or 20;
    local l_Anchor_0 = v32.Anchor;
    local v36 = game.Workspace:Raycast(l_Anchor_0.Position, Vector3.new(0, -v34, 0), v31);
    if v36 then
        local v37 = {
            ColorSequenceKeypoint.new(0, v36.Instance.Color), 
            ColorSequenceKeypoint.new(1, v36.Instance.Color)
        };
        for _, v39 in pairs(l_FX_1:GetDescendants()) do
            if v39:IsA("ParticleEmitter") then
                v39.Color = ColorSequence.new(v37);
            end;
        end;
        return v36;
    else
        return;
    end;
end;
v0.BindScale = function(v40) --[[ Line: 132 ]]
    local l_FX_2 = v40.FX;
    local l_Maid_1 = v40.Maid;
    local v43 = v40.Init or 1;
    local v44 = l_Maid_1:give(Instance.new("NumberValue"));
    v44.Value = v43;
    v44:giveTask(v44.Changed:Connect(function() --[[ Line: 139 ]]
        -- upvalues: l_FX_2 (copy), v44 (copy)
        l_FX_2:ScaleTo(v44.Value);
    end));
    return v44;
end;
v0.Able = function(v45) --[[ Line: 146 ]]
    local l_FX_3 = v45.FX;
    local l_On_0 = v45.On;
    local l_name_0 = v45.name;
    if l_On_0 then
        for _, v50 in pairs(l_FX_3:GetDescendants()) do
            if v50:IsA("ParticleEmitter") then
                if l_name_0 then
                    if v50:GetAttribute(l_name_0) then
                        v50.Enabled = true;
                    end;
                else
                    v50.Enabled = true;
                end;
            end;
        end;
        return;
    else
        for _, v52 in pairs(l_FX_3:GetDescendants()) do
            if v52:IsA("ParticleEmitter") then
                if l_name_0 then
                    if v52:GetAttribute(l_name_0) then
                        v52.Enabled = false;
                    end;
                else
                    v52.Enabled = false;
                end;
            end;
        end;
        return;
    end;
end;
v0.WeldObject = function(...) --[[ Line: 179 ]]
    -- upvalues: l_TweenService_0 (copy)
    local v53, v54, v55, v56, v57, v58 = ...;
    local v59 = v53:Clone();
    local l_Weld_0 = Instance.new("Weld");
    l_Weld_0.Parent = v54;
    l_Weld_0.Part1 = v59.PrimaryPart;
    l_Weld_0.Part0 = v54;
    v59.Parent = v54.Parent;
    v59.Name = "ModuleWelded";
    if v55 then
        for _, v62 in pairs(v59:GetDescendants()) do
            if v62:IsA("ParticleEmitter") or v62:IsA("Trail") then
                task.delay(v55, function() --[[ Line: 195 ]]
                    -- upvalues: v62 (copy), v59 (copy)
                    v62.Enabled = false;
                    task.wait(2);
                    v59:Destroy();
                end);
            end;
        end;
        return;
    elseif v58 then
        task.delay(v57, function() --[[ Line: 205 ]]
            -- upvalues: v59 (copy)
            for _, v64 in pairs(v59:GetDescendants()) do
                if v64:IsA("BasePart") then
                    v64.Transparency = 1;
                end;
            end;
            for _, v66 in pairs(v59:GetDescendants()) do
                if v66:IsA("ParticleEmitter") and v66.Enabled == true or v66:IsA("Beam") or v66:IsA("Texture") or v66:IsA("Decal") then
                    v66:Destroy();
                end;
            end;
            for _, v68 in pairs(v59:GetDescendants()) do
                if v68:IsA("ParticleEmitter") then
                    v68:Emit(v68:GetAttribute("EmitCount"));
                end;
            end;
            task.wait(3);
            v59:Destroy();
        end);
        return;
    elseif v57 then
        task.delay(v57, function() --[[ Line: 219 ]]
            -- upvalues: v59 (copy)
            v59:Destroy();
        end);
        return;
    else
        if v56 then
            task.delay(v56, function() --[[ Line: 224 ]]
                -- upvalues: l_Weld_0 (copy), v59 (copy), l_TweenService_0 (ref)
                l_Weld_0:Destroy();
                v59.Parent = workspace.Effects;
                task.wait(0.08);
                for _, v70 in pairs(v59:GetDescendants()) do
                    if v70:IsA("BasePart") then
                        v70.CanCollide = true;
                    end;
                end;
                for _, v72 in pairs(v59:GetDescendants()) do
                    if v72:IsA("ParticleEmitter") then
                        v72.Enabled = false;
                    end;
                end;
                task.wait(1.5);
                for _, v74 in pairs(v59:GetDescendants()) do
                    if v74:IsA("BasePart") then
                        l_TweenService_0:Create(v74, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
                            Transparency = 1
                        }):Play();
                    end;
                end;
                task.wait(0.5);
                v59:Destroy();
            end);
        end;
        return;
    end;
end;
v0.QuickWeld = function(v75) --[[ Line: 245 ]]
    -- upvalues: v0 (copy)
    local l_FX_4 = v75.FX;
    local v77 = v75.C0 or CFrame.new(0, 0, 0);
    local l_P_0 = v75.P;
    local l_Maid_2 = v75.Maid;
    l_FX_4 = l_FX_4:Clone();
    task.delay(35, function() --[[ Line: 253 ]]
        -- upvalues: l_FX_4 (ref)
        if l_FX_4 and l_FX_4.Parent then
            l_FX_4:Destroy("");
        end;
    end);
    local l_Weld_1 = Instance.new("Weld");
    if l_FX_4:IsA("Model") then
        l_Weld_1.Part0 = l_FX_4.PrimaryPart;
    else
        l_Weld_1.Part0 = l_FX_4;
        l_FX_4.CanCollide = false;
        l_FX_4.Massless = true;
        l_FX_4.Anchored = false;
    end;
    l_Weld_1.Part1 = l_P_0;
    l_Weld_1.C0 = v77;
    l_Weld_1.Parent = l_FX_4;
    l_FX_4.Parent = v0.EFP;
    l_Maid_2:give(l_FX_4);
    l_Weld_1.Name = "FXWELD";
    return l_FX_4, l_Weld_1;
end;
v0.QuickFX = function(v81) --[[ Line: 284 ]]
    -- upvalues: v31 (copy), v0 (copy)
    local l_FX_5 = v81.FX;
    local l_Anchor_1 = v81.Anchor;
    local l_Maid_3 = v81.Maid;
    if v81.Ray then
        local v85 = game.Workspace:Raycast(l_Anchor_1.Position, Vector3.new(0, -10, 0, 0), v31);
        if v85 then
            local v86, v87, v88 = l_Anchor_1:ToOrientation();
            l_Anchor_1 = CFrame.new(v85.Position) * CFrame.Angles(v86, v87, v88);
        else
            return;
        end;
    end;
    l_FX_5 = l_FX_5:Clone();
    if l_FX_5:IsA("Model") then
        l_FX_5:PivotTo(l_Anchor_1);
    elseif l_FX_5:IsA("BasePart") then
        l_FX_5.CFrame = l_Anchor_1;
    end;
    if l_FX_5:IsA("Attachment") then
        l_FX_5.Parent = l_Anchor_1;
    else
        l_FX_5.Parent = v0.EFP;
    end;
    l_Maid_3:give(l_FX_5);
    return l_FX_5;
end;
v0.LifeScale = function(v89) --[[ Line: 321 ]]
    local l_FX_6 = v89.FX;
    local l_Scale_0 = v89.Scale;
    for _, v93 in pairs(l_FX_6:GetDescendants()) do
        if v93:IsA("ParticleEmitter") then
            v93.Lifetime = NumberRange.new(v93.Lifetime.Min * l_Scale_0, v93.Lifetime.Max * l_Scale_0);
        end;
    end;
end;
v0.dtwait = function(v94) --[[ Line: 333 ]]
    local v95 = 0;
    while v95 < v94 do
        v95 = v95 + game:GetService("RunService").Heartbeat:Wait();
    end;
    return v95;
end;
v0.RaiseZIndex = function(v96) --[[ Line: 343 ]]
    local l_FX_7 = v96.FX;
    local l_Count_0 = v96.Count;
    for _, v100 in pairs(l_FX_7:GetDescendants()) do
        if v100:IsA("ParticleEmitter") then
            v100.ZOffset = v100.ZOffset + l_Count_0;
        end;
    end;
end;
v0.WeldObject = function(...) --[[ Line: 354 ]]
    -- upvalues: l_TweenService_0 (copy)
    local v101, v102, v103, v104, v105, v106 = ...;
    local v107 = v101:Clone();
    local l_Weld_2 = Instance.new("Weld");
    l_Weld_2.Parent = v102;
    l_Weld_2.Part1 = v107.PrimaryPart;
    l_Weld_2.Part0 = v102;
    v107.Parent = v102.Parent;
    v107.Name = "ModuleWelded";
    if v103 then
        for _, v110 in pairs(v107:GetDescendants()) do
            if v110:IsA("ParticleEmitter") or v110:IsA("Trail") then
                task.delay(v103, function() --[[ Line: 370 ]]
                    -- upvalues: v110 (copy), v107 (copy)
                    v110.Enabled = false;
                    task.wait(2);
                    v107:Destroy();
                end);
            end;
        end;
        return;
    elseif v106 then
        task.delay(v105, function() --[[ Line: 380 ]]
            -- upvalues: v107 (copy)
            for _, v112 in pairs(v107:GetDescendants()) do
                if v112:IsA("BasePart") then
                    v112.Transparency = 1;
                end;
            end;
            for _, v114 in pairs(v107:GetDescendants()) do
                if v114:IsA("ParticleEmitter") and v114.Enabled == true or v114:IsA("Beam") or v114:IsA("Texture") or v114:IsA("Decal") then
                    v114:Destroy();
                end;
            end;
            for _, v116 in pairs(v107:GetDescendants()) do
                if v116:IsA("ParticleEmitter") then
                    v116:Emit(v116:GetAttribute("EmitCount"));
                end;
            end;
            task.wait(3);
            v107:Destroy();
        end);
        return;
    elseif v105 then
        task.delay(v105, function() --[[ Line: 394 ]]
            -- upvalues: v107 (copy)
            v107:Destroy();
        end);
        return;
    else
        if v104 then
            task.delay(v104, function() --[[ Line: 399 ]]
                -- upvalues: l_Weld_2 (copy), v107 (copy), l_TweenService_0 (ref)
                l_Weld_2:Destroy();
                v107.Parent = workspace.Effects;
                task.wait(0.08);
                for _, v118 in pairs(v107:GetDescendants()) do
                    if v118:IsA("BasePart") then
                        v118.CanCollide = true;
                    end;
                end;
                for _, v120 in pairs(v107:GetDescendants()) do
                    if v120:IsA("ParticleEmitter") then
                        v120.Enabled = false;
                    end;
                end;
                task.wait(1.5);
                for _, v122 in pairs(v107:GetDescendants()) do
                    if v122:IsA("BasePart") then
                        l_TweenService_0:Create(v122, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
                            Transparency = 1
                        }):Play();
                    end;
                end;
                task.wait(0.5);
                v107:Destroy();
            end);
        end;
        return;
    end;
end;
v0.PlayAttachment = function(v123, v124, v125) --[[ Line: 420 ]]
    -- upvalues: v31 (copy), v0 (copy)
    local v126 = nil;
    if not v123:IsA("Part") and v123:IsA("Model") then
        v126 = v123.PrimaryPart;
    end;
    local v127 = false;
    if v126 then
        v127 = game.Workspace:Raycast(v126.Position, Vector3.new(0, -10, 0, 0), v31) and true or false;
    end;
    for _, v129 in pairs(v123:GetDescendants()) do
        if v129:IsA("ParticleEmitter") then
            local l_v129_Attributes_0 = v129:GetAttributes();
            local l_EmitDelay_0 = l_v129_Attributes_0.EmitDelay;
            local v132 = l_v129_Attributes_0.RepeatCount or 1;
            local l_RepeatDelay_0 = l_v129_Attributes_0.RepeatDelay;
            local l_v132_0 = v132 --[[ copy: 12 -> 14 ]];
            local l_l_EmitDelay_0_0 = l_EmitDelay_0 --[[ copy: 11 -> 15 ]];
            local l_l_v129_Attributes_0_0 = l_v129_Attributes_0 --[[ copy: 10 -> 16 ]];
            local l_l_RepeatDelay_0_0 = l_RepeatDelay_0 --[[ copy: 13 -> 17 ]];
            task.spawn(function() --[[ Line: 447 ]]
                -- upvalues: l_v132_0 (copy), l_l_EmitDelay_0_0 (copy), v129 (copy), l_l_v129_Attributes_0_0 (copy), l_l_RepeatDelay_0_0 (copy)
                for _ = 1, l_v132_0 do
                    if l_l_EmitDelay_0_0 then
                        task.delay(l_l_EmitDelay_0_0, function() --[[ Line: 450 ]]
                            -- upvalues: v129 (ref), l_l_v129_Attributes_0_0 (ref)
                            v129:Emit(l_l_v129_Attributes_0_0.EmitCount);
                            if l_l_v129_Attributes_0_0.EmitDuration then
                                v129.Enabled = true;
                                task.delay(l_l_v129_Attributes_0_0.EmitDuration, function() --[[ Line: 455 ]]
                                    -- upvalues: v129 (ref)
                                    v129.Enabled = false;
                                end);
                            end;
                        end);
                    else
                        v129:Emit(l_l_v129_Attributes_0_0.EmitCount);
                        if l_l_v129_Attributes_0_0.EmitDuration then
                            v129.Enabled = true;
                            task.delay(l_l_v129_Attributes_0_0.EmitDuration, function() --[[ Line: 468 ]]
                                -- upvalues: v129 (ref)
                                v129.Enabled = false;
                            end);
                        end;
                    end;
                    if l_l_RepeatDelay_0_0 then
                        task.wait(l_l_RepeatDelay_0_0);
                    end;
                end;
            end);
        end;
        if v129:IsA("PointLight") and v124 then
            v0.PlayTween(v129, {
                EasingStyle = "Sine", 
                Time = v124, 
                Goal = {
                    Brightness = 0
                }
            });
        end;
        if v129:IsA("Beam") then
            local l_v129_Attributes_1 = v129:GetAttributes();
            local l_Duration_0 = l_v129_Attributes_1.Duration;
            local v141 = 0.5;
            if v125 and v125.TweenTime then
                v141 = v125.TweenTime;
            end;
            do
                local l_v141_0 = v141;
                local function v143() --[[ Line: 505 ]] --[[ Name: Shut_OFF ]]
                    -- upvalues: v129 (copy), l_v141_0 (ref)
                    game:GetService("TweenService"):Create(v129, TweenInfo.new(l_v141_0, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                        Width1 = 0, 
                        Width0 = 0
                    }):Play();
                end;
                (function() --[[ Line: 509 ]] --[[ Name: Turn_ON ]]
                    -- upvalues: v129 (copy), l_v141_0 (ref), l_v129_Attributes_1 (copy)
                    game:GetService("TweenService"):Create(v129, TweenInfo.new(l_v141_0, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                        Width1 = l_v129_Attributes_1.Width1, 
                        Width0 = l_v129_Attributes_1.Width0
                    }):Play();
                end)();
                if l_Duration_0 then
                    task.delay(l_Duration_0, function() --[[ Line: 517 ]]
                        -- upvalues: v143 (copy)
                        v143();
                    end);
                end;
            end;
        end;
    end;
    if v124 then
        game.Debris:AddItem(v123, v124);
    end;
end;
v0.Yield = function(v144) --[[ Line: 533 ]]
    -- upvalues: v0 (copy)
    local v145 = v144.Time or 5;
    local l_Char_0 = v144.Char;
    local l_Event_0 = v144.Event;
    local v148 = tick();
    while true do
        if tick() - v148 < v145 then
            local l_l_Char_0_FirstChild_0 = l_Char_0:FindFirstChild(l_Event_0);
            if l_l_Char_0_FirstChild_0 then
                return l_l_Char_0_FirstChild_0;
            else
                v0.dtwait(0.01);
            end;
        else
            return;
        end;
    end;
end;
v0.PlayAttachment = function(v150, v151, v152) --[[ Line: 547 ]]
    -- upvalues: v0 (copy)
    for _, v154 in pairs(v150:GetDescendants()) do
        if v154:IsA("ParticleEmitter") then
            local l_v154_Attributes_0 = v154:GetAttributes();
            local l_EmitDelay_1 = l_v154_Attributes_0.EmitDelay;
            if l_EmitDelay_1 then
                local l_l_v154_Attributes_0_0 = l_v154_Attributes_0 --[[ copy: 8 -> 12 ]];
                task.delay(l_EmitDelay_1, function() --[[ Line: 554 ]]
                    -- upvalues: v154 (copy), l_l_v154_Attributes_0_0 (copy)
                    v154:Emit(l_l_v154_Attributes_0_0.EmitCount);
                end);
            else
                v154:Emit(l_v154_Attributes_0.EmitCount);
                if l_v154_Attributes_0.EmitDuration then
                    v154.Enabled = true;
                    task.delay(l_v154_Attributes_0.EmitDuration, function() --[[ Line: 562 ]]
                        -- upvalues: v154 (copy)
                        v154.Enabled = false;
                    end);
                end;
            end;
        end;
        if v154:IsA("PointLight") and v151 then
            v0.PlayTween(v154, {
                EasingStyle = "Sine", 
                Time = v151, 
                Goal = {
                    Brightness = 0
                }
            });
        end;
        if v154:IsA("Beam") then
            local l_v154_Attributes_1 = v154:GetAttributes();
            local l_Duration_1 = l_v154_Attributes_1.Duration;
            local v160 = 0.5;
            if v152 and v152.TweenTime then
                v160 = v152.TweenTime;
            end;
            do
                local l_v160_0 = v160;
                local function v162() --[[ Line: 589 ]] --[[ Name: Shut_OFF ]]
                    -- upvalues: v154 (copy), l_v160_0 (ref)
                    game:GetService("TweenService"):Create(v154, TweenInfo.new(l_v160_0, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                        Width1 = 0, 
                        Width0 = 0
                    }):Play();
                end;
                (function() --[[ Line: 593 ]] --[[ Name: Turn_ON ]]
                    -- upvalues: v154 (copy), l_v160_0 (ref), l_v154_Attributes_1 (copy)
                    game:GetService("TweenService"):Create(v154, TweenInfo.new(l_v160_0, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                        Width1 = l_v154_Attributes_1.Width1, 
                        Width0 = l_v154_Attributes_1.Width0
                    }):Play();
                end)();
                if l_Duration_1 then
                    task.delay(l_Duration_1, function() --[[ Line: 601 ]]
                        -- upvalues: v162 (copy)
                        v162();
                    end);
                end;
            end;
        end;
    end;
    if v151 then
        game.Debris:AddItem(v150, v151);
    end;
end;
v0.FastSpawn = require(script.FastSpawn);
v0.RandomRot = function() --[[ Line: 619 ]]
    return CFrame.Angles(0, math.rad((math.random(-360, 360))), 0);
end;
v0.PlayMesh = function(v163) --[[ Line: 623 ]]
    -- upvalues: v0 (copy)
    task.spawn(function() --[[ Line: 624 ]]
        -- upvalues: v163 (copy), v0 (ref)
        local l_Model_0 = v163.Model;
        local v165 = v163.Info or TweenInfo.new(1, Enum.EasingStyle.Sine);
        local l_Start_0 = l_Model_0:FindFirstChild("Start");
        local l_End_0 = l_Model_0:FindFirstChild("End");
        local l_Stay_0 = v163.Stay;
        local l_Anchor_2 = v163.Anchor;
        local v170 = v163.EndT or 1;
        local l_Del_0 = v163.Del;
        local l_Skip_0 = v163.Skip;
        if l_Start_0 and l_End_0 then
            l_Model_0.PrimaryPart = l_Start_0;
            if not l_Skip_0 then
                for _, v174 in pairs(l_Model_0:GetChildren()) do
                    if v174:IsA("BasePart") then
                        v174.CanCollide = false;
                        v174.Anchored = true;
                    end;
                end;
            end;
            if l_Anchor_2 then
                l_Model_0:SetPrimaryPartCFrame(l_Anchor_2);
            end;
            if v163.T then
                l_Start_0.Transparency = v163.T;
            end;
            l_End_0.Transparency = 1;
            l_Model_0.Parent = v0.EFP;
            local l_Decal_0 = l_Start_0:FindFirstChildOfClass("Decal");
            local l_SpecialMesh_0 = l_Start_0:FindFirstChildOfClass("SpecialMesh");
            local l_SpecialMesh_1 = l_End_0:FindFirstChildOfClass("SpecialMesh");
            local l_Decal_1 = l_End_0:FindFirstChildOfClass("Decal");
            if l_Decal_1 and not l_Skip_0 then
                l_Decal_1.Transparency = 1;
            end;
            local v179 = nil;
            if l_Del_0 then
                game:GetService("TweenService"):Create(l_Start_0, v165, {
                    Size = l_End_0.Size, 
                    CFrame = l_End_0.CFrame
                }):Play();
                task.delay(l_Del_0, function() --[[ Line: 668 ]]
                    -- upvalues: v179 (ref), l_Start_0 (copy), v165 (copy), v170 (copy), l_Decal_0 (copy), l_SpecialMesh_0 (copy), l_SpecialMesh_1 (copy)
                    v179 = game:GetService("TweenService"):Create(l_Start_0, v165, {
                        Transparency = v170
                    });
                    v179:Play();
                    if l_Decal_0 then
                        for _, v181 in pairs(l_Start_0:GetChildren()) do
                            if v181:IsA("Decal") then
                                game:GetService("TweenService"):Create(v181, v165, {
                                    Transparency = v170
                                }):Play();
                            end;
                        end;
                    end;
                    if l_SpecialMesh_0 then
                        v179 = game:GetService("TweenService"):Create(l_SpecialMesh_0, v165, {
                            Scale = l_SpecialMesh_1.Scale
                        }):Play();
                    end;
                end);
            else
                if l_SpecialMesh_0 then
                    game:GetService("TweenService"):Create(l_SpecialMesh_0, v165, {
                        Scale = l_SpecialMesh_1.Scale
                    }):Play();
                end;
                if l_Decal_0 then
                    for _, v183 in pairs(l_Start_0:GetChildren()) do
                        if v183:IsA("Decal") then
                            game:GetService("TweenService"):Create(v183, v165, {
                                Transparency = v170
                            }):Play();
                        end;
                    end;
                    v179 = game:GetService("TweenService"):Create(l_Start_0, v165, {
                        Size = l_End_0.Size, 
                        CFrame = l_End_0.CFrame
                    });
                    v179:Play();
                else
                    v179 = game:GetService("TweenService"):Create(l_Start_0, v165, {
                        Size = l_End_0.Size, 
                        Transparency = v170, 
                        CFrame = l_End_0.CFrame
                    });
                    v179:Play();
                end;
            end;
            if not l_Stay_0 then
                if l_Del_0 then
                    task.wait(l_Del_0 + 0.1);
                end;
                v179.Completed:Connect(function() --[[ Line: 711 ]]
                    -- upvalues: l_Model_0 (copy)
                    l_Model_0:Destroy();
                end);
            end;
            return;
        else
            warn("NO START OR END");
            return;
        end;
    end);
end;
v0.PlayFlipBook = function(v184) --[[ Line: 721 ]]
    -- upvalues: v0 (copy)
    local l_Mesh_0 = v184.Mesh;
    local v186 = v184.Delta or 0.02;
    local l_DWC_0 = v184.DWC;
    local v188 = v184.Repeat or 1;
    local v189 = v184.FPS or 1;
    local _ = v184.Loop;
    local l_Folder_0 = l_Mesh_0:FindFirstChild("Folder");
    local l_Decal_2 = l_Mesh_0:FindFirstChild("Decal");
    if l_DWC_0 == nil then
        l_DWC_0 = true;
    end;
    if l_Folder_0 and l_Decal_2 then
        v0.FastSpawn(function() --[[ Line: 738 ]]
            -- upvalues: v188 (copy), l_Mesh_0 (copy), l_Folder_0 (copy), v189 (copy), l_Decal_2 (copy), v186 (copy), v0 (ref), l_DWC_0 (ref)
            for _ = 1, v188 do
                if l_Mesh_0:IsDescendantOf(game.Workspace) then
                    for v194 = 1, #l_Folder_0:GetChildren(), v189 do
                        local v195 = l_Folder_0:FindFirstChild((tostring(v194))) or l_Folder_0:GetChildren()[#l_Folder_0:GetChildren()];
                        if v195 then
                            l_Decal_2.Texture = v195.Texture;
                        end;
                        if v186 == "Step" then
                            game:GetService("RunService").RenderStepped:Wait();
                        else
                            v0.dtwait(v186);
                        end;
                    end;
                else
                    break;
                end;
            end;
            if l_DWC_0 and l_DWC_0 ~= false then
                l_Mesh_0:Destroy();
            end;
        end);
    end;
end;
local v196 = require(script.CameraShaker);
local l_Camera_0 = game.Workspace.Camera;
local function v199(v198) --[[ Line: 770 ]] --[[ Name: ShakeCamera ]]
    -- upvalues: l_Camera_0 (copy)
    l_Camera_0.CFrame = l_Camera_0.CFrame * v198;
end;
local v200 = Enum.RenderPriority.Camera.Value + 1;
local v201 = v196.new(v200, v199);
local _ = game:GetService("RunService");
v0.CamShake = function(v203, v204, v205) --[[ Line: 781 ]]
    -- upvalues: v196 (copy), v201 (copy)
    if game:GetService("RunService"):IsClient() and _G.ServerRunning then
        if v203 == "Stop" then
            v196:Stop();
            return;
        else
            v196:Stop();
            local v206 = true;
            if v205 and v205 < (game.Workspace.CurrentCamera.CFrame.Position - v204).Magnitude then
                v206 = false;
            end;
            if v206 then
                v201:Start();
                v201:Shake(v196.Presets[v203]);
                return true;
            end;
        end;
    end;
end;
v0.GlassLight = function(v207) --[[ Line: 811 ]]
    local l_Highlight_0 = Instance.new("Highlight");
    l_Highlight_0.FillTransparency = 1;
    l_Highlight_0.OutlineTransparency = 1;
    l_Highlight_0.Parent = v207;
end;
return v0;