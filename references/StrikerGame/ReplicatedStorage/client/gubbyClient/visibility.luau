 

 

local CollectionService = game:GetService("CollectionService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local trove = require(ReplicatedStorage.forum.trove);
local ballMovement = require(script.Parent.ballMovement);
local v1 = {};
local u2 = setmetatable({}, {
    __mode = "k"
});
local u3 = false;

local function matches(p4, p5) -- Line: 11
    if typeof(p5) ~= "NumberSequence" then
        return p4 == p5;
    end;

    for _, v in p4.Keypoints do
        if v.Value ~= 1 or v.Envelope ~= 0 then
            return false;
        end;
    end;

    return true;
end;

local function hideProperty(p6, u7, u8, u9) -- Line: 21
    local v10 = p6.properties[u7];

    if not v10 then
        v10 = {};
        p6.properties[u7] = v10;
    end;

    if v10[u8] ~= nil then
        return;
    end;

    v10[u8] = u7[u8];
    u7[u8] = u9;
    p6.scope:Connect(u7:GetPropertyChangedSignal(u8), function() -- Line: 31
        -- upvalues: u7 (copy), u8 (copy), u9 (copy)
        if u7.Parent then
            local v11 = u7[u8];
            local v12 = u9;
            local v13;

            if typeof(v12) == "NumberSequence" then
                v13 = true;

                for _, v in v11.Keypoints do
                    if v.Value ~= 1 or v.Envelope ~= 0 then
                        v13 = false;
                        break;
                    end;
                end;
            else
                v13 = v11 == v12;
            end;

            if not v13 then
                u7[u8] = u9;
            end;
        end;
    end);
end;

local function hideEffect(p14, p15) -- Line: 38
    -- upvalues: hideProperty (copy)
    local character = p14.character;
    local GubbyRig = character:FindFirstChild("GubbyRig");

    if p15 == GubbyRig or GubbyRig and p15:IsDescendantOf(GubbyRig) then
        return;
    end;

    if p15:IsA("ParticleEmitter") or (p15:IsA("Beam") or p15:IsA("Trail")) then
        hideProperty(p14, p15, "Transparency", NumberSequence.new(1));
        hideProperty(p14, p15, "Enabled", false);

        if p15:IsA("ParticleEmitter") then
            p15:Clear();
        end;
    else
        if p15:IsA("Light") or (p15:IsA("Fire") or (p15:IsA("Smoke") or (p15:IsA("Sparkles") or (p15:IsA("Highlight") or (p15:IsA("SurfaceGui") or p15:IsA("BillboardGui")))))) then
            hideProperty(p14, p15, "Enabled", false);

            return;
        end;

        if p15:IsA("BasePart") then
            if p15.Parent == character or p15.Name == "Handle" and (p15.Parent and p15.Parent:IsA("Accessory")) then
                return;
            end;

            hideProperty(p14, p15, "Transparency", 1);

            return;
        end;

        if p15:IsA("Decal") or p15:IsA("Texture") then
            if p15.Name == "face" and p15.Parent == character:FindFirstChild("Head") then
                return;
            end;

            hideProperty(p14, p15, "Transparency", 1);
        end;
    end;
end;

local function clear(p16) -- Line: 62
    if p16.scope then
        p16.scope:Destroy();
        p16.scope = nil;
    end;

    for i, v in p16.properties do
        if i.Parent then
            local v17 = i;

            for i2, v2 in v do
                v17[i2] = v2;
            end;
        end;
    end;

    table.clear(p16.properties);
end;

local function unbindCharacter(p18) -- Line: 77
    -- upvalues: u2 (copy), clear (copy)
    local v19 = u2[p18];

    if not v19 then
        return;
    end;

    u2[p18] = nil;
    clear(v19);
end;

local function bindCharacter(u20) -- Line: 85
    -- upvalues: u2 (copy), trove (copy), ballMovement (copy), clear (copy), hideEffect (copy)
    if u2[u20] or not u20:HasTag("Gubby") then
        return;
    end;

    local u21 = {
        character = u20,
        properties = {},
        scope = trove.new()
    };
    u2[u20] = u21;
    ballMovement.bind(u20, u21.scope);
    u21.scope:Connect(u20.Destroying, function() -- Line: 96
        -- upvalues: u20 (copy), u2 (ref), clear (ref)
        local v22 = u20;
        local v23 = u2[v22];

        if not v23 then
            return;
        end;

        u2[v22] = nil;
        clear(v23);
    end);
    u21.scope:Connect(u20.DescendantAdded, function(p24) -- Line: 99
        -- upvalues: hideEffect (ref), u21 (copy)
        hideEffect(u21, p24);
    end);

    for _, descendant in u20:GetDescendants() do
        hideEffect(u21, descendant);
    end;
end;

function v1.start() -- Line: 107
    -- upvalues: u3 (ref), CollectionService (copy), bindCharacter (copy), unbindCharacter (copy)
    if u3 then
        return;
    end;

    u3 = true;
    CollectionService:GetInstanceAddedSignal("Gubby"):Connect(bindCharacter);
    CollectionService:GetInstanceRemovedSignal("Gubby"):Connect(unbindCharacter);

    for _, v in CollectionService:GetTagged("Gubby") do
        bindCharacter(v);
    end;
end;

return v1;