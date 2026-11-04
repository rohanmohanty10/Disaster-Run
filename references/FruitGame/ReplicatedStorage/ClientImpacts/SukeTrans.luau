 

return {
    ["start"] = function(_, p1) --[[ Name: start, Line 5 ]]
        local u2 = p1:GetDescendants()
        local u3 = {}
        local u4 = false
        for u5 = 1, #u2 do
            if (u2[u5]:IsA("BasePart") or u2[u5]:IsA("Decal")) and (u2[u5].Transparency ~= 1 or u2[u5]:GetAttribute("SukeTransparency") ~= nil) then
                local u6 = u2[u5]
                if u2[u5]:IsA("BasePart") then
                    u3[u6] = {
                        ["mat"] = u6.Material
                    }
                    if u2[u5].Transparency ~= 0 and u2[u5]:GetAttribute("SukeTransparency") == nil then
                        u3[u6].trans = u6.Transparency
                    end
                end
                task.spawn(function() --[[ Line: 18 ]]
                    --[[
                    Upvalues:
                        [1] = u4
                        [2] = u2
                        [3] = u5
                        [4] = u6
                    --]]
                    task.wait(0.275)
                    if u4 ~= true then
                        if u2[u5]:IsA("BasePart") then
                            u6.Material = Enum.Material.Glass
                        end
                        u6.Transparency = 0.9
                    end
                end)
            end
        end
        local u7 = Instance.new("BindableEvent", script)
        u7.Event:Connect(function() --[[ Line: 31 ]]
            --[[
            Upvalues:
                [1] = u4
                [2] = u7
                [3] = u3
            --]]
            u4 = true
            u7:Destroy()
            for v8, v9 in u3 do
                v8.Transparency = 0
                if v9.trans and v8:IsA("Decal") == false then
                    v8.Transparency = v9.trans
                end
                if v8:IsA("BasePart") then
                    v8.Material = v9.mat
                end
            end
            u3 = nil
        end)
        return u7
    end
}