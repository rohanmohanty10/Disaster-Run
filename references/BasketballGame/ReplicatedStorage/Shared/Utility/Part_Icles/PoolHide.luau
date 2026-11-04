 
 

local CFrame_new_ret = CFrame.new(Vector3.new(1000000000, 1000000000, 1000000000));
local v1 = {};

local function disableTrails(u2) -- Line: 25
    if u2:IsA("Trail") then
        pcall(function() -- Line: 27
            -- upvalues: u2 (copy)
            if u2:GetAttribute("_pooledTrailEnabled") == nil then
                u2:SetAttribute("_pooledTrailEnabled", u2.Enabled);
            end;

            if u2:GetAttribute("_pooledTrailLifetime") == nil then
                u2:SetAttribute("_pooledTrailLifetime", u2.Lifetime);
            end;

            u2.Lifetime = 0;
            u2.Enabled = false;
        end);

        return;
    end;

    for _, descendant in ipairs(u2:GetDescendants()) do
        if descendant:IsA("Trail") then
            pcall(function() -- Line: 41
                -- upvalues: descendant (copy)
                if descendant:GetAttribute("_pooledTrailEnabled") == nil then
                    descendant:SetAttribute("_pooledTrailEnabled", descendant.Enabled);
                end;

                if descendant:GetAttribute("_pooledTrailLifetime") == nil then
                    descendant:SetAttribute("_pooledTrailLifetime", descendant.Lifetime);
                end;

                descendant.Lifetime = 0;
                descendant.Enabled = false;
            end);
        end;
    end;
end;

local function restoreTrails(u3) -- Line: 56
    if u3:IsA("Trail") then
        pcall(function() -- Line: 58
            -- upvalues: u3 (copy)
            local Attribute = u3:GetAttribute("_pooledTrailLifetime");

            if Attribute ~= nil then
                u3.Lifetime = Attribute;
            end;

            u3:SetAttribute("_pooledTrailLifetime", nil);
            local Attribute2 = u3:GetAttribute("_pooledTrailEnabled");

            if Attribute2 ~= nil then
                u3.Enabled = Attribute2 == true;
            end;

            u3:SetAttribute("_pooledTrailEnabled", nil);
        end);

        return;
    end;

    for _, descendant in ipairs(u3:GetDescendants()) do
        if descendant:IsA("Trail") then
            pcall(function() -- Line: 70
                -- upvalues: descendant (copy)
                local Attribute = descendant:GetAttribute("_pooledTrailLifetime");

                if Attribute ~= nil then
                    descendant.Lifetime = Attribute;
                end;

                descendant:SetAttribute("_pooledTrailLifetime", nil);
                local Attribute2 = descendant:GetAttribute("_pooledTrailEnabled");

                if Attribute2 ~= nil then
                    descendant.Enabled = Attribute2 == true;
                end;

                descendant:SetAttribute("_pooledTrailEnabled", nil);
            end);
        end;
    end;
end;

local function cancelNativeDescendants(p4) -- Line: 87
    for _, descendant in ipairs(p4:GetDescendants()) do
        if descendant:IsA("ParticleEmitter") or descendant:IsA("Trail") then
            pcall(function() -- Line: 90
                -- upvalues: descendant (copy)
                descendant:SetAttribute("_PartIcleNativeEmitGen", (descendant:GetAttribute("_PartIcleNativeEmitGen") or 0) + 1);
                descendant:SetAttribute("_PartIcleNativeDurationGen", (descendant:GetAttribute("_PartIcleNativeDurationGen") or 0) + 1);
                descendant.Enabled = false;
            end);
        end;
    end;
end;

function v1.hide(u5, p6) -- Line: 101
    -- upvalues: disableTrails (copy), cancelNativeDescendants (copy), CFrame_new_ret (copy)
    if not (u5 and u5.Parent) then
        return;
    end;

    if p6 == "Part" then
        disableTrails(u5);
        cancelNativeDescendants(u5);

        if u5:IsA("BasePart") then
            pcall(function() -- Line: 110
                -- upvalues: u5 (copy), CFrame_new_ret (ref)
                u5.CFrame = CFrame_new_ret;
            end);
        end;
    else
        if p6 == "Model" then
            disableTrails(u5);
            cancelNativeDescendants(u5);
            pcall(function() -- Line: 116
                -- upvalues: u5 (copy), CFrame_new_ret (ref)
                u5:PivotTo(CFrame_new_ret);
            end);

            return;
        end;

        if p6 == "Beam" then
            pcall(function() -- Line: 121
                -- upvalues: u5 (copy)
                if u5:GetAttribute("_pooledBeamColor") == nil then
                    u5:SetAttribute("_pooledBeamColor", u5.Color);
                end;

                if u5:GetAttribute("_pooledBeamTransparency") == nil then
                    u5:SetAttribute("_pooledBeamTransparency", u5.Transparency);
                end;

                u5.Enabled = false;
            end);

            return;
        end;

        if p6 == "PointLight" then
            pcall(function() -- Line: 132
                -- upvalues: u5 (copy)
                u5.Enabled = false;
            end);

            return;
        end;

        if p6 == "Highlight" then
            pcall(function() -- Line: 135
                -- upvalues: u5 (copy)
                u5.Enabled = false;
            end);

            return;
        end;

        if p6 == "TrailEmitter" then
            pcall(function() -- Line: 138
                -- upvalues: u5 (copy)
                u5.Enabled = false;
            end);

            return;
        end;

        if p6 == "Attachment" then
            disableTrails(u5);
            cancelNativeDescendants(u5);
        end;
    end;
end;

function v1.show(u7, p8) -- Line: 153
    if not (u7 and u7.Parent) then
        return;
    end;

    if p8 == "Beam" then
        pcall(function() -- Line: 160
            -- upvalues: u7 (copy)
            local Attribute = u7:GetAttribute("_pooledBeamColor");

            if Attribute ~= nil then
                u7.Color = Attribute;
            end;

            u7:SetAttribute("_pooledBeamColor", nil);
            local Attribute2 = u7:GetAttribute("_pooledBeamTransparency");

            if Attribute2 ~= nil then
                u7.Transparency = Attribute2;
            end;

            u7:SetAttribute("_pooledBeamTransparency", nil);
            u7.Enabled = true;
        end);

        return;
    end;

    if p8 == "PointLight" or (p8 == "Highlight" or p8 == "TrailEmitter") then
        pcall(function() -- Line: 170
            -- upvalues: u7 (copy)
            u7.Enabled = true;
        end);
    end;
end;

function v1.restoreTrails(p9, p10) -- Line: 177
    -- upvalues: restoreTrails (copy)
    if not (p9 and p9.Parent) then
        return;
    end;

    if p10 == "Part" or (p10 == "Model" or p10 == "Attachment") then
        restoreTrails(p9);
    end;
end;

return v1;