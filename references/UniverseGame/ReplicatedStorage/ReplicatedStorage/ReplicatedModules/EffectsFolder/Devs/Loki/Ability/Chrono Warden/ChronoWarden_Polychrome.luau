  

 

local Petal = _G.Petal;
local u1 = Petal("New");
local u2 = Petal("Util");

return function(...) -- Line: 6
    -- upvalues: u1 (copy), u2 (copy)
    local _, u3 = ...;
    local v4 = u1("Maid");

    if game:GetService("Lighting"):FindFirstChild("POLYCHROME") then
        game:GetService("Lighting"):FindFirstChild("POLYCHROME").Enabled = false;
    end;

    local u5 = u1("ColorCorrectionEffect")({
        Name = "POLYCHROME",
        Parent = game:GetService("Lighting")
    });
    local u6 = v4 + u5;
    u2.Tween(u5, u3 / 2, "Quad", "InOut", {
        Saturation = -2,
        Contrast = 0.5
    });
    task.delay(u3 / 2, function() -- Line: 23
        -- upvalues: u2 (ref), u5 (copy), u3 (copy), u6 (ref)
        u2.Tween(u5, u3 / 2, "Quad", "InOut", {
            Saturation = 0,
            Contrast = 0
        });
        task.wait(0.5);
        u6:Clean();
    end);
end;