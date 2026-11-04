 

return {
    ["start"] = function(_, p1) --[[ Name: start, Line 3 ]]
        local v2 = p1.Model
        local v3 = script[p1.VFX]:Clone()
        v3:ScaleTo(p1.Scale or v2:GetScale())
        v3:PivotTo(v2:GetPivot())
        v3.Parent = workspace.Effects
        _G.customEmit(v3)
        task.delay(5, v3.Destroy, v3)
    end
}