  

 

local TweenService = game:GetService("TweenService");

return {
    CreateTween = function(p1, u2, u3, p4) -- Line: 9, Name: CreateTween
        -- upvalues: TweenService (copy)
        local u5 = p4 == nil and 0 or p4;
        local u6 = nil;
        coroutine.wrap(function() -- Line: 14
            -- upvalues: u5 (ref), u2 (copy), u3 (copy), TweenService (ref), u6 (ref)
            wait(u5);

            if type(u2) ~= "table" then
                u6 = TweenService:Create(u2, u3[1], u3[2]);
                u6:Play();

                return u6;
            end;

            local v7 = 1;
            local v8 = {};

            for _, v in pairs(u2) do
                local v9 = u3[v7];
                local v10 = v7 + 1;
                v7 = v10 + 1;
                v8[v.Name] = TweenService:Create(v, v9, u3[v10]);
                v8[v.Name]:Play();
            end;

            return v8;
        end)();
    end
};