 

return {
    ["start"] = function(_, p1, p2) --[[ Name: start, Line 3 ]]
        local v3 = script.Model:Clone()
        v3:PivotTo(CFrame.new(p2))
        v3:ScaleTo(p1:GetExtentsSize().Magnitude / 10)
        v3.Parent = workspace.Effects
        for _, v4 in v3:GetDescendants() do
            if v4:IsA("ParticleEmitter") then
                if v4.Name == "CakeColor" then
                    v4.Color = p1:GetAttribute("Color")
                end
                v4:Emit(v4:GetAttribute("EmitCount"))
            end
        end
        task.delay(2, v3.Destroy, v3)
    end
}