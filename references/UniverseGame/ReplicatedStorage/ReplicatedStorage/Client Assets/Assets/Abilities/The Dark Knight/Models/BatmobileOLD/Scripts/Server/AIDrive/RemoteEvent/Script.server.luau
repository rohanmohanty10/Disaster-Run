  

 

game.UserInputService.InputBegan:Connect(function(p1) -- Line: 1
    if p1.KeyCode == Enum.KeyCode.E then
        script.Parent:FireServer();
    end;
end);