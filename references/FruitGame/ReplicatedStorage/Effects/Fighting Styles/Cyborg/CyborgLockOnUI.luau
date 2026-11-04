 

return {
    ["start"] = function(_, p1, p2, p3) --[[ Name: start, Line 3 ]]
        if p2 and p3 then
            if p2.PrimaryPart and p3.PrimaryPart then
                if p1 then
                    while p1:IsDescendantOf(workspace) and (p2.PrimaryPart ~= nil and p3.PrimaryPart ~= nil) do
                        local v4 = (p2.PrimaryPart.Position - p3.PrimaryPart.Position).Magnitude / 5
                        p1.Size = UDim2.new(v4, 0, v4, 0)
                        task.wait()
                    end
                    p1:Destroy()
                end
            end
        else
            return
        end
    end
}