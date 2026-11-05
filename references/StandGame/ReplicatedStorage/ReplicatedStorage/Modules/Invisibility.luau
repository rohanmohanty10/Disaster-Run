 

 

local l__HttpService__1 = game:GetService("HttpService");
local u1 = {
    BasePart = "Transparency",
    Decal = "Transparency",
    Texture = "Transparency",
    PointLight = "Enabled",
    SpotLight = "Enabled",
    SurfaceLight = "Enabled",
    BillboardGui = "Enabled",
    SurfaceGui = "Enabled",
    ParticleEmitter = "Enabled",
    Fire = "Enabled",
    Smoke = "Enabled",
    Sparkles = "Enabled",
    Beam = "Enabled",
    Trail = "Enabled"
};
local u2 = {
    RightUpperArm = true,
    RightLowerArm = true,
    RightHand = true,
    LeftUpperArm = true,
    LeftLowerArm = true,
    LeftHand = true,
    LeftUpperLeg = true,
    LeftLowerLeg = true,
    LeftFoot = true,
    RightUpperLeg = true,
    RightLowerLeg = true,
    RightFoot = true,
    Head = true,
    UpperTorso = true,
    LowerTorso = true
};
local u3 = {};
local u4 = {};
local u5 = {};
local function u12(p6, p7, p8) --[[ Line: 60 ]]
    -- upvalues: u1 (copy), u5 (copy)
    for _, v9 in p6:GetDescendants() do
        local v10;
        if typeof(v9) == "Instance" then
            for v11, _ in u1 do
                if v9:IsA(v11) then
                    v10 = true;
                    if v10 and u5.AddObject(v9, p7) then
                        p8.Value = true;
                    end;
                end;
            end;
            v10 = false;
            if v10 and u5.AddObject(v9, p7) then
                p8.Value = true;
            end;
        end;
        v10 = false;
        if v10 and u5.AddObject(v9, p7) then
            p8.Value = true;
        end;
    end;
end;
function u5.GetActiveId(p13) --[[ Line: 71 ]]
    -- upvalues: u4 (copy)
    return u4[p13];
end;
function u5.AddObject(p14, p15) --[[ Line: 75 ]]
    -- upvalues: u1 (copy), u3 (copy), u4 (copy)
    local v16, v17, v20;
    if typeof(p14) == "Instance" then
        for v19, v20 in u1 do
            if p14:IsA(v19) then
                v16 = true;
                if not v16 then
                    return false;
                end;
                if not u3[p14] then
                    u3[p14] = {
                        Count = 0,
                        AdjustedProperty = v20,
                        OriginalValue = p14[v20],
                        Active = {}
                    };
                end;
                v17 = u3[p14];
                if v17.Active[p15] then
                    return false;
                end;
                v17.Active[p15] = true;
                v17.Count = v17.Count + 1;
                if v17.Count == 1 then
                    if v20 == "Transparency" then
                        p14[v20] = 1;
                    elseif v20 == "Enabled" then
                        p14[v20] = false;
                    end;
                end;
                u4[p15] = u4[p15] or {};
                table.insert(u4[p15], p14);
                return true;
            end;
        end;
        v16 = false;
        v20 = nil;
        if not v16 then
            return false;
        end;
        if not u3[p14] then
            u3[p14] = {
                Count = 0,
                AdjustedProperty = v20,
                OriginalValue = p14[v20],
                Active = {}
            };
        end;
        v17 = u3[p14];
        if v17.Active[p15] then
            return false;
        end;
        v17.Active[p15] = true;
        v17.Count = v17.Count + 1;
        if v17.Count == 1 then
            if v20 == "Transparency" then
                p14[v20] = 1;
            elseif v20 == "Enabled" then
                p14[v20] = false;
            end;
        end;
        u4[p15] = u4[p15] or {};
        table.insert(u4[p15], p14);
        return true;
    else
        v16 = false;
        v20 = nil;
        if not v16 then
            return false;
        end;
        if not u3[p14] then
            u3[p14] = {
                Count = 0,
                AdjustedProperty = v20,
                OriginalValue = p14[v20],
                Active = {}
            };
        end;
        v17 = u3[p14];
        if v17.Active[p15] then
            return false;
        end;
        v17.Active[p15] = true;
        v17.Count = v17.Count + 1;
        if v17.Count == 1 then
            if v20 == "Transparency" then
                p14[v20] = 1;
            elseif v20 == "Enabled" then
                p14[v20] = false;
            end;
        end;
        u4[p15] = u4[p15] or {};
        table.insert(u4[p15], p14);
        return true;
    end;
