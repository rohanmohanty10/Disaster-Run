 

 

return {
    start = function(u1) -- Line: 6, Name: start
        u1.on("Toast", function(p2) -- Line: 7
            -- upvalues: u1 (copy)
            if type(p2) == "string" then
                u1.toast(p2);
            end;
        end);
        u1.on("Debug", function(p3) -- Line: 12
            if type(p3) == "string" then
                print("[Troll DEBUG] " .. p3);
            end;
        end);
    end
};