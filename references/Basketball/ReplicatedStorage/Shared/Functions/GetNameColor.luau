 
 

return function(p1) -- Line: 1
    local u2 = {
        Color3.new(0.9921568627450981, 0.1607843137254902, 0.2627450980392157),
        Color3.new(0.00392156862745098, 0.6352941176470588, 1),
        Color3.new(0.00784313725490196, 0.7215686274509804, 0.3411764705882353),
        BrickColor.new("Bright violet").Color,
        BrickColor.new("Bright orange").Color,
        BrickColor.new("Bright yellow").Color,
        BrickColor.new("Light reddish violet").Color,
        BrickColor.new("Brick yellow").Color
    };

    local function GetNameValue(p3) -- Line: 14
        local v4 = 0;

        for i = 1, #p3 do
            local string_sub_ret = string.sub(p3, i, i);
            local string_byte_ret = string.byte(string_sub_ret);
            local v5 = #p3 - i + 1;

            if #p3 % 2 == 1 then
                v5 = v5 - 1;
            end;

            if v5 % 4 >= 2 then
                string_byte_ret = -string_byte_ret;
            end;

            v4 = v4 + string_byte_ret;
            local _ = i;
        end;

        return v4;
    end;

    local function ComputeNameColor(p6) -- Line: 31
        -- upvalues: u2 (copy), GetNameValue (copy)
        return u2[(GetNameValue(p6) + 0) % #u2 + 1];
    end;

    return u2[(GetNameValue(p1) + 0) % #u2 + 1];
end;