end;
function u5.RemoveObject(p21, p22) --[[ Line: 113 ]]
    -- upvalues: u3 (copy)
    local v23 = u3[p21];
    if not (v23 and v23.Active[p22]) then
        return false;
    end;
    v23.Active[p22] = nil;
    v23.Count = v23.Count - 1;
    if v23.Count <= 0 then
        p21[v23.AdjustedProperty] = v23.OriginalValue;
        u3[p21] = nil;
    end;
    return true;
end;
function u5.RemoveId(p24) --[[ Line: 131 ]]
    -- upvalues: u4 (copy), u5 (copy)
    local v25 = u4[p24];
    if not v25 then
        return false;
    end;
    for _, v26 in v25 do
        u5.RemoveObject(v26, p24);
    end;
    u4[p24] = nil;
    return true;
end;
function u5.SetObjectInvisible(u27, p28) --[[ Line: 145 ]]
    -- upvalues: l__HttpService__1 (copy), u5 (copy)
    local u29 = l__HttpService__1:GenerateGUID(false);
    if not u5.AddObject(u27, u29) then
        return nil;
    end;
    if p28 and p28 > 0 then
        task.delay(p28, function() --[[ Line: 152 ]]
            -- upvalues: u5 (ref), u27 (copy), u29 (copy)
            u5.RemoveObject(u27, u29);
        end);
    end;
    return u29;
end;
function u5.SetCharacterInvisible(p30, p31, p32) --[[ Line: 160 ]]
    -- upvalues: l__HttpService__1 (copy), u2 (copy), u5 (copy), u12 (copy)
    if p30 then
        local u33 = p32 or l__HttpService__1:GenerateGUID(false);
        local v34 = {
            Value = false
        };
        for _, v35 in p30:GetChildren() do
            if u2[v35.Name] then
                if u5.AddObject(v35, u33) then
                    v34.Value = true;
                end;
                u12(v35, u33, v34);
            elseif v35:IsA("Accessory") or v35:IsA("Tool") then
                u12(v35, u33, v34);
            end;
        end;
        if v34.Value then
            if p31 and p31 > 0 then
                task.delay(p31, function() --[[ Line: 185 ]]
                    -- upvalues: u5 (ref), u33 (copy)
                    u5.RemoveId(u33);
                end);
            end;
            return u33;
        else
            u5.RemoveId(u33);
            return nil;
        end;
    else
        return nil;
    end;
end;
function u5.SetLimbsInvisible(p36, p37, p38, p39) --[[ Line: 194 ]]
    -- upvalues: u2 (copy), l__HttpService__1 (copy), u5 (copy), u1 (copy)
    if not p36 then
        return nil;
    end;
    if p37 == "R15" then
        p37 = {};
        for v40 in u2 do
            table.insert(p37, v40);
        end;
    end;
    local u41 = p39 or l__HttpService__1:GenerateGUID(false);
    local v42 = false;
    for _, v43 in p37 do
        local v44 = p36:FindFirstChild(v43);
        if v44 then
            v42 = u5.AddObject(v44, u41) and true or v42;
            for _, v45 in v44:GetDescendants() do
                local v46;
                if typeof(v45) == "Instance" then
                    for v47, _ in u1 do
                        if v45:IsA(v47) then
                            v46 = true;
                            if v46 and u5.AddObject(v45, u41) then
                                v42 = true;
                            end;
                        end;
                    end;
                    v46 = false;
                    if v46 and u5.AddObject(v45, u41) then
                        v42 = true;
                    end;
                end;
                v46 = false;
                if v46 and u5.AddObject(v45, u41) then
                    v42 = true;
                end;
            end;
        end;
    end;
    if v42 then
        if p38 and p38 > 0 then
            task.delay(p38, function() --[[ Line: 233 ]]
                -- upvalues: u5 (ref), u41 (copy)
                u5.RemoveId(u41);
            end);
        end;
        return u41;
    else
        u5.RemoveId(u41);
        return nil;
    end;
end;
function u5.IsObjectInvisible(p48) --[[ Line: 241 ]]
    -- upvalues: u3 (copy)
    local v49 = u3[p48];
    local v50;
    if v49 == nil then
        v50 = false;
    else
        v50 = v49.Count > 0;
    end;
    return v50;
end;
function u5.GetCount(p51) --[[ Line: 246 ]]
    -- upvalues: u3 (copy)
    local v52 = u3[p51];
    return v52 and v52.Count or 0;
end;
function u5.ClearAll() --[[ Line: 251 ]]
    -- upvalues: u3 (copy), u4 (copy)
    for v53, v54 in u3 do
        local l__AdjustedProperty__2 = v54.AdjustedProperty;
        if l__AdjustedProperty__2 and (v53 and v53.Parent) then
            v53[l__AdjustedProperty__2] = v54.OriginalValue;
        end;
    end;
    table.clear(u3);
    table.clear(u4);
end;
return u5;