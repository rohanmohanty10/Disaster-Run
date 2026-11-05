script.Parent.MouseButton1Click:Connect(function()
	script.Parent.Parent.Parent.Parent.Enabled = false
	game.ReplicatedStorage.Remotes.Comunicator.Set:FireServer("CloseLog")
end)