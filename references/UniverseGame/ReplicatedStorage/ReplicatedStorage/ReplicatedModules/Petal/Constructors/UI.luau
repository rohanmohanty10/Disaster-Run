  

 

return function(p1) -- Line: 2
    local u2, _ = p1("Extensions");
    local u3 = p1("New");

    return {
        line2D = function(p4, p5, p6, p7) -- Line: 8
            -- upvalues: u3 (copy), u2 (copy)
            local v8 = p4:Lerp(p5, 0.5);

            return u3("Frame")({
                BorderSizePixel = 0,
                Size = UDim2.new(0, (p4 - p5).Magnitude + 1, 0, p7 or 3 or 3),
                Position = UDim2.new(0, v8.X + 3, 0, v8.Y),
                AnchorPoint = Vector2.new(0.5, 0.5),
                Rotation = u2.Deg(u2.Atan2(p5.Y - p4.Y, p5.X - p4.X)),
                BackgroundColor3 = Color3.new(1, 1, 1),
                Parent = p6 or nil
            });
        end
    };
end;