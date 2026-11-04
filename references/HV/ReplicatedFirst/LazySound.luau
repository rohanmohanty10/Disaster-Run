 

 

local u1 = {
    Attribute = "LazySoundId",
    IdleSeconds = 60,
    used = setmetatable({}, {
        __mode = "k"
    })
};

function u1.id(p2) -- Line: 14
    -- upvalues: u1 (copy)
    local SoundId = p2.SoundId;

    if SoundId ~= "" then
        return SoundId;
    end;

    local Attribute = p2:GetAttribute(u1.Attribute);

    return type(Attribute) ~= "string" and "" or Attribute;
end;

function u1.arm(p3) -- Line: 24
    -- upvalues: u1 (copy)
    if p3.SoundId == "" then
        local Attribute = p3:GetAttribute(u1.Attribute);

        if type(Attribute) == "string" and Attribute ~= "" then
            p3.SoundId = Attribute;
        end;
    end;

    u1.used[p3] = os.clock();

    return p3;
end;

function u1.playLocal(u4) -- Line: 37
    -- upvalues: u1 (copy)
    u1.arm(u4);

    if u4.IsLoaded then
        game:GetService("SoundService"):PlayLocalSound(u4);

        return;
    end;

    task.spawn(function() -- Line: 43
        -- upvalues: u4 (copy), u1 (ref)
        local v5 = os.clock() + 2;

        while not (u4.IsLoaded or (not u4.Parent or os.clock() >= v5)) do
            task.wait(0.05);
        end;

        if u4.IsLoaded and u4.Parent then
            u1.used[u4] = os.clock();
            game:GetService("SoundService"):PlayLocalSound(u4);
        end;
    end);
end;

function u1.stash(p6) -- Line: 56
    -- upvalues: u1 (copy)
    local SoundId = p6.SoundId;

    if SoundId == "" or p6.Playing then
        return false;
    end;

    p6:SetAttribute(u1.Attribute, SoundId);
    p6.SoundId = "";
    u1.used[p6] = nil;

    return true;
end;

return u1;