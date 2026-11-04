 

 

local LocalPlayer = game:GetService("Players").LocalPlayer;
local u1 = {
    SafezoneASide = true,
    SafezoneBSide = true
};
local u2 = setmetatable({}, {
    __mode = "k"
});
local u3 = {};
local u4 = nil;

local function isSign(p5) -- Line: 15
    -- upvalues: u1 (copy)
    local Parent = p5.Parent;
    local v6;

    if p5.Name == "Sign" then
        v6 = p5:IsA("BillboardGui");

        if v6 then
            if Parent == nil then
                v6 = false;
            else
                v6 = u1[Parent.Name] == true;
            end;
        end;
    else
        v6 = false;
    end;

    return v6;
end;

local function untrack() -- Line: 20
    -- upvalues: u4 (ref), u2 (copy)
    if u4 then
        u4:Disconnect();
        u4 = nil;
    end;

    table.clear(u2);
end;

local function stop() -- Line: 28
    -- upvalues: u2 (copy), u4 (ref), u3 (copy)
    for i in u2 do
        i.Enabled = false;
    end;

    if u4 then
        u4:Disconnect();
        u4 = nil;
    end;

    table.clear(u2);

    for _, v in u3 do
        v:Disconnect();
    end;

    table.clear(u3);
end;

local function track(p7) -- Line: 50
    -- upvalues: u4 (ref), u2 (copy), u1 (copy), LocalPlayer (copy), stop (copy)
    if u4 then
        u4:Disconnect();
        u4 = nil;
    end;

    table.clear(u2);
    local Field = p7:FindFirstChild("Field");

    if Field then
        for i in u1 do
            local v8 = Field:FindFirstChild(i);

            if v8 then
                v8 = v8:FindFirstChild("Sign");
            end;

            if v8 then
                local Parent = v8.Parent;
                local v9;

                if v8.Name == "Sign" then
                    v9 = v8:IsA("BillboardGui");

                    if v9 then
                        if Parent == nil then
                            v9 = false;
                        else
                            v9 = u1[Parent.Name] == true;
                        end;
                    end;
                else
                    v9 = false;
                end;

                if v9 then
                    u2[v8] = true;
                end;
            end;
        end;
    end;

    u4 = p7.DescendantAdded:Connect(function(p10) -- Line: 62
        -- upvalues: u1 (ref), u2 (ref), LocalPlayer (ref), stop (ref)
        local Parent = p10.Parent;
        local v11;

        if p10.Name == "Sign" then
            v11 = p10:IsA("BillboardGui");

            if v11 then
                if Parent == nil then
                    v11 = false;
                else
                    v11 = u1[Parent.Name] == true;
                end;
            end;
        else
            v11 = false;
        end;

        if v11 then
            u2[p10] = true;
            local Attribute = LocalPlayer:GetAttribute("Map3Signs");

            if Attribute == true then
                for i in u2 do
                    i.Enabled = true;
                end;

                return;
            end;

            if Attribute == false then
                stop();
            end;
        end;
    end);
    local Attribute = LocalPlayer:GetAttribute("Map3Signs");

    if Attribute == true then
        for i in u2 do
            i.Enabled = true;
        end;

        return;
    end;

    if Attribute == false then
        stop();
    end;
end;

table.insert(u3, workspace.ChildAdded:Connect(function(p12) -- Line: 71
    -- upvalues: track (copy)
    if p12.Name == "Map3" then
        track(p12);
    end;
end));
table.insert(u3, workspace.ChildRemoved:Connect(function(p13) -- Line: 76
    -- upvalues: u4 (ref), u2 (copy)
    if p13.Name == "Map3" then
        if u4 then
            u4:Disconnect();
            u4 = nil;
        end;

        table.clear(u2);
    end;
end));
local AttributeChangedSignal = LocalPlayer:GetAttributeChangedSignal("Map3Signs");
table.insert(u3, AttributeChangedSignal:Connect(function() -- Line: 39, Name: refresh
    -- upvalues: LocalPlayer (copy), u2 (copy), stop (copy)
    local Attribute = LocalPlayer:GetAttribute("Map3Signs");

    if Attribute == true then
        for i in u2 do
            i.Enabled = true;
        end;

        return;
    end;

    if Attribute == false then
        stop();
    end;
end));
local Map3 = workspace:FindFirstChild("Map3");

if Map3 then
    track(Map3);
else
    local Attribute = LocalPlayer:GetAttribute("Map3Signs");

    if Attribute == true then
        for i in u2 do
            i.Enabled = true;
        end;
    elseif Attribute == false then
        stop();
    end;
end;