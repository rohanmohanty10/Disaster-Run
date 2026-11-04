  

local function defaultGuard(p1) -- Line: 3
    return true;
end;

return function(u2: userdata, u3: string, u4: function, u5: function?) -- Line: 44, Name: observeAttribute
    -- upvalues: defaultGuard (copy)
    local u6 = nil;
    local u7 = nil;
    local u8 = 0;

    if u5 == nil then
        u5 = defaultGuard;
    end;

    local function OnAttributeChanged() -- Line: 57
        -- upvalues: u6 (ref), u8 (ref), u2 (copy), u3 (copy), u5 (copy), u4 (copy), u7 (ref)
        if u6 ~= nil then
            task.spawn(u6);
            u6 = nil;
        end;

        u8 = u8 + 1;
        local u9 = u8;
        local Attribute = u2:GetAttribute(u3);

        if Attribute ~= nil and u5(Attribute) then
            task.spawn(function() -- Line: 69
                -- upvalues: u4 (ref), Attribute (copy), u9 (copy), u8 (ref), u7 (ref), u6 (ref)
                local v10 = u4(Attribute);

                if typeof(v10) == "function" then
                    if u9 == u8 and u7.Connected then
                        u6 = v10;

                        return;
                    end;

                    task.spawn(v10);
                end;
            end);
        end;
    end;

    u7 = u2:GetAttributeChangedSignal(u3):Connect(OnAttributeChanged);
    task.defer(function() -- Line: 86
        -- upvalues: u7 (ref), OnAttributeChanged (copy)
        if not u7.Connected then
            return;
        end;

        OnAttributeChanged();
    end);

    return function() -- Line: 95
        -- upvalues: u7 (ref), u6 (ref)
        u7:Disconnect();

        if u6 ~= nil then
            task.spawn(u6);
            u6 = nil;
        end;
    end;
end;