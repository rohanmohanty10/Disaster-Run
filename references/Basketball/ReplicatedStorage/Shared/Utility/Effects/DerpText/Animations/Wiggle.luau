 
 

require(script.Parent.Parent.RichTextTypes);

return function(p1, p2) -- Line: 9
    p1.Visible = true;
    (p1:FindFirstChild("ImageLabel") or p1.TextLabel).Position = UDim2.fromScale(0.5, 0.5) + UDim2.new(0, 0, 0, math.sin(p2 * 3.141592653589793 * 2 * 2) * (30 * (1 - p2) * 0.4) / 2);
end;