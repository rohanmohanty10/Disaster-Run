  

return function(p1) -- Line: 1
    local Executor = p1.Executor;
    local Attribute = Executor:GetAttribute("isStaff");
    Executor:SetAttribute("isStaff", Attribute == nil and true or nil);

    return `{Attribute == nil and "Enabled" or "Disabled"} tag`;
end;