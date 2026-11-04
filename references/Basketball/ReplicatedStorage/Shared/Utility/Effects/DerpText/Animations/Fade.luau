 
 

require(script.Parent.Parent.RichTextTypes);

return function(p1, p2, p3) -- Line: 4
    p1.Visible = true;
    local v4 = 1 - p2 * (1 - p3.Transparency);
    local ImageLabel = p1:FindFirstChild("ImageLabel");

    if ImageLabel then
        ImageLabel.ImageTransparency = v4;

        return;
    end;

    p1.TextLabel.TextTransparency = v4;
end;