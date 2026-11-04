 
 

require(script.Parent.Parent.RichTextTypes);

return function(p1, p2, p3) -- Line: 7
    p1.Visible = true;
    local v4 = p1:FindFirstChild("ImageLabel") or p1.TextLabel;
    v4.Position = UDim2.fromScale(0.5, 0.5) + UDim2.new(0, p1.AbsoluteSize.X / 2, 0, p1.AbsoluteSize.Y / 2);
    v4.Rotation = p2 * 2 * 360;
end;