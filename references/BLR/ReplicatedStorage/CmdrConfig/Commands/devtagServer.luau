  

return function(p1) -- Line: 1
    local Executor = p1.Executor;
    local Attribute = Executor:GetAttribute("isDev");
    Executor:SetAttribute("isDev", Attribute == nil and true or nil);

    return `{Attribute == nil and "Enabled" or "Disabled"} tag`;
end;