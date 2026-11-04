 
 

require(script.Parent.Parent.RichTextTypes);

return function(p1, p2, p3) -- Line: 7
    p1.Visible = true;
    local Color3_fromHSV_ret = Color3.fromHSV(p2 * 2 % 1, 1, 1);
    local TextColor = p3.TextColor;
    local ImageLabel = p1:FindFirstChild("ImageLabel");

    if ImageLabel then
        ImageLabel.ImageColor3 = Color3_fromHSV_ret:Lerp(TextColor, p2);

        return;
    end;

    p1.TextLabel.TextColor3 = Color3_fromHSV_ret:Lerp(TextColor, p2);
end;