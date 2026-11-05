  

 

return function(u1, u2) -- Line: 1
    local StarterGui = game:GetService("StarterGui");
    local v3;

    repeat
        v3 = pcall(function() -- Line: 5
            -- upvalues: StarterGui (copy), u1 (copy), u2 (copy)
            StarterGui:SetCore("ChatMakeSystemMessage", {
                TextSize = 22,
                Text = u1,
                Color = u2 or Color3.fromRGB(255, 255, 0),
                Font = Enum.Font.SourceSansBold
            });
        end);
        task.wait();
    until v3;
end;