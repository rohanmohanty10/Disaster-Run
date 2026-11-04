 
 

require(script.Parent.Parent.RichTextTypes);
local Random_new_ret = Random.new();

return function(p1, p2, p3) -- Line: 13
    -- upvalues: Random_new_ret (copy)
    p1.Visible = true;
    local v4 = Random_new_ret:NextInteger(-10, 10) * (1 - p2);
    p1.TextLabel.Position = UDim2.fromScale(0.5, 0.5) + UDim2.new(0, v4, 0, math.sin(p2 * 3.141592653589793 * 2 * 4) * (9 * (1 - p2)) / 2);

    if p3.TextStrokeColor then
        p1.TextLabel.UIStroke.Color = p3.TextStrokeColor;
    end;
end;