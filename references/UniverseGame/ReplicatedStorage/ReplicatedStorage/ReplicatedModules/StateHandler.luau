  

 

local u10 = {
    SetState = function(p1, p2, p3, p4) -- Line: 3, Name: SetState
        if typeof(p1) == "Instance" then
            local v5 = p4 or {};
            local StatesFolder = p1:FindFirstChild("StatesFolder");

            if not StatesFolder then
                StatesFolder = Instance.new("Folder");
                StatesFolder.Name = "StatesFolder";
                StatesFolder.Parent = p1;
            end;

            local v6 = StatesFolder:FindFirstChild(p2);

            if not v6 then
                v6 = Instance.new("BoolValue");
                v6.Name = p2;
                v6.Value = p3;
                v6.Parent = StatesFolder;
            end;

            v6.Value = p3;

            if v5.Attributes then
                for i, v in v5.Attributes do
                    v6:SetAttribute(i, v);
                end;
            end;

            return p3;
        end;
    end,

    GetStateObject = function(p7, p8, p9) -- Line: 34, Name: GetStateObject
        if typeof(p7) ~= "Instance" then
            return;
        end;

        local StatesFolder = p7:FindFirstChild("StatesFolder");

        if StatesFolder ~= nil then
            return StatesFolder:FindFirstChild(p8);
        end;
    end
};

function u10.IsStateActive(p11, p12, p13) -- Line: 45
    -- upvalues: u10 (copy)
    local v14 = u10.GetStateObject(p11, p12, p13);

    if v14 then
        v14 = v14.Value;
    end;

    return v14;
end;

function u10.GetStatePriority(p15, p16, p17) -- Line: 50
    -- upvalues: u10 (copy)
    local v18 = u10.GetStateObject(p15, p16, p17);

    if v18 then
        v18 = v18:GetAttribute("Priority");
    end;

    return v18;
end;

function u10.GetHighestActiveState(p19, p20) -- Line: 55
    if typeof(p19) ~= "Instance" then
        return;
    end;

    local StatesFolder = p19:FindFirstChild("StatesFolder");

    if StatesFolder then
        local v21 = 0;
        local v22 = nil;

        for _, child in StatesFolder:GetChildren() do
            if child.Value and (child:GetAttribute("Priority") or 0) >= v21 then
                v22 = child.Name;
                v21 = child:GetAttribute("Priority");
            end;
        end;

        return v22, v21;
    end;
end;

function u10.GetStates(p23, p24) -- Line: 75
    if typeof(p23) ~= "Instance" then
        return;
    end;

    local StatesFolder = p23:FindFirstChild("StatesFolder");

    if StatesFolder then
        local v25 = {};

        for _, child in StatesFolder:GetChildren() do
            if not v25[child.Name] then
                v25[child.Name] = {
                    Active = child.Value,
                    Priority = child:GetAttribute("Priority") or 0
                };
            end;
        end;

        return v25;
    end;
end;

return u10;