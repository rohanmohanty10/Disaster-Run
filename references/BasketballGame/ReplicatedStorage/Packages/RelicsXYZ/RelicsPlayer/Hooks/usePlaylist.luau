 
 

local React = require(script.Parent.Parent.Parent.Shared.React);
local script_Parent = script.Parent;
local useSignal = require(script_Parent.useSignal);
local useAttribute = require(script_Parent.useAttribute);

return function(u1: userdata?) -- Line: 21, Name: usePlaylist
    -- upvalues: React (copy), useSignal (copy), useAttribute (copy)
    local v3, u4 = React.useState(function() -- Line: 22
        -- upvalues: u1 (copy)
        local v2 = u1 and u1:FindFirstAncestorOfClass("Player");

        return v2;
    end);
    local u6, u7 = React.useState(function() -- Line: 26
        -- upvalues: u1 (copy)
        local v5 = {};

        if u1 then
            for _, child in u1:GetChildren() do
                if child:HasTag("RelicsSong") then
                    local Attribute = child:GetAttribute("Id");

                    if Attribute and type(Attribute) == "string" then
                        table.insert(v5, Attribute);
                    end;
                end;
            end;
        end;

        return v5;
    end);
    local v8;

    if u1 then
        v8 = u1.ChildAdded;
    else
        v8 = u1;
    end;

    useSignal(v8, function(p9) -- Line: 44
        -- upvalues: u6 (copy), u7 (copy)
        if p9:HasTag("RelicsSong") then
            local Attribute = p9:GetAttribute("Id");

            if Attribute and not table.find(u6, Attribute) then
                local table_clone_ret = table.clone(u6);
                table.insert(table_clone_ret, Attribute);
                u7(table_clone_ret);
            end;
        end;
    end, { u1 });
    local v10;

    if u1 then
        v10 = u1.ChildRemoved;
    else
        v10 = u1;
    end;

    useSignal(v10, function(p11: userdata) -- Line: 56
        -- upvalues: u6 (copy), u7 (copy)
        if p11:HasTag("RelicsSong") then
            local Attribute = p11:GetAttribute("Id");
            local v12;

            if type(Attribute) == "string" then
                v12 = table.find(u6, Attribute);
            else
                v12 = nil;
            end;

            if v12 then
                local table_clone_ret = table.clone(u6);
                table.remove(table_clone_ret, v12);
                u7(table_clone_ret);
            end;
        end;
    end, { u1 });
    local v13;

    if u1 then
        v13 = u1.AncestryChanged;
    else
        v13 = u1;
    end;

    useSignal(v13, function() -- Line: 72
        -- upvalues: u1 (copy), u4 (copy)
        local v14 = u1 and u1:FindFirstAncestorOfClass("Player");
        u4(v14);
    end, { u1 });

    return {
        Name = u1 and (u1.Name or "") or "",
        Songs = u6,
        Id = useAttribute(u1, "Id", function(p15) -- Line: 81
            return type(p15) == "string" and p15 and p15 or "?";
        end),
        Image = useAttribute(u1, "Image", function(p16) -- Line: 85
            return type(p16) == "string" and p16 and p16 or "";
        end),
        IsActive = useAttribute(u1, "IsActive", function(p17) -- Line: 89
            return type(p17) == "boolean" and p17 and p17 or false;
        end),
        IsFree = useAttribute(u1, "IsFree", function(p18) -- Line: 93
            return type(p18) == "boolean" and p18 and p18 or false;
        end),
        Owner = v3
    };
end;