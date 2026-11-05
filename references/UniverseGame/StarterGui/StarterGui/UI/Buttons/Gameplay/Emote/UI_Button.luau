  

 

return function(u1) -- Line: 1
    script.Parent.MouseButton1Down:Connect(function() -- Line: 29
        -- upvalues: u1 (copy)
        local _ = game:GetService("UserInputService").TouchEnabled;

        if u1.UI.Gameplay.EmotesV2.Visible then
            u1:CloseEmoteWheel();
        else
            u1:ShowEmoteWheel();
        end;

        u1:PlaySound("Click");
    end);
end;