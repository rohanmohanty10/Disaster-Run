 

local l__Workspace__1 = game:GetService("Workspace");
local l__Players__2 = game:GetService("Players");
local u1 = Color3.fromRGB(128, 128, 128);
local function u4(p2) --[[ Line: 8 ]]
    if p2:IsA("BasePart") then
        return p2;
    end;
    if p2:IsA("Model") then
        if p2.PrimaryPart then
            return p2.PrimaryPart;
        end;
        for _, v3 in ipairs(p2:GetDescendants()) do
            if v3:IsA("BasePart") then
                return v3;
            end;
        end;
    end;
    return nil;
end;
local function u8(p5) --[[ Line: 24 ]]
    -- upvalues: l__Players__2 (copy)
    local v6 = { p5 };
    for _, v7 in ipairs(l__Players__2:GetPlayers()) do
        if v7.Character then
            table.insert(v6, v7.Character);
        end;
    end;
    local l__VFX__3 = workspace.World.Visuals;
    if l__VFX__3 then
        table.insert(v6, l__VFX__3);
    end;
    return v6;
end;
local function u18(p9, p10, p11) --[[ Line: 37 ]]
    -- upvalues: u1 (copy), u8 (copy), l__Workspace__1 (copy)
    if not p9 then
        return {
            Hit = false,
            Color = u1,
            Material = Enum.Material.Air
        };
    end;
    local v12 = RaycastParams.new();
    v12.FilterType = Enum.RaycastFilterType.Exclude;
    v12.FilterDescendantsInstances = u8(p11);
    local v13 = p9.Position + Vector3.new(0, -0.25, 0);
    local v14 = -math.max(p10, 1);
    local v15 = l__Workspace__1:Raycast(v13, Vector3.new(0, v14, 0), v12);
    if v15 and v15.Instance then
        return {
            Hit = true,
            Color = v15.Instance.Color,
            Material = v15.Material
        };
    end;
    local v16 = u1;
    local v17;
    if typeof(p11.GetAttribute) == "function" then
        v17 = p11:GetAttribute("GroundFallbackColor");
        if typeof(v17) ~= "Color3" then
            v17 = v16;
        end;
    else
        v17 = v16;
    end;
    return {
        Hit = false,
        Color = v17,
        Material = Enum.Material.Air
    };
end;
local u19 = {
    Rock = { Enum.Material.Slate, Enum.Material.Concrete, Enum.Material.Rock },
    Grass = { Enum.Material.Grass }
};
local function u22(p20, p21) --[[ Line: 96 ]]
    if p20.Name == "Smoke" and p21 then
        p20.Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, p21), ColorSequenceKeypoint.new(1, p21) });
    end;
