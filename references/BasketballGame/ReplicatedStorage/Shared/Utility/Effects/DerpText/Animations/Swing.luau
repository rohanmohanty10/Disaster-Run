 
 

require(script.Parent.Parent.RichTextTypes);

return function(p1, p2, p3) -- Line: 8
    p1.Visible = true;
    (p1:FindFirstChild("ImageLabel") or p1.TextLabel).Rotation = math.sin(p2 * 3.141592653589793 * 2 * 2) * (90 * (1 - p2) * 0.4);
end;