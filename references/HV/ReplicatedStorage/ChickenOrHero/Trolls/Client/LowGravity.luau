 

 

return {
    start = function(u1) -- Line: 7, Name: start
        local state = u1.state;

        local function target() -- Line: 10
            -- upvalues: state (copy), u1 (copy)
            local Attribute = state:GetAttribute("Gravity");

            if not (u1.exempt() or (type(Attribute) ~= "number" or Attribute <= 0)) then
                return Attribute;
            end;

            local Attribute2 = state:GetAttribute("NormalGravity");

            if type(Attribute2) ~= "number" or (Attribute2 <= 0 or not Attribute2) then
                Attribute2 = nil;
            end;

            return Attribute2;
        end;

        local function apply() -- Line: 19
            -- upvalues: target (copy)
            local v2 = target();

            if v2 and workspace.Gravity ~= v2 then
                workspace.Gravity = v2;
            end;
        end;

        workspace:GetPropertyChangedSignal("Gravity"):Connect(apply);
        state:GetAttributeChangedSignal("Gravity"):Connect(apply);
        state:GetAttributeChangedSignal("NormalGravity"):Connect(apply);
        u1.player:GetAttributeChangedSignal("TrollExempt"):Connect(apply);
        local v3 = target();

        if v3 and workspace.Gravity ~= v3 then
            workspace.Gravity = v3;
        end;
    end
};