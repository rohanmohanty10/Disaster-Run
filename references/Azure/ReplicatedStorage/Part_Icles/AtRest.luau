 

 

local EngineAttr = require(script.Parent.EngineAttr);
local u1 = {
    ATTRIBUTE = "_authoredEnabled"
};

local function isNative(p2) -- Line: 31
    return p2:IsA("Beam") or p2:IsA("Light");
end;

local function isMarked(p3) -- Line: 35
    -- upvalues: u1 (copy)
    return p3:GetAttribute(u1.ATTRIBUTE) == true;
end;

local function silenceTree(p4) -- Line: 41
    -- upvalues: u1 (copy), silenceTree (copy)
    if p4:GetAttribute("Transformed") then
        return false;
    end;

    local v5;

    if (p4:IsA("Beam") or p4:IsA("Light")) and p4.Enabled and p4:GetAttribute(u1.ATTRIBUTE) ~= true then
        p4:SetAttribute(u1.ATTRIBUTE, true);
        p4.Enabled = false;
        v5 = true;
    else
        v5 = false;
    end;

    for _, child in ipairs(p4:GetChildren()) do
        if silenceTree(child) then
            v5 = true;
        end;
    end;

    return v5;
end;

local function treeNeeds(p6) -- Line: 60
    -- upvalues: u1 (copy), treeNeeds (copy)
    if p6:GetAttribute("Transformed") then
        return false;
    end;

    if (p6:IsA("Beam") or p6:IsA("Light")) and p6.Enabled and p6:GetAttribute(u1.ATTRIBUTE) ~= true then
        return true;
    end;

    for _, child in ipairs(p6:GetChildren()) do
        if treeNeeds(child) then
            return true;
        end;
    end;

    return false;
end;

local function setMarked(p7, p8) -- Line: 76
    -- upvalues: u1 (copy), EngineAttr (copy), setMarked (copy)
    for _, child in ipairs(p7:GetChildren()) do
        if not child:GetAttribute("Transformed") then
            if (child:IsA("Beam") or child:IsA("Light")) and (child:GetAttribute(u1.ATTRIBUTE) == true and child.Enabled ~= p8) then
                EngineAttr.writeProp(child, "Enabled", p8);
            end;

            setMarked(child, p8);
        end;
    end;
end;

function u1.applies(p9) -- Line: 88
    local v10;

    if p9 == nil then
        v10 = false;
    else
        v10 = p9:IsA("BasePart") or p9:IsA("Attachment");
    end;

    return v10;
end;

function u1.silence(p11) -- Line: 94
    -- upvalues: u1 (copy), silenceTree (copy)
    if not u1.applies(p11) then
        return false;
    end;

    local v12 = false;

    for _, child in ipairs(p11:GetChildren()) do
        if silenceTree(child) then
            v12 = true;
        end;
    end;

    return v12;
end;

function u1.silenceHeld(p13) -- Line: 109
    -- upvalues: silenceTree (copy)
    return silenceTree(p13);
end;

function u1.needs(p14) -- Line: 113
    -- upvalues: u1 (copy), treeNeeds (copy)
    if not u1.applies(p14) then
        return false;
    end;

    for _, child in ipairs(p14:GetChildren()) do
        if treeNeeds(child) then
            return true;
        end;
    end;

    return false;
end;

function u1.wakeCopy(p15) -- Line: 126
    -- upvalues: u1 (copy)
    if (p15:IsA("Beam") or p15:IsA("Light")) and p15:GetAttribute(u1.ATTRIBUTE) == true then
        p15.Enabled = true;
    end;
end;

function u1.wake(p16) -- Line: 134
    -- upvalues: setMarked (copy)
    setMarked(p16, true);
end;

function u1.rest(p17) -- Line: 138
    -- upvalues: setMarked (copy)
    setMarked(p17, false);
end;

return u1;