end;
return {
    emitParticles = function(p23) --[[ Name: emitParticles, Line 104 ]]
        -- upvalues: u4 (copy), u18 (copy), u19 (copy), u22 (copy)
        local v24 = u18(u4(p23), 5, p23);
        for _, u25 in p23:GetDescendants() do
            if u25:IsA("ParticleEmitter") then
                local l__Name__4 = u25.Name;
                local l__Material__5 = v24.Material;
                local v26 = u19[l__Name__4];
                local v27, v28, u29, u30;
                if v26 then
                    for _, v31 in ipairs(v26) do
                        if v31 == l__Material__5 then
                            v27 = true;
                            if v27 then
                                u22(u25, v24.Color);
                                if u25.Name ~= "Smoke" or v24 then
                                    v28 = u25:GetAttribute("EmitDelay");
                                    u29 = u25:GetAttribute("EmitCount") or 0;
                                    u30 = u25:GetAttribute("EmitDuration") or 0;
                                    if u29 > 0 then
                                        if v28 then
                                            task.delay(v28, function() --[[ Line: 127 ]]
                                                -- upvalues: u25 (copy), u29 (copy)
                                                if u25.Parent then
                                                    u25:Emit(u29);
                                                end;
                                            end);
                                        elseif u25.Parent then
                                            u25:Emit(u29);
                                        end;
                                    end;
                                    if u30 then
                                        if v28 then
                                            task.delay(v28, function() --[[ Line: 137 ]]
                                                -- upvalues: u25 (copy), u30 (copy)
                                                if u25.Parent then
                                                    u25.Enabled = true;
                                                    task.wait(u30);
                                                    if u25.Parent then
                                                        u25.Enabled = false;
                                                    end;
                                                end;
                                            end);
                                        else
                                            u25.Enabled = true;
                                            task.delay(u30, function() --[[ Line: 145 ]]
                                                -- upvalues: u25 (copy)
                                                if u25.Parent then
                                                    u25.Enabled = false;
                                                end;
                                            end);
                                        end;
                                    end;
                                end;
                            else
                                u25.Enabled = false;
                            end;
                        end;
                    end;
                    v27 = false;
                    if v27 then
                        u22(u25, v24.Color);
                        if u25.Name ~= "Smoke" or v24 then
                            v28 = u25:GetAttribute("EmitDelay");
                            u29 = u25:GetAttribute("EmitCount") or 0;
                            u30 = u25:GetAttribute("EmitDuration") or 0;
                            if u29 > 0 then
                                if v28 then
                                    task.delay(v28, function() --[[ Line: 127 ]]
                                        -- upvalues: u25 (copy), u29 (copy)
                                        if u25.Parent then
                                            u25:Emit(u29);
                                        end;
                                    end);
                                elseif u25.Parent then
                                    u25:Emit(u29);
                                end;
                            end;
                            if u30 then
                                if v28 then
                                    task.delay(v28, function() --[[ Line: 137 ]]
                                        -- upvalues: u25 (copy), u30 (copy)
                                        if u25.Parent then
                                            u25.Enabled = true;
                                            task.wait(u30);
                                            if u25.Parent then
                                                u25.Enabled = false;
                                            end;
                                        end;
                                    end);
                                else
                                    u25.Enabled = true;
                                    task.delay(u30, function() --[[ Line: 145 ]]
                                        -- upvalues: u25 (copy)
                                        if u25.Parent then
                                            u25.Enabled = false;
                                        end;
                                    end);
                                end;
                            end;
                        end;
                    else
                        u25.Enabled = false;
                    end;
                end;
                v27 = true;
                if v27 then
                    u22(u25, v24.Color);
                    if u25.Name ~= "Smoke" or v24 then
                        v28 = u25:GetAttribute("EmitDelay");
                        u29 = u25:GetAttribute("EmitCount") or 0;
                        u30 = u25:GetAttribute("EmitDuration") or 0;
                        if u29 > 0 then
                            if v28 then
                                task.delay(v28, function() --[[ Line: 127 ]]
                                    -- upvalues: u25 (copy), u29 (copy)
                                    if u25.Parent then
                                        u25:Emit(u29);
                                    end;
                                end);
                            elseif u25.Parent then
                                u25:Emit(u29);
                            end;
                        end;
                        if u30 then
                            if v28 then
                                task.delay(v28, function() --[[ Line: 137 ]]
                                    -- upvalues: u25 (copy), u30 (copy)
                                    if u25.Parent then
                                        u25.Enabled = true;
                                        task.wait(u30);
                                        if u25.Parent then
                                            u25.Enabled = false;
                                        end;
                                    end;
                                end);
                            else
                                u25.Enabled = true;
                                task.delay(u30, function() --[[ Line: 145 ]]
                                    -- upvalues: u25 (copy)
                                    if u25.Parent then
                                        u25.Enabled = false;
                                    end;
                                end);
                            end;
                        end;
                    end;
                else
                    u25.Enabled = false;
                end;
            end;
        end;
    end,
    enableParticles = function(p32) --[[ Name: enableParticles, Line 153 ]]
        -- upvalues: u4 (copy), u18 (copy), u19 (copy), u22 (copy)
        local u33 = u18(u4(p32), 20, p32);
        local function v38(p34) --[[ Line: 157 ]]
            -- upvalues: u33 (copy), u19 (ref), u22 (ref)
            if not p34:IsA("ParticleEmitter") then
                if p34:IsA("Trail") or p34:IsA("Beam") then
                    p34.Enabled = true;
                end;
                return;
            end;
            local l__Name__6 = p34.Name;
            local l__Material__7 = u33.Material;
            local v35 = u19[l__Name__6];
            local v36;
            if v35 then
                for _, v37 in ipairs(v35) do
                    if v37 == l__Material__7 then
                        v36 = true;
                        if v36 then
                            u22(p34, u33.Color);
                            p34.Enabled = true;
                            return;
                        else
                            p34.Enabled = false;
                            return;
                        end;
                    end;
                end;
                v36 = false;
                if v36 then
                    u22(p34, u33.Color);
                    p34.Enabled = true;
                else
                    p34.Enabled = false;
                end;
            else
                v36 = true;
                if v36 then
                    u22(p34, u33.Color);
                    p34.Enabled = true;
                else
                    p34.Enabled = false;
                end;
            end;
        end;
        v38(p32);
        for _, v39 in p32:GetDescendants() do
            v38(v39);
        end;
    end,
    disableParticles = function(p40) --[[ Name: disableParticles, Line 176 ]]
        if p40:IsA("ParticleEmitter") or (p40:IsA("Trail") or p40:IsA("Beam")) then
            p40.Enabled = false;
        end;
        for _, v41 in p40:GetDescendants() do
            if v41:IsA("ParticleEmitter") or (v41:IsA("Trail") or v41:IsA("Beam")) then
                v41.Enabled = false;
            end;
        end;
    end
};