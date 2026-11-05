  

 

local Petal = require(game:GetService("ReplicatedStorage"):WaitForChild("ReplicatedModules"):WaitForChild("Petal"));
local u1 = Petal("New");
Petal("Util");
local u8 = {
    Shine = function(u2) -- Line: 7
        -- upvalues: u1 (copy)
        local u3 = u1("BillboardGui")({
            AlwaysOnTop = true,
            Size = UDim2.new(u2.Size, 0, u2.Size, 0),
            Parent = u2.Parent,
            Children = { u1("ImageLabel")({
                    Name = "DisplayImage",
                    BackgroundTransparency = 1,
                    ImageTransparency = 0,
                    Size = UDim2.new(1, 0, 1, 0),
                    Image = "rbxassetid://" .. u2.Image,
                    ImageColor3 = u2.Color
                }) }
        });
        local u4 = u3:FindFirstChildOfClass("ImageLabel");
        local u5 = math.random(1, 2);
        task.spawn(function() -- Line: 25
            -- upvalues: u2 (copy), u4 (copy), u5 (copy), u3 (copy)
            for _ = 0, 24 * u2.Delay do
                task.wait();
                u4.Rotation = u5 == 1 and u4.Rotation - u2.Rotation or u4.Rotation + u2.Rotation;
                local v6 = u3;
                v6.Size = v6.Size + UDim2.new(1 * u2.BonusSize / u2.Delay, 0, 1 * u2.BonusSize / u2.Delay, 0);
                local v7 = u4;
                v7.ImageTransparency = v7.ImageTransparency + 0.04 / u2.Delay;
            end;

            u3:Destroy();
        end);
    end
};

return function(p9) -- Line: 37
    -- upvalues: u8 (copy)
    if #p9 > 1 then
        for i = 1, #p9 do
            u8.Shine(p9[i]);
        end;

        return;
    end;

    u8.Shine(p9);
end;