 

 

local LocalPlayer = game:GetService("Players").LocalPlayer;
local Session = game:GetService("ReplicatedStorage"):WaitForChild("ChickenOrHero"):WaitForChild("Game"):WaitForChild("Session");
local u1 = {
    Prepare = true,
    SelectHero = true,
    HeroChoice = true,
    ChoiceReveal = true
};
local u2 = setmetatable({}, {
    __mode = "k"
});

local function hidden() -- Line: 12
    -- upvalues: u1 (copy), Session (copy), LocalPlayer (copy)
    local v3;

    if u1[Session:GetAttribute("Phase")] == true then
        v3 = LocalPlayer:GetAttribute("GameRole") == "Catcher";
    else
        v3 = false;
    end;

    return v3;
end;

local function apply(p4) -- Line: 15
    -- upvalues: u2 (copy), u1 (copy), Session (copy), LocalPlayer (copy)
    local v5 = u2[p4];

    if v5 == nil then
        return;
    end;

    local v6;

    if u1[Session:GetAttribute("Phase")] == true then
        v6 = LocalPlayer:GetAttribute("GameRole") == "Catcher";
    else
        v6 = false;
    end;

    local v7 = v6 and 1 or v5;

    if p4.Transparency ~= v7 then
        p4.Transparency = v7;
    end;
end;

local function track(p8) -- Line: 30
    -- upvalues: u2 (copy), u1 (copy), Session (copy), LocalPlayer (copy)
    if p8.Name == "Disable" and (p8:IsA("BasePart") and u2[p8] == nil) then
        u2[p8] = p8.Transparency;
        local v9 = u2[p8];

        if v9 == nil then
            return;
        end;

        local v10;

        if u1[Session:GetAttribute("Phase")] == true then
            v10 = LocalPlayer:GetAttribute("GameRole") == "Catcher";
        else
            v10 = false;
        end;

        local v11 = v10 and 1 or v9;

        if p8.Transparency ~= v11 then
            p8.Transparency = v11;
        end;
    end;
end;

local function refresh() -- Line: 25
    -- upvalues: u2 (copy), u1 (copy), Session (copy), LocalPlayer (copy)
    for i in u2 do
        local v12 = u2[i];

        if v12 ~= nil then
            local v13;

            if u1[Session:GetAttribute("Phase")] == true then
                v13 = LocalPlayer:GetAttribute("GameRole") == "Catcher";
            else
                v13 = false;
            end;

            local v14 = v13 and 1 or v12;

            if i.Transparency ~= v14 then
                i.Transparency = v14;
            end;
        end;
    end;
end;

for _, descendant in workspace:GetDescendants() do
    if descendant.Name == "Disable" and (descendant:IsA("BasePart") and u2[descendant] == nil) then
        u2[descendant] = descendant.Transparency;
        local v15 = u2[descendant];

        if v15 ~= nil then
            local v16;

            if u1[Session:GetAttribute("Phase")] == true then
                v16 = LocalPlayer:GetAttribute("GameRole") == "Catcher";
            else
                v16 = false;
            end;

            local v17 = v16 and 1 or v15;

            if descendant.Transparency ~= v17 then
                descendant.Transparency = v17;
            end;
        end;
    end;
end;

local u18 = workspace.DescendantAdded:Connect(track);
local u20 = workspace.DescendantRemoving:Connect(function(p19) -- Line: 41
    -- upvalues: u2 (copy)
    if u2[p19] ~= nil then
        p19.Transparency = u2[p19];
        u2[p19] = nil;
    end;
end);
local u21 = Session:GetAttributeChangedSignal("Phase"):Connect(refresh);
local u22 = LocalPlayer:GetAttributeChangedSignal("GameRole"):Connect(refresh);
script.Destroying:Connect(function() -- Line: 51
    -- upvalues: u18 (copy), u20 (copy), u21 (copy), u22 (copy), u2 (copy)
    u18:Disconnect();
    u20:Disconnect();
    u21:Disconnect();
    u22:Disconnect();

    for i, v in u2 do
        i.Transparency = v;
    end;

    table.clear(u2);
